[CI_Control_MGA, bootstat_control_mga] = bootci(10000,{@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_MGA, bootstat_PIm_mga]  = bootci(10000,{@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_MGA,bootstat_LGN_mga]  = bootci(10000,{@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_mga = mean(bootstat_control_mga); 
bmu_PIm_mga = mean(bootstat_PIm_mga);
bmu_LGN_mga = mean(bootstat_LGN_mga);

figure('Name','Bootstrapped Distribution of MGA Mean') 
histogram(bootstat_control_mga,30,'Normalization','probability')
hold on 
histogram(bootstat_PIm_mga,30,'Normalization','probability')
histogram(bootstat_LGN_mga,30,'Normalization','probability')
xline(bmu_control_mga,'k-',sprintf('%.2f',bmu_control_mga),'LineWidth',2,'FontSize',12)
xline(CI_Control_MGA(1),'b--',sprintf('%.2f',CI_Control_MGA(1)),'LineWidth',2,'FontSize',12)
xline(CI_Control_MGA(2),'b--',sprintf('%.2f',CI_Control_MGA(2)),'LineWidth',2,'FontSize',12)

xline(bmu_PIm_mga,'k-',sprintf('%.2f',bmu_PIm_mga),'LineWidth',2,'FontSize',12)
xline(CI_PIm_MGA(1),'r--',sprintf('%.2f',CI_PIm_MGA(1)),'LineWidth',2,'FontSize',12)
xline(CI_PIm_MGA(2),'r--',sprintf('%.2f',CI_PIm_MGA(2)),'LineWidth',2,'FontSize',12)

xline(bmu_LGN_mga,'k-',sprintf('%.2f',bmu_LGN_mga),'LineWidth',2,'FontSize',12)
xline(CI_LGN_MGA(1),'y--',sprintf('%.2f',CI_LGN_MGA(1)),'LineWidth',2,'FontSize',12)
xline(CI_LGN_MGA(2),'y--',sprintf('%.2f',CI_LGN_MGA(2)),'LineWidth',2,'FontSize',12)



%% Total Time 
[CI_Control_totaltime, bootstat_control_totaltime] = bootci(10000,{@mean,AllAnimals_filt.totaltime(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_totaltime, bootstat_PIm_totaltime]  = bootci(10000,{@mean,AllAnimals_filt.totaltime(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_totaltime,bootstat_LGN_totaltime]  = bootci(10000,{@mean,AllAnimals_filt.totaltime(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_totaltime = mean(bootstat_control_totaltime); 
bmu_PIm_totaltime = mean(bootstat_PIm_totaltime);
bmu_LGN_totaltime = mean(bootstat_LGN_totaltime);

figure('Name','Bootstrapped Distribution of Time to Completion Mean') 
histogram(bootstat_control_totaltime,30,'Normalization','probability')
hold on 
histogram(bootstat_PIm_totaltime,30,'Normalization','probability')
histogram(bootstat_LGN_totaltime,30,'Normalization','probability')
xline(bmu_control_totaltime,'k-',sprintf('%.2f',bmu_control_totaltime),'LineWidth',2,'FontSize',12)
xline(CI_Control_totaltime(1),'b--',sprintf('%.2f',CI_Control_totaltime(1)),'LineWidth',2,'FontSize',12)
xline(CI_Control_totaltime(2),'b--',sprintf('%.2f',CI_Control_totaltime(2)),'LineWidth',2,'FontSize',12)

xline(bmu_PIm_totaltime,'k-',sprintf('%.2f',bmu_PIm_totaltime),'LineWidth',2,'FontSize',12)
xline(CI_PIm_totaltime(1),'r--',sprintf('%.2f',CI_PIm_totaltime(1)),'LineWidth',2,'FontSize',12)
xline(CI_PIm_totaltime(2),'r--',sprintf('%.2f',CI_PIm_totaltime(2)),'LineWidth',2,'FontSize',12)

xline(bmu_LGN_totaltime,'k-',sprintf('%.2f',bmu_LGN_totaltime),'LineWidth',2,'FontSize',12)
xline(CI_LGN_totaltime(1),'y--',sprintf('%.2f',CI_LGN_totaltime(1)),'LineWidth',2,'FontSize',12)
xline(CI_LGN_totaltime(2),'y--',sprintf('%.2f',CI_LGN_totaltime(2)),'LineWidth',2,'FontSize',12)


%% Velocity 

[CI_Control_veloc, bootstat_control_veloc] = bootci(10000,{@mean,AllAnimals_filt.thumb_mVeloc(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_veloc, bootstat_PIm_veloc]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mVeloc(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_veloc,bootstat_LGN_veloc]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mVeloc(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_veloc = mean(bootstat_control_veloc); 
bmu_PIm_veloc = mean(bootstat_PIm_veloc);
bmu_LGN_veloc = mean(bootstat_LGN_veloc);

figure('Name','Bootstrapped Distribution of Mean Maximum Veloicity') 
histogram(bootstat_control_veloc,30,'Normalization','probability')
hold on 
histogram(bootstat_PIm_veloc,30,'Normalization','probability')
histogram(bootstat_LGN_veloc,30,'Normalization','probability')
xline(bmu_control_veloc,'k-',sprintf('%.2f',bmu_control_veloc),'LineWidth',2,'FontSize',12)
xline(CI_Control_veloc(1),'b--',sprintf('%.2f',CI_Control_veloc(1)),'LineWidth',2,'FontSize',12)
xline(CI_Control_veloc(2),'b--',sprintf('%.2f',CI_Control_veloc(2)),'LineWidth',2,'FontSize',12)

xline(bmu_PIm_veloc,'k-',sprintf('%.2f',bmu_PIm_veloc),'LineWidth',2,'FontSize',12)
xline(CI_PIm_veloc(1),'r--',sprintf('%.2f',CI_PIm_veloc(1)),'LineWidth',2,'FontSize',12)
xline(CI_PIm_veloc(2),'r--',sprintf('%.2f',CI_PIm_veloc(2)),'LineWidth',2,'FontSize',12)

xline(bmu_LGN_veloc,'k-',sprintf('%.2f',bmu_LGN_veloc),'LineWidth',2,'FontSize',12)
xline(CI_LGN_veloc(1),'y--',sprintf('%.2f',CI_LGN_veloc(1)),'LineWidth',2,'FontSize',12)
xline(CI_LGN_veloc(2),'y--',sprintf('%.2f',CI_LGN_veloc(2)),'LineWidth',2,'FontSize',12)


%% Acceleration 

[CI_Control_accel, bootstat_control_accel] = bootci(10000,{@mean,AllAnimals_filt.thumb_mAccel(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_accel, bootstat_PIm_accel]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mAccel(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_accel,bootstat_LGN_accel]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mAccel(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_accel = mean(bootstat_control_accel); 
bmu_PIm_accel = mean(bootstat_PIm_accel);
bmu_LGN_accel = mean(bootstat_LGN_accel);

figure('Name','Bootstrapped Distribution of Mean Maximum Acceleration') 
histogram(bootstat_control_accel,30,'Normalization','probability')
hold on 
histogram(bootstat_PIm_accel,30,'Normalization','probability')
histogram(bootstat_LGN_accel,30,'Normalization','probability')
xline(bmu_control_accel,'k-',sprintf('%.2f',bmu_control_accel),'LineWidth',2,'FontSize',12)
xline(CI_Control_accel(1),'b--',sprintf('%.2f',CI_Control_accel(1)),'LineWidth',2,'FontSize',12)
xline(CI_Control_accel(2),'b--',sprintf('%.2f',CI_Control_accel(2)),'LineWidth',2,'FontSize',12)

xline(bmu_PIm_accel,'k-',sprintf('%.2f',bmu_PIm_accel),'LineWidth',2,'FontSize',12)
xline(CI_PIm_accel(1),'r--',sprintf('%.2f',CI_PIm_accel(1)),'LineWidth',2,'FontSize',12)
xline(CI_PIm_accel(2),'r--',sprintf('%.2f',CI_PIm_accel(2)),'LineWidth',2,'FontSize',12)

xline(bmu_LGN_accel,'k-',sprintf('%.2f',bmu_LGN_accel),'LineWidth',2,'FontSize',12)
xline(CI_LGN_accel(1),'y--',sprintf('%.2f',CI_LGN_accel(1)),'LineWidth',2,'FontSize',12)
xline(CI_LGN_accel(2),'y--',sprintf('%.2f',CI_LGN_accel(2)),'LineWidth',2,'FontSize',12)