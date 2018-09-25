function [unfilt,filt] = WoF_ImportData(~)
%Used to import multiple text files generated from Tracker Software
%(v4.9.8) into a tabular format. Files are imported, stripped into their
%individual components and then passed through a noise filter (butterworth)
%This function uses the normalize_var function so make sure 
%it is within the file path. 

%------------IMPORT------------%
unfilt = dir('GOPR*_*_normal.txt');  %change this to _normal or _fail depending and change category down the bottom
nfiles = length(unfilt); 

%not sure how to preallocate this block
data = [];

for k = 1:nfiles
   data = [data; importdata(unfilt(k).name)];
end
t = struct2table(data);

%Separate the fields to the one we want (which is the data)
datatable = t.data;

%Separate MGA, Velocity and Angle into separate categories
%Sort folder according to type to have all .txt
%files in the same line
AngleTrials = datatable(1:4:end);
IndexTrials = datatable(2:4:end);
MgaTrials = datatable(3:4:end);
ThumbTrials = datatable(4:4:end);
unfilt = table(MgaTrials,ThumbTrials,IndexTrials,AngleTrials);

%------------STRIP VELOCITY, X/Y POSN and ACCEL data------------%
%Strip thumb data
for i = 1:height(unfilt) 
unfilt.thumbvelocity{i,1} = unfilt.ThumbTrials{i,1}(:,[1,4]);%Velocity
unfilt.thumbaccel{i,1} = unfilt.ThumbTrials{i,1}(:,[1,5]); %Accel
unfilt.thumbXYposn{i,1} = unfilt.ThumbTrials{i,1}(:,[2,3]); %X/Y Posn
%Strip index data
unfilt.indexvelocity{i,1} = unfilt.IndexTrials{i,1}(:,[1,4]);%Velocity
unfilt.indexaccel{i,1} = unfilt.IndexTrials{i,1}(:,[1,5]); %Accel
unfilt.indexXYposn{i,1} = unfilt.IndexTrials{i,1}(:,[2,3]); %X/Y Posn
%Strip angle data
unfilt.AngleTrials{i,1} = unfilt.AngleTrials{i,1}([1,end],2);
%unfilt.AngleDifference{i,1} = unfilt.AngleTrials
end
%Remove redundant columns
unfilt.ThumbTrials = [];
unfilt.IndexTrials = [];

%------------Normalisation------------%
%Normalize time data into a percentage from 0-100
%This is required to generate average curves but total time will still be
%available for analysis
for i = 1:height(unfilt) 
unfilt.MgaTrials{i,1}(:,1) = normalize_var(unfilt.MgaTrials{i,1}(:,1),0,100);
unfilt.thumbvelocity{i,1}(:,1) = normalize_var(unfilt.thumbvelocity{i,1}(:,1),0,100);
unfilt.indexvelocity{i,1}(:,1) = normalize_var(unfilt.indexvelocity{i,1}(:,1),0,100);
unfilt.thumbaccel{i,1}(:,1) = normalize_var(unfilt.thumbaccel{i,1}(:,1),0,100);
unfilt.indexaccel{i,1}(:,1) = normalize_var(unfilt.indexaccel{i,1}(:,1),0,100);
end

%------------Noise Filtering------------%
%2nd order dual pass low butterworth filter to smooth the data.
%To account for the NaNs in velocity and accel readouts
%use (2:end-1,2)and (3:end-2,2) resepectively when indexing
%otherwise just use (:,2) for mga trials

sf = 240; %sample freq = 240 (frame rate)
cf = 10; %cutoff freq = 10 (from journals)
[b,a] = butter(1,cf/(sf/2)); 
filt = unfilt;
for i = 1:height(filt) 
filt.thumbvelocity{i,1}(2:end-1,2) = filtfilt(b,a,filt.thumbvelocity{i,1}(2:end-1,2));
filt.indexvelocity{i,1}(2:end-1,2) = filtfilt(b,a,filt.indexvelocity{i,1}(2:end-1,2));
filt.MgaTrials{i,1}(:,2) = filtfilt(b,a,filt.MgaTrials{i,1}(:,2));
filt.thumbaccel{i,1}(3:end-2,2) = filtfilt(b,a,filt.thumbaccel{i,1}(3:end-2,2));
filt.indexaccel{i,1}(3:end-2,2) = filtfilt(b,a,filt.indexaccel{i,1}(3:end-2,2));
end
%------------------------------------------------------------------------
%Loops through each table to enter in MGA, mVelocity and time to each (%)
% from each trial (row) 
%------------------------------------------------------------------------
nfiles = height(filt);
sec_frame = 1/240; %seconds per frame
for i = 1:nfiles

%------------Total Time-------------%
filt.totaltime(i)= (size(filt.MgaTrials{i,1}(:,1),1)*sec_frame*1000);

%------------MGA------------%
[filt.mMGA(i), filt.mMGAFrame(i)] = max(filt.MgaTrials{i,1}(:,2)); %find mMGA/frame
%a and b corrospond to filling T2MGA trials
a = find(filt.MgaTrials{i,1}(:,2)== max(filt.MgaTrials{i,1}(:,2)));
b = length(filt.MgaTrials{i,1}(:,2));
filt.T2mMGA_pcnt(i) = a/b*100; %time 2 peak(%)
filt.T2mMGA_ms(i) = filt.mMGAFrame(i)*sec_frame*1000; %time to peak (ms) 
filt.mMGA2end_ms(i) = filt.totaltime(i) - filt.T2mMGA_ms(i); %Peak to end (ms) 
filt.mMGA2end_pcnt(i) = 100 - filt.T2mMGA_pcnt(i); %Peak to end (%)

%------------Velocity------------%
%For thumb
[filt.thumb_mVeloc(i), filt.thumb_mVelocFrame(i)] = max(filt.thumbvelocity{i,1}(:,2)); %find mVelocity/frame
%c and d corrospond to filling T2velocity trials
c = find(filt.thumbvelocity{i,1}(:,2)== max(filt.thumbvelocity{i,1}(:,2)));
d = length(filt.thumbvelocity{i,1}(:,2));
filt.thumb_T2mVeloc_pcnt(i) = c/d*100; %time to peak (%)
filt.thumb_T2mVeloc_ms(i) = filt.thumb_mVelocFrame(i)*sec_frame*1000; %time to peak (ms) 
filt.thumb_mVeloc2end_ms(i) = filt.totaltime(i) - filt.thumb_T2mVeloc_ms(i); %Peak to end (ms)
filt.thumb_mVeloc2end_pcnt(i) = 100 - filt.thumb_T2mVeloc_pcnt(i); %Peak to end (%)

%For index 
[filt.index_mVeloc(i), filt.index_mVelocFrame(i)] = max(filt.indexvelocity{i,1}(:,2)); %find mVelocity/frame
%c and d corrospond to filling T2velocity trials
cc = find(filt.indexvelocity{i,1}(:,2)== max(filt.indexvelocity{i,1}(:,2)));
dd = length(filt.indexvelocity{i,1}(:,2));
filt.index_T2mVeloc_pcnt(i) = cc/dd*100; %time to peak (%)
filt.index_T2mVeloc_ms(i) = filt.index_mVelocFrame(i)*sec_frame*1000; %time to peak (ms) 
filt.index_mVeloc2end_ms(i) = filt.totaltime(i) - filt.index_T2mVeloc_ms(i); %Peak to end (ms)
filt.index_mVeloc2end_pcnt(i) = 100 - filt.index_T2mVeloc_pcnt(i); %Peak to end (%)


%------------Acceleration-------------------
%Thumb
[filt.thumb_mAccel(i), filt.thumb_mAccelFrame(i)] = max(filt.thumbaccel{i,1}(:,2)); %find mAccel
%e and f corrospond to filling T2velocity trials
e = find(filt.thumbaccel{i,1}(:,2)== max(filt.thumbaccel{i,1}(:,2)));
f = length(filt.thumbaccel{i,1}(:,2));
filt.thumb_T2mAccel_pcnt(i) = e/f*100; %time to peak (%)
filt.thumb_T2mAccel_ms(i) = filt.thumb_mAccelFrame(i)*sec_frame*1000; %time to peak (ms) 
filt.thumb_mAccel2end_ms(i) = filt.totaltime(i) - filt.thumb_T2mAccel_ms(i); %peak to end (ms)
filt.thumb_mAccel2end_pcnt(i) = 100 - filt.thumb_T2mAccel_pcnt(i); %peak to end (%)

%Index
[filt.index_mAccel(i), filt.index_mAccelFrame(i)] = max(filt.indexaccel{i,1}(:,2)); %find mAccel
%e and f corrospond to filling T2velocity trials
ee = find(filt.indexaccel{i,1}(:,2)== max(filt.indexaccel{i,1}(:,2)));
ff = length(filt.indexaccel{i,1}(:,2));
filt.index_T2mAccel_pcnt(i) = ee/ff*100; %time to peak (%)
filt.index_T2mAccel_ms(i) = filt.index_mAccelFrame(i)*sec_frame*1000; %time to peak (ms) 
filt.index_mAccel2end_ms(i) = filt.totaltime(i) - filt.index_T2mAccel_ms(i); %peak to end (ms)
filt.index_mAccel2end_pcnt(i) = 100 - filt.index_T2mAccel_pcnt(i); %peak to end (%)
end

%Add trial type 
for i = 1:height(filt)
filt.trialtype{i} = 'Normal';
end

%remove unnecessary columns after calc 
filt.thumb_mVelocFrame = [];
filt.index_mVelocFrame = []; 
filt.thumb_mAccelFrame = []; 
filt.index_mAccelFrame = [];
filt.mMGAFrame = [];
end 