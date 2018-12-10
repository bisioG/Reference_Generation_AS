%% PLOT rif_pres_laterale_HP.m*****************************************************************

    
    legend_size=12; %LEGEND SIZE SETTINGS
    title_size=19;  %TITLE SIZE SETTINGS

%% ********** compare signals filtered vs not filtered **********************

%%  NON_LINEAR case

figure;
plot(tspan,yp_NL./10^5,'r--','Linewidth',1)
if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
    else
        xlim([0 Tf])
end
hold on
plot(tspan,ypf_NL./10^5,'b--','Linewidth',1)
lgd = legend('Ref. Pressure','Ref. Pressure Filtered');
lgd.FontSize = legend_size;
xlabel('time [s]'); ylabel('[Bar]');
title(['Compare NON-Linear model,test: ', param_name ],'FontSize',title_size)
grid on


%% LINEAR case

figure;
plot(tspan,yp_L,'r--','Linewidth',1)

if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end

hold on
plot(tspan,ypf_L,'b--','Linewidth',1)
lgd = legend('Ref. Pressure','Ref. Pressure Filtered');
lgd.FontSize = legend_size;
xlabel('time [s]'); ylabel('[Pa]');
title(['Compare Linear model,test: ', param_name ],'FontSize',title_size)
grid on

%% NON-LINEAR WO FRICTION case

figure;
plot(tspan,yp_NL_WOfriction,'r--','Linewidth',1)

if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end

hold on
plot(tspan,ypf_NL_WOfriction,'b--','Linewidth',1)
lgd = legend('Ref. Pressure','Ref. Pressure Filtered');
lgd.FontSize = legend_size;
xlabel('time [s]'); ylabel('[Pa]');
title(['Compare NON-Linear WO friction model,test: ', param_name ],'FontSize',title_size)
grid on


%% compare reference filtered pressure

figure;
plot(tspan,ypf_NL,'r','Linewidth',1)

if strcmp(param_name,'Sinusoidal')==1
        xlim([0 3*1/fr])
else
        xlim([0 Tf])
end

hold on
plot(tspan,ypf_NL_WOfriction,'k','Linewidth',1)
plot(tspan,ypf_L,'b','Linewidth',1)

lgd = legend('Ref. Pressure perceived NL','Ref. Pressure perceived NL WOfriction', 'Ref. Pressure perceived L');
lgd.FontSize = legend_size;
xlabel('time [s]'); ylabel('[Pa]');

if strcmp(param_name,'Sinusoidal')==1
    title(['Nonlinear vs Linear pressure perceived, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
elseif strcmp(param_name,'Step')==1
    title(['Nonlinear vs Linear pressure perceived, test:', param_name,' A=',num2str(Amp),'[m/s]^2'],'FontSize',title_size)
else
    title(['Nonlinear vs Linear pressure perceived, test:', param_name],'FontSize',title_size)    
end
grid on

