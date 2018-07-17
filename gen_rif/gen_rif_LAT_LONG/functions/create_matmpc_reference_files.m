%% ****** SCRIPT TO CREATE DIFFERENTS LATERAL OR LONGITUDINAL PRESSURE REFERENCE SIGNAL AND ONLINE PARAMS FOR MATMPC
%ACTIVE SEAT MODELS (HP FILTERED)


%path MATMPC/examples

path_examples = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples';

%% ***** create the pressure reference (LATERAL)

if type == 1 % 1= lateral
    
% ODE nonLin

% parametri modello pressorio gli stessi con cui creo il modello mpc


cd (path_examples);
run Pressure_model_params_nonLin
cd(mainfolder);

A = 0.016; %area di contatto
tspan = tt;

y0 = [0;0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin_hpfilter(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,vs,alpha,MM,ax,g,Fs,Fc,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)

%calcolo le uscite al modello pressorio NON_LINEARE
[ F_el_nonLin,F_att,damping_nonLin,ay_corpo_nonLin,pos_nonLin,vel_nonLin,zm,elastic_effect,damping_effect,Output_NL,ypf_NL,yp_NL]= make_ref_nonLin_HP(Ts,Tf,ay,m,k1,k2,c1,c2,sigma_0,tau_hp,A,y);


%% ODE nonLin_WOfriction

% parametri modello pressorio sono gli stessi del caso non-lineare

y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin_WOfriction_hpfilter(t,y,tspan,ay,m,k1,k2,c1,c2,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)

%calcolo le uscite al modello pressorio WOfriction
[F_el_nonLin_WOfriction,damping_nonLin_WOfriction,ay_corpo_nonLin_WOfriction,pos_nonLin_WOfriction,vel_nonLin_WOfriction,Output_NL_WOfriction,ypf_NL_WOfriction,yp_NL_WOfriction ]  = make_ref_nonLin_WOfriction_HP(Ts,Tf,ay,m,k1,k2,c1,c2,tau_hp,A,y);


%% ODE Lin

% parametri LIN modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd (path_examples);
run Pressure_model_params_Lin
cd(current_path);


y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_lin_hpfilter(t,y,tspan,ay,m,k2,c2,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)

%calcolo le uscite al modello pressorio LINEARE
[F_pres_Lin,damping_Lin,ay_corpo_Lin,pos_Lin,vel_Lin,Output_L,ypf_L,yp_L] = make_ref_Lin_HP(Ts,Tf,ay,m,k2,c2,tau_hp,A,y); 

%stace state Linear model

% A=[0 1; -k2/m -c2/m];
% B=[0 1]';
% C=[k2 c2];

end

if type == 2

% ODE Lin (longitudinal)

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd (path_examples);
run Pressure_model_params_Lin
cd(current_path);

tspan = tt;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_lin_hpfilter_Long(t,y,tspan,ax,m,k2,c2,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%calcolo le uscite al modello pressorio LINEARE
[F_pres_Lin,damping_Lin,ax_corpo_Lin,pos_Lin,vel_Lin,Output_L,ypf_L_long,yp_L_long] = make_ref_Lin_HP_Long(Ts,Tf,ax,m,k2,c2,tau_hp,A,y); 

end

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
    


