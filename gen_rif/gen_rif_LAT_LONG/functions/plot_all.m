% GRAFICI

%****************** GRAFICI LINEARIZZAZIONE

%% plot stifness lineare
%  run lin_stifness_plot

%% plot damping lineare
%  run lin_damping_plot

%****************** GRAFICI RIFERIMENTI CREATI

if type==1 %LATERAL
    
% plots delle componenti del segnale pressorio NON filtrato (studio del segnale pressorio)
 
 run plot_rif_pres_laterale

%% plots confronto tra segnali filtrati e non filtrati

run plot_rif_pres_laterale_HP

end

if type==2 %LONGITUDINAL
    
% plots delle componenti del segnale pressorio NON filtrato (studio del segnale pressorio)
 
 run plot_rif_pres_long

%% plots confronto tra segnali filtrati e non filtrati

run plot_rif_pres_long_HP

end