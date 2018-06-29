%% PLOT rif_pres_laterale_HP.m*****************************************************************

    
    tt=Ts:Ts:N_sim*Ts;
    
    legend_size=12; %LEGEND SIZE SETTINGS
    title_size=19;  %TITLE SIZE SETTINGS


%% ********** compare signals filtered vs not filtered **********************

%% LINEAR case

figure;
plot(tspan,yp_L,'r--','Linewidth',1)
%xlim([0 3*1/fr])
%xlim([0 3])
hold on
plot(tspan,ypf_L,'b--','Linewidth',1)
lgd = legend('Ref. Pressure','Ref. Pressure Filtered');
lgd.FontSize = legend_size;
title(['Compare Linear model,test: ', param_name ],'FontSize',title_size)
grid on

