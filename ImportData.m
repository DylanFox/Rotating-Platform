function x = ImportData(~)
%Used to import multiple text files generated from Tracker Software
%(v4.9.8) into a tabular format. Files are imported, stripped into their
%individual components and then passed through a noise filter (2nd pass
%butterworth)

% Three txt files were generated from a single tracker video - X_thumbdata,
% X_indexdata and Grip aperture. This code imports these and ensures each
% video (or trial) is separated by rows while each parameter is sorted by
% columns

%This function uses the normalize_var function so make sure it is within
%the file path.


%Ensure files you are importing are in the current folder directory, these
%were taken from a GOPRO camera which adds a prefix of 'GOPR' which this
%accounts for. This can be changed to whatever file naming format you
%choose.

%KinematicTable = ReachGraspImport; 
%This will produce a N x 
%------------IMPORT------------%
x = dir('GOPR*_*.txt');
nfiles = length(x);

%not sure how to preallocate this block
data = [];

for k = 1:nfiles
   data = [data; importdata(x(k).name)];
end
t = struct2table(data);

%Separate the fields to the one we want (which is the data)
datatable = t.data;

%Separate MGA, Velocity and foodwidth into separate categories
%Sort folder according to type to have all .txt
%files in the same line
AngleTrials = datatable(1:4:end);
IndexTrials = datatable(2:4:end);
MgaTrials = datatable(3:4:end);
ThumbTrials = datatable(4:4:end);
x = table(MgaTrials,ThumbTrials,IndexTrials,AngleTrials);

%------------STRIP VELOCITY, X/Y POSN and ACCEL data------------%
%Strip thumb data
for i = 1:height(x) 
x.thumbvelocity{i,1} = x.ThumbTrials{i,1}(:,[1,4]);%Velocity
x.thumbaccel{i,1} = x.ThumbTrials{i,1}(:,[1,5]); %Accel
x.thumbXYposn{i,1} = x.ThumbTrials{i,1}(:,[2,3]); %X/Y Posn
%Strip index data
x.indexvelocity{i,1} = x.IndexTrials{i,1}(:,[1,4]);%Velocity
x.indexaccel{i,1} = x.IndexTrials{i,1}(:,[1,5]); %Accel
x.indexXYposn{i,1} = x.IndexTrials{i,1}(:,[2,3]); %X/Y Posn
end
%Remove redundant columns
x.ThumbTrials = [];
x.IndexTrials = [];

%------------Normalisation------------%
%Normalize time data into a percentage from 0-100
%This is required to generate average curves but total time will still be
%available for analysis
for i = 1:height(x) 
x.MgaTrials{i,1}(:,1) = normalize_var(x.MgaTrials{i,1}(:,1),0,100);
x.thumbvelocity{i,1}(:,1) = normalize_var(x.thumbvelocity{i,1}(:,1),0,100);
x.indexvelocity{i,1}(:,1) = normalize_var(x.indexvelocity{i,1}(:,1),0,100);
x.thumbaccel{i,1}(:,1) = normalize_var(x.thumbaccel{i,1}(:,1),0,100);
x.indexaccel{i,1}(:,1) = normalize_var(x.indexaccel{i,1}(:,1),0,100);
end

%------------Noise Filtering------------%
%2nd order dual pass low butterworth filter to smooth the data.
%To account for the NaNs in velocity and accel readouts
%use (2:end-1,2)and (3:end-2,2) resepectively when indexing
%otherwise just use (:,2) for mga trials

sf = 240; %sample freq = 240 (frame rate)
cf = 10; %cutoff freq = 10 (from journals)
[b,a] = butter(1,cf/(sf/2)); 
for i = 1:height(x) 
x.thumbvelocity{i,1}(2:end-1,2) = filtfilt(b,a,x.thumbvelocity{i,1}(2:end-1,2));
x.indexvelocity{i,1}(2:end-1,2) = filtfilt(b,a,x.indexvelocity{i,1}(2:end-1,2));
x.MgaTrials{i,1}(:,2) = filtfilt(b,a,x.MgaTrials{i,1}(:,2));
x.thumbaccel{i,1}(3:end-2,2) = filtfilt(b,a,x.thumbaccel{i,1}(3:end-2,2));
x.indexaccel{i,1}(3:end-2,2) = filtfilt(b,a,x.indexaccel{i,1}(3:end-2,2));
end

%Loops through each table to enter in MGA, mVelocity and time to each (%)
% from each trial (row) 
nfiles = height(x);
sec_frame = 1/240; %seconds per frame
for i = 1:nfiles

%------------Total Time-------------%
x.totaltime(i)= (size(x.MgaTrials{i,1}(:,1),1)*sec_frame*1000);

%------------MGA------------%
[x.mMGA(i), x.mMGAFrame(i)] = max(x.MgaTrials{i,1}(:,2)); %find mMGA/frame
%a and b corrospond to filling T2MGA trials
a = find(x.MgaTrials{i,1}(:,2)== max(x.MgaTrials{i,1}(:,2)));
b = length(x.MgaTrials{i,1}(:,2));
x.T2mMGA_pcnt(i) = a/b*100; %time 2 peak(%)
x.T2mMGA_ms(i) = x.mMGAFrame(i)*sec_frame*1000; %time to peak (ms) 
x.mMGA2end_ms(i) = x.totaltime(i) - x.T2mMGA_ms(i); %Peak to end (ms) 
x.mMGA2end_pcnt(i) = 100 - x.T2mMGA_pcnt(i); %Peak to end (%)

%------------Velocity------------%
%For thumb
[x.thumb_mVeloc(i), x.thumb_mVelocFrame(i)] = max(x.thumbvelocity{i,1}(:,2)); %find mVelocity/frame
%c and d corrospond to filling T2velocity trials
c = find(x.thumbvelocity{i,1}(:,2)== max(x.thumbvelocity{i,1}(:,2)));
d = length(x.thumbvelocity{i,1}(:,2));
x.thumb_T2mVeloc_pcnt(i) = c/d*100; %time to peak (%)
x.thumb_T2mVeloc_ms(i) = x.thumb_mVelocFrame(i)*sec_frame*1000; %time to peak (ms) 
x.thumb_mVeloc2end_ms(i) = x.totaltime(i) - x.thumb_T2mVeloc_ms(i); %Peak to end (ms)
x.thumb_mVeloc2end_pcnt(i) = 100 - x.thumb_T2mVeloc_pcnt(i); %Peak to end (%)

%For index 
[x.index_mVeloc(i), x.index_mVelocFrame(i)] = max(x.indexvelocity{i,1}(:,2)); %find mVelocity/frame

%c and d corrospond to filling T2velocity trials
cc = find(x.indexvelocity{i,1}(:,2)== max(x.indexvelocity{i,1}(:,2)));
dd = length(x.indexvelocity{i,1}(:,2));
x.index_T2mVeloc_pcnt(i) = cc/dd*100; %time to peak (%)
x.index_T2mVeloc_ms(i) = x.index_mVelocFrame(i)*sec_frame*1000; %time to peak (ms) 
x.index_mVeloc2end_ms(i) = x.totaltime(i) - x.index_T2mVeloc_ms(i); %Peak to end (ms)
x.index_mVeloc2end_pcnt(i) = 100 - x.index_T2mVeloc_pcnt(i); %Peak to end (%)


%------------Acceleration-------------------
%Thumb
[x.thumb_mAccel(i), x.thumb_mAccelFrame(i)] = max(x.thumbaccel{i,1}(:,2)); %find mAccel
%e and f corrospond to filling T2velocity trials

e = find(x.thumbaccel{i,1}(:,2)== max(x.thumbaccel{i,1}(:,2)));
f = length(x.thumbaccel{i,1}(:,2));
x.thumb_T2mAccel_pcnt(i) = e/f*100; %time to peak (%)
x.thumb_T2mAccel_ms(i) = x.thumb_mAccelFrame(i)*sec_frame*1000; %time to peak (ms) 
x.thumb_mAccel2end_ms(i) = x.totaltime(i) - x.thumb_T2mAccel_ms(i); %peak to end (ms)
x.thumb_mAccel2end_pcnt(i) = 100 - x.thumb_T2mAccel_pcnt(i); %peak to end (%)


%Index
[x.index_mAccel(i), x.index_mAccelFrame(i)] = max(x.indexaccel{i,1}(:,2)); %find mAccel
%e and f corrospond to filling T2velocity trials

ee = find(x.indexaccel{i,1}(:,2)== max(x.indexaccel{i,1}(:,2)));
ff = length(x.indexaccel{i,1}(:,2));
x.index_T2mAccel_pcnt(i) = ee/ff*100; %time to peak (%)
x.index_T2mAccel_ms(i) = x.index_mAccelFrame(i)*sec_frame*1000; %time to peak (ms) 
x.index_mAccel2end_ms(i) = x.totaltime(i) - x.index_T2mAccel_ms(i); %peak to end (ms)
x.index_mAccel2end_pcnt(i) = 100 - x.index_T2mAccel_pcnt(i); %peak to end (%)
end
%remove unnecessary columns after calc 
x.thumb_mVelocFrame = [];
x.index_mVelocFrame = []; 
x.thumb_mAccelFrame = []; 
x.index_mAccelFrame = [];
x.mMGAFrame = [];
end 