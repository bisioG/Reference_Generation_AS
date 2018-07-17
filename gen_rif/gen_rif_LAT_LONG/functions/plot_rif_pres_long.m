%% PLOT rif_pres_laterale_HP.m*****************************************************************
    
    legend_size=12; %LEGEND SIZE SETTINGS
    title_size=19;  %TITLE SIZE SETTINGS



%% Linear contributors (non filtrate)

    figure
    plot(tt,m*ax,'g','Linewidth',1)
    hold on
    
    if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
    else
        xlim([0 Tf])
    end
    
    plot(tt,Output_L,'b','Linewidth',1)  
    plot(tt,m*ax_corpo_Lin,'c','Linewidth',1)
    plot(tt,F_pres_Lin,'r--','Linewidth',1)
    plot(tt,damping_Lin,'y','Linewidth',1)
    plot(tt,F_pres_Lin+damping_Lin,'m--','Linewidth',1)
    lgd = legend('Reference Force (m*ay)','Output','Body Force (ma_y - damping - elastic force)','Elastic Force','Damping','Sum Elastic, Damping');
    lgd.FontSize= legend_size;
    xlabel('time [s]')
    ylabel('force [N]')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Linear Model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Linear Model, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    else
    title(['Linear Model, test:', param_name],'FontSize',title_size)    
    end
    
    grid on

%% Linear position and velocity (non filtrate)

figure
plot(tt,pos_Lin)
if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end
hold on
plot(tt,vel_Lin)
lgd = legend('posizione corpo Lin','velocita` corpo Lin');
lgd.FontSize= legend_size;
xlabel('time [s]')
ylabel('[m] or [m/s]')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Linear positions and velocity, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Linear positions and velocity, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    else
    title(['Linear positions and velocity, test:', param_name],'FontSize',title_size)    
    end
    
grid on



