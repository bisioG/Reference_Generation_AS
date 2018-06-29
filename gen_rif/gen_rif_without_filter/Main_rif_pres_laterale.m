% VERSIONE: GENERAZIONE DEL RIFERIMENTO DI PRESSIONE SENZ FILTRO PASSA ALTO
%  Creazione del Modello nonlineare riferimento 

clear all;
clc;
close all;

%path of \function_gen_ref_hp
addpath(genpath('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\Reference_generation\gen_rif\gen_rif_without_filter\function_gen_ref'));
%% parametri comuni della simulazione

N_sim = 5000;
Ts = 0.005;
Tf = 25;
tt = linspace(Ts,N_sim*Ts,N_sim);


%% parametri ax,ay  SINUSOIDE *******************************************************

% param_name = 'Sinusoidal';
% Amp = 10;
% fr = 1/25;
% ay = Amp*sin(2*pi*fr*t);
% ax = ay;

% label = 'sinusoidal_test'

%% parametri ax,ay GRADINO ************************************************************

% param_name = 'Step';
% Amp = 10;
% ay = [zeros(1,100) Amp*ones(1,(length(t)-100))];
% ax = ay;

% label = 'step_test'

%% parametri ax,ay CALABOGIE *********************************************************

param_name = 'Calabogie track';
g=9.81;
load ('acc_data\ay.mat')
load ('acc_data\ax.mat')
ax = IN1_XY(1:N_sim)*g;
ay = IN1_YX(1:N_sim)*g; % trasformo in m/s^2

label = 'calabogie_test'

%% parametri ax,ay CHICANE **********************************************************

% param_name = 'Chicane section';
% g =9.81;
% load ('acc_data\ay2.mat')
% load ('acc_data\ax2.mat')
% ay = -IN1_YX(1:N_sim)*g; % trasformo in m/s^2
% ax = IN1_XY(1:N_sim)*g;

% label = 'chicane_test'

%% ODE nonLin

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_nonLin
cd(current_path);

A = 0.016; %area di contatto

tspan = tt;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,vs,alpha,MM,ax,g,Fs,Fc);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)

%calcolo le uscite al modello pressorio NON_LINEARE
[ F_el_nonLin,F_att,damping_nonLin,ay_corpo_nonLin,pos_nonLin,vel_nonLin,zm,elastic_effect,damping_effect,Output_NL,yp_NL]= make_ref_nonLin(Ts,Tf,ay,m,k1,k2,c1,c2,sigma_0,A,y);


%verifica tra filter() e state space e grafici di bode del filtro
%  run validation_test.m


%% ODE nonLin_WOfriction

% parametri modello pressorio sono gli stessi del caso non-lineare

tspan = tt; 
y0 = [0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin_WOfriction(t,y,tspan,ay,m,k1,k2,c1,c2);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)

%calcolo le uscite al modello pressorio WOfriction
[F_el_nonLin_WOfriction,damping_nonLin_WOfriction,ay_corpo_nonLin_WOfriction,pos_nonLin_WOfriction,vel_nonLin_WOfriction,Output_NL_WOfriction,yp_NL_WOfriction ]  = make_ref_nonLin_WOfriction(Ts,Tf,ay,m,k1,k2,c1,c2,A,y);


%% ODE Lin

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_Lin
cd(current_path);

tspan = tt;
y0 = [0;0]; % cond iniziali

ode_function = @(t,y) odefun_lin(t,y,tspan,ay,m,k2,c2);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%stace state Linear model

% A=[0 1; -k2/m -c2/m];
% B=[0 1]';
% C=[k2 c2];

%calcolo le uscite al modello pressorio LINEARE
[F_pres_Lin,damping_Lin,ay_corpo_Lin,pos_Lin,vel_Lin,Output_L,yp_L] = make_ref_Lin(Ts,Tf,ay,m,k2,c2,A,y); 


%****************** GRAFICI

%% plots delle componenti del segnale pressorio NON filtrato (studio del segnale pressorio)
   run plot_rif_pres_laterale

%% plot stifness lineare
%  run lin_stifness_plot

%% plot damping lineare
%  run lin_damping_plot


%% ************** CREAZIONE DEL FILE DI RIFERIMENTO DI PRESSIONE PER MATMPC

rif_pressione= yp_NL; % il riferimento scelto (rif_pressione variabile utilizzata in matmpc)

% tipi:
% 
% ypf_NL
% ypf_NL_WOfriction
% ypf_L

cd([pwd,'\rif_pressure_saved'])
save('rif_pressione','rif_pressione','label');
cd('..');

%% *************** CREAZIONE DEI PARAMETRI DI ACCX,ACCY,ROLL DA UTILIZZARE NEL MODELLO MPC
    
    scale_f = 0.5; %fattore di scala
    rif_roll = zeros(length(ax));

    rif_accX = ax*scale_f; 
    rif_accY = ay*scale_f;

    save([pwd,'\rif_params_saved\rif_params'],'rif_accX','rif_accY','rif_roll');
    
%% *************** COPIARE IN MATMPC/DATA RIFERIMENTO DI PRESSIONE CREATO E PARAMETRI

dir_gen_rif = pwd;
dir_matmpc = [pwd,'\..\..\..']
cd([dir_gen_rif,'\rif_params_saved']);
copyfile('rif_params.mat',[dir_matmpc,'\data\ActiveSeat_onlyP'])
cd('..\.')
cd([dir_gen_rif,'\rif_pressure_saved']);
copyfile('rif_pressione.mat',[dir_matmpc,'\data\ActiveSeat_onlyP'])
cd(dir_matmpc);


%% *************** FINE CREAZIONE RIFERIMENTO DI PRESSIONE E PARAMETRI ON-LINE

clc;
display('                           ');
display('Pressure Reference created.');
display('                           ');
display('On-line params file created.');
display('                           ');
display('You can simulate with the current reference files.');

