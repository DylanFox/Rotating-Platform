 %This script is used to normalise prehensile profiles into percentages and
%then generate an average curve for each group for qualitative comparisons 
% Dependencies - shadedErrorBar, DataPrep_ErrorShade 

% Notes: Square root numbers can be changed to the length/# of trials - this used
% to calculate SEM 
%% Normalise trial data onto 100 points to represent a percentage of the prehensile movement 
timei = linspace(0,100);
for i = 1:height(AllAnimals_filt)
AllAnimals_filt.mgainterp{i} = interp1(AllAnimals_filt.MgaTrials{i}(:,1),AllAnimals_filt.MgaTrials{i}(:,2),timei(:),'linear','extrap');
AllAnimals_filt.velocinterp{i} = interp1(AllAnimals_filt.thumbvelocity{i}(2:end-1,1),AllAnimals_filt.thumbvelocity{i}(2:end-1,2),timei(:),'linear','extrap');
AllAnimals_filt.accelinterp{i} = interp1(AllAnimals_filt.thumbaccel{i}(3:end-2,1),AllAnimals_filt.thumbaccel{i}(3:end-2,2),timei(:),'linear','extrap');
end

%% Set up variables for plotting Experiment 1 (Efron) 
MGA_Control = AllAnimals_filt.mgainterp(AllAnimals_filt.cohort == 'Control');
MGA_PImV1 = AllAnimals_filt.mgainterp(AllAnimals_filt.cohort == 'PIm + V1');
MGA_LGNV1 = AllAnimals_filt.mgainterp(AllAnimals_filt.cohort == 'LGN + V1');


MGA_Control_mat = DataPrep_ErrorShade(MGA_Control);
MGA_PImV1_mat = DataPrep_ErrorShade(MGA_PImV1);
MGA_LGNV1_mat = DataPrep_ErrorShade(MGA_LGNV1);


Veloc_Control = AllAnimals_filt.velocinterp(AllAnimals_filt.cohort == 'Control',:);
Veloc_PImV1 = AllAnimals_filt.velocinterp(AllAnimals_filt.cohort == 'PIm + V1',:);
Veloc_LGNV1 = AllAnimals_filt.velocinterp(AllAnimals_filt.cohort == 'LGN + V1',:);


Veloc_Control_mat = DataPrep_ErrorShade(Veloc_Control);
Veloc_PImV1_mat = DataPrep_ErrorShade(Veloc_PImV1);
Veloc_LGNV1_mat = DataPrep_ErrorShade(Veloc_LGNV1);


Accel_Control = AllAnimals_filt.accelinterp(AllAnimals_filt.cohort == 'Control',:);
Accel_PImV1 = AllAnimals_filt.accelinterp(AllAnimals_filt.cohort == 'PIm + V1',:);
Accel_LGNV1 = AllAnimals_filt.accelinterp(AllAnimals_filt.cohort == 'LGN + V1',:);


Accel_Control_mat = DataPrep_ErrorShade(Accel_Control);
Accel_PImV1_mat = DataPrep_ErrorShade(Accel_PImV1);
Accel_LGNV1_mat = DataPrep_ErrorShade(Accel_LGNV1);


%% Plot Profiles
%Plot grip aperture profiles
figure('Name','Grip Aperture Profile');
shadedErrorBar(timei,mean(MGA_Control_mat,1),std(MGA_Control_mat)/sqrt((height(F1511_filt)+height(F1565_filt))),'lineprops','b');
hold on 
shadedErrorBar(timei,mean(MGA_PImV1_mat,1),std(MGA_PImV1_mat)/sqrt((height(F1777_filt)+height(M1778_filt))),'lineprops','r');
shadedErrorBar(timei,mean(MGA_LGNV1_mat,1),std(MGA_LGNV1_mat)/sqrt((height(F1866_filt)+height(M1867_filt))),'lineprops','g');

figure('Name','Velocity Profile');
shadedErrorBar(timei,mean(Veloc_Control_mat,1),std(Veloc_Control_mat)/sqrt((height(F1511_filt)+height(F1565_filt))),'lineprops','b');
hold on 
shadedErrorBar(timei,mean(Veloc_PImV1_mat,1),std(Veloc_PImV1_mat)/sqrt((height(F1777_filt)+height(M1778_filt))),'lineprops','r');
shadedErrorBar(timei,mean(Veloc_LGNV1_mat,1),std(Veloc_LGNV1_mat)/sqrt((height(F1866_filt)+height(M1867_filt))),'lineprops','g');

figure('Name','Acceleration Profile');
shadedErrorBar(timei,mean(Accel_Control_mat,1),std(Accel_Control_mat)/sqrt((height(F1511_filt)+height(F1565_filt))),'lineprops','b');
hold on 
shadedErrorBar(timei,mean(Accel_PImV1_mat,1),std(Accel_PImV1_mat)/sqrt((height(F1777_filt)+height(M1778_filt))),'lineprops','r');
shadedErrorBar(timei,mean(Accel_LGNV1_mat,1),std(Accel_LGNV1_mat)/sqrt((height(F1866_filt)+height(M1867_filt))),'lineprops','g');
