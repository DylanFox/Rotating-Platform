[CI_Control_MGA, bootstat_control_mga] = bootci(10000,{@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_MGA, bootstat_PIm_mga]  = bootci(10000,{@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_MGA,bootstat_LGN_mga]  = bootci(10000,{@mean,AllAnimals_filt.mMGA(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_mga = mean(bootstat_control_mga); 
bmu_PIm_mga = mean(bootstat_PIm_mga);
bmu_LGN_mga = mean(bootstat_LGN_mga);

figure('Name','Bootstrapped Distribution of MGA Mean') 
histogram(bootstat_control_mga,30,'Normalization','probability','FaceColor',[0 0.4470 0.7410])
hold on 
histogram(bootstat_PIm_mga,30,'Normalization','probability','FaceColor',[0.8500 0.3250 0.0980])
histogram(bootstat_LGN_mga,30,'Normalization','probability','FaceColor',[0.4660 0.6740 0.1880])
%  xline(bmu_control_mga,'k-',sprintf('%f',bmu_control_mga),'LineWidth',2,'FontSize',12,'LabelHorizontalAlignment','center')
xline(bmu_control_mga,'k-','LineWidth',2)
xline(CI_Control_MGA(1),'--','LineWidth',2,'color',[0 0.4470 0.7410])
xline(CI_Control_MGA(2),'--','LineWidth',2,'color',[0 0.4470 0.7410])

xline(bmu_PIm_mga,'k-','LineWidth',2)
xline(CI_PIm_MGA(1),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])
xline(CI_PIm_MGA(2),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])

xline(bmu_LGN_mga,'k-','LineWidth',2)
xline(CI_LGN_MGA(1),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])
xline(CI_LGN_MGA(2),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])



%% Total Time 
[CI_Control_totaltime, bootstat_control_totaltime] = bootci(10000,{@mean,AllAnimals_filt.totaltime(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_totaltime, bootstat_PIm_totaltime]  = bootci(10000,{@mean,AllAnimals_filt.totaltime(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_totaltime,bootstat_LGN_totaltime]  = bootci(10000,{@mean,AllAnimals_filt.totaltime(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_totaltime = mean(bootstat_control_totaltime); 
bmu_PIm_totaltime = mean(bootstat_PIm_totaltime);
bmu_LGN_totaltime = mean(bootstat_LGN_totaltime);

figure('Name','Bootstrapped Distribution of Time to Completion Mean') 
histogram(bootstat_control_totaltime,30,'Normalization','probability','FaceColor',[0 0.4470 0.7410])
hold on 
histogram(bootstat_PIm_totaltime,30,'Normalization','probability','FaceColor',[0.8500 0.3250 0.0980])
histogram(bootstat_LGN_totaltime,30,'Normalization','probability','FaceColor',[0.4660 0.6740 0.1880])
xline(bmu_control_totaltime,'k-','LineWidth',2)
xline(CI_Control_totaltime(1),'--','LineWidth',2,'color',[0 0.4470 0.7410])
xline(CI_Control_totaltime(2),'--','LineWidth',2,'color',[0 0.4470 0.7410])

xline(bmu_PIm_totaltime,'k-','LineWidth',2)
xline(CI_PIm_totaltime(1),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])
xline(CI_PIm_totaltime(2),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])

xline(bmu_LGN_totaltime,'k-','LineWidth',2)
xline(CI_LGN_totaltime(1),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])
xline(CI_LGN_totaltime(2),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])


%% Velocity 

[CI_Control_veloc, bootstat_control_veloc] = bootci(10000,{@mean,AllAnimals_filt.thumb_mVeloc(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_veloc, bootstat_PIm_veloc]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mVeloc(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_veloc,bootstat_LGN_veloc]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mVeloc(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_veloc = mean(bootstat_control_veloc); 
bmu_PIm_veloc = mean(bootstat_PIm_veloc);
bmu_LGN_veloc = mean(bootstat_LGN_veloc);

figure('Name','Bootstrapped Distribution of Mean Maximum Veloicity') 
histogram(bootstat_control_veloc,30,'Normalization','probability','FaceColor',[0 0.4470 0.7410])
hold on 
histogram(bootstat_PIm_veloc,30,'Normalization','probability','FaceColor',[0.8500 0.3250 0.0980])
histogram(bootstat_LGN_veloc,30,'Normalization','probability','FaceColor',[0.4660 0.6740 0.1880])
xline(bmu_control_veloc,'k-','LineWidth',2)
xline(CI_Control_veloc(1),'--','LineWidth',2,'color',[0 0.4470 0.7410])
xline(CI_Control_veloc(2),'--','LineWidth',2,'color',[0 0.4470 0.7410])

xline(bmu_PIm_veloc,'k-','LineWidth',2)
xline(CI_PIm_veloc(1),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])
xline(CI_PIm_veloc(2),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])

xline(bmu_LGN_veloc,'k-','LineWidth',2)
xline(CI_LGN_veloc(1),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])
xline(CI_LGN_veloc(2),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])


%% Acceleration 

[CI_Control_accel, bootstat_control_accel] = bootci(10000,{@mean,AllAnimals_filt.thumb_mAccel(AllAnimals_filt.cohort == 'Control')},'type','per');
[CI_PIm_accel, bootstat_PIm_accel]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mAccel(AllAnimals_filt.cohort == 'PIm + V1')},'type','per');
[CI_LGN_accel,bootstat_LGN_accel]  = bootci(10000,{@mean,AllAnimals_filt.thumb_mAccel(AllAnimals_filt.cohort == 'LGN + V1')},'type','per');

bmu_control_accel = mean(bootstat_control_accel); 
bmu_PIm_accel = mean(bootstat_PIm_accel);
bmu_LGN_accel = mean(bootstat_LGN_accel);

figure('Name','Bootstrapped Distribution of Mean Maximum Acceleration') 
histogram(bootstat_control_accel,30,'Normalization','probability','FaceColor',[0 0.4470 0.7410])
hold on 
histogram(bootstat_PIm_accel,30,'Normalization','probability','FaceColor',[0.8500 0.3250 0.0980])
histogram(bootstat_LGN_accel,30,'Normalization','probability','FaceColor',[0.4660 0.6740 0.1880])
xline(bmu_control_accel,'k-','LineWidth',2)
xline(CI_Control_accel(1),'--','LineWidth',2,'color',[0 0.4470 0.7410])
xline(CI_Control_accel(2),'--','LineWidth',2,'color',[0 0.4470 0.7410])

xline(bmu_PIm_accel,'k-','LineWidth',2)
xline(CI_PIm_accel(1),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])
xline(CI_PIm_accel(2),'--','LineWidth',2,'color',[0.8500 0.3250 0.0980])

xline(bmu_LGN_accel,'k-','LineWidth',2,'LabelHorizontalAlignment','center')
xline(CI_LGN_accel(1),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])
xline(CI_LGN_accel(2),'--','LineWidth',2,'color',[0.4660 0.6740 0.1880])