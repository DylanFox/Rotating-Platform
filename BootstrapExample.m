%Bootstrapping example 
[M1778_TrialTypeSpeed,TID1,TID2] = findgroups(filt_M1778.trialtype,filt_M1778.Speed) %Split into unique groups of trial type and speed
bootstat1 = bootstrp(10000,@mean,filt_M1778.mMGA(M1778_TrialTypeSpeed==1));  %Start bootstrap for each group 
bootstat2 = bootstrp(10000,@mean,filt_M1778.mMGA(M1778_TrialTypeSpeed==2));
bootstat3 = bootstrp(10000,@mean,filt_M1778.mMGA(M1778_TrialTypeSpeed==3));
bootstat4 = bootstrp(10000,@mean,filt_M1778.mMGA(M1778_TrialTypeSpeed==4));
bootstat5 = bootstrp(10000,@mean,filt_M1778.mMGA(M1778_TrialTypeSpeed==5));
bootstat6 = bootstrp(10000,@mean,filt_M1778.mMGA(M1778_TrialTypeSpeed==6));
figure(4) %Draw figures comparing groups you need. 
histogram(bootstat1,30)
hold on
histogram(bootstat4,30)
figure (5)
histogram(bootstat2,30)
hold on
histogram(bootstat5,30)
figure (6)
histogram(bootstat3,30)
hold on
histogram(bootstat6,30)