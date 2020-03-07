%Bootstrapping example 
AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'Control')
bootstat_control_mga = bootstrp(10000,@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'Control'));
bootstat_pimv1_mga = bootstrp(10000,@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'PIm + V1'));
bootstat_lgnv1_mga = bootstrp(10000,@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'LGN + V1'));
figure('Name','MGA Distributed Means')
histogram(bootstat_control_mga,30)
hold on
histogram(bootstat_pimv1_mga,30)
histogram(bootstat_lgnv1_mga,30)