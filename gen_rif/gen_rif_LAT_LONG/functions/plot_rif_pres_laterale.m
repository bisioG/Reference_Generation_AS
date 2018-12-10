%% PLOT rif_pres_laterale_HP.m*****************************************************************
    
    legend_size=12; %LEGEND SIZE SETTINGS
    title_size=19;  %TITLE SIZE SETTINGS
    
    Tf=25;


%% Linear vs NonLinear (non filtrate)

    figure
    
    if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
    else
        xlim([0 Tf])
    end
    hold on
    plot(tt,yp_NL,'r','Linewidth',1)
    plot(tt,yp_NL_WOfriction,'k','Linewidth',1)
    plot(tt,yp_L,'b','Linewidth',1)
    lgd=legend('Pressure NL','Pressure NL WOfriction','Pressure L');
    lgd.FontSize= legend_size;
    xlabel('time [s]')
    ylabel('[Pa]')
    
    if strcmp(param_name,'Sinusoidal')==1
    title(['Nonlinear vs Linear pressure, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Nonlinear vs Linear pressure, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Nonlinear vs Linear pressure, test:', param_name],'FontSize',title_size)    
    end
        
    grid on
    
%% NonLinear contributors (non filtrate)

   figure
   plot(tt,m*ay,'g','Linewidth',1)

   if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
   else
        xlim([0 Tf])
   end
   
   hold on
   plot(tt,m*ay_corpo_nonLin,'m','Linewidth',1)
%    plot(tt,Output_NL,'b--','Linewidth',1)  
   plot(tt,F_el_nonLin,'r','Linewidth',1)
   plot(tt,damping_nonLin,'b','Linewidth',1)
   plot(tt,F_att,'k','Linewidth',1)
%    plot(tt,F_att+F_el_nonLin+damping_nonLin+m*ay_corpo_nonLin,'m--','Linewidth',1)
   lgd = legend('F (m*ay)','f_i','f_e','f_v','F_{attr}');
   lgd.FontSize= legend_size;
   xlabel('time [s]')
   ylabel('force [N]')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Nonlinear Model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Nonlinear Model, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Nonlinear Model, test:', param_name],'FontSize',title_size)    
    end
    
   grid on
   
%% NonLinear contributors WOfriction (non filtrate)

   figure
plot(tt,m*ay,'g','Linewidth',1)
   
   if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
   else
        xlim([0 Tf])
   end
   hold on
%    plot(tt,Output_NL_WOfriction,'b--','Linewidth',1)  
plot(tt,m*ay_corpo_nonLin_WOfriction,'m','Linewidth',1)
   plot(tt,F_el_nonLin_WOfriction,'r','Linewidth',1)
   plot(tt,damping_nonLin_WOfriction,'b','Linewidth',1)
%    plot(tt,F_el_nonLin+damping_nonLin+,'m--','Linewidth',1)
   lgd = legend('F (m*ay)','f_i','f_e','f_v');
   lgd.FontSize= legend_size;
   xlabel('time [s]')
   ylabel('force [N]')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Nonlinear WOfriction Model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Nonlinear WOfriction Model, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Nonlinear WOfriction Model, test:', param_name],'FontSize',title_size)    
    end

   grid on
   
   %% Linear contributors (non filtrate)

    figure
    plot(tt,m*ay,'g','Linewidth',1)
    hold on
    
    if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
    else
        xlim([0 Tf])
    end
    
%     plot(tt,Output_L,'b','Linewidth',1)  
    plot(tt,m*ay_corpo_Lin,'m','Linewidth',1)
    plot(tt,F_pres_Lin,'r','Linewidth',1)
    plot(tt,damping_Lin,'b','Linewidth',1)
%     plot(tt,F_pres_Lin+damping_Lin,'m--','Linewidth',1)
    lgd = legend('F (m*ay)','f_i','f_e','f_v');
    lgd.FontSize= legend_size;
    xlabel('time [s]')
    ylabel('force [N]')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Linear Model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Linear Model, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Linear Model, test:', param_name],'FontSize',title_size)    
    end
    
    grid on
    
%% position and velocity NONLin (non filtrate)

figure
plot(tt,pos_nonLin)
if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end
hold on
plot(tt,vel_nonLin)
lgd = legend('body position NONLin','body velocity NONLin');
lgd.FontSize= legend_size;
xlabel('time [s]')
ylabel('[m]or [m/s]')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Nonlinear positions and velocity, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Nonlinear positions and velocity, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Nonlinear positions and velocity, test:', param_name],'FontSize',title_size)    
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
    title(['Linear positions and velocity, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Linear positions and velocity, test:', param_name],'FontSize',title_size)    
    end
    
grid on

%% position compare (non filtrate)

figure
plot(tt,pos_Lin,'b','Linewidth',1)

if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end

hold on
plot(tt,pos_nonLin,'r','Linewidth',1)
plot(tt,pos_nonLin_WOfriction,'k','Linewidth',1)
lgd = legend('body position L','body position NL', 'body position NL WOfriction' );
lgd.FontSize= legend_size;
xlabel('time [s]')
ylabel('[m]')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Linear vs Non-Linear positions, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Linear vs Non-Linear positions, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Linear vs Non-Linear positions, test:', param_name],'FontSize',title_size)    
    end
    
grid on

%% velocities compare

figure
plot(tt,vel_Lin,'b','Linewidth',1)

if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end

hold on
plot(tt,vel_nonLin,'r','Linewidth',1)
plot(tt,vel_nonLin_WOfriction,'k','Linewidth',1)
lgd = legend('body velocity L','body velocity NL', 'body velocity NL WOfriction' );
lgd.FontSize= legend_size;
xlabel('time [s]')
ylabel('[m/s]^2')

    if strcmp(param_name,'Sinusoidal')==1
    title(['Linear vs Non-Linear velocities, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
    elseif strcmp(param_name,'Step')==1
    title(['Linear vs Non-Linear velocities, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
    else
    title(['Linear vs Non-Linear velocities, test:', param_name],'FontSize',title_size)    
    end
    
grid on


%% splitted free trunk contributor 

cd (path_examples);
run Pressure_model_params_nonLin


figure
plot(tt,elastic_effect,'k','Linewidth',1)

if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end

hold on

plot(tt,damping_effect,'r','Linewidth',1)
plot(tt,k2*y(:,1)','k--','Linewidth',1)
plot(tt,c2*y(:,2)','r--','Linewidth',1)

plot(tt,m*ay,'g','Linewidth',1)
plot(tt,F_att,'m','Linewidth',1)
plot(tt,m*ay_corpo_nonLin_WOfriction,'b','Linewidth',1)
%plot(tt,elastic_effect+damping_effect,'y','Linewidth',1)

lgd = legend('k_1*d_y^2*d_y','c_1*d_y^2*dot(d_y)','k_2*d_y','c_2*dot(d_y)','m*a_y','F_attr','f_i');
lgd.FontSize= legend_size;
xlabel('time [s]')
ylabel('[m/s]^2')

    
title(['Dynamic equation contributor splitted, test:', param_name],'FontSize',title_size)
    
grid on


