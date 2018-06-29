% VERSIONE: GENERAZIONE DEL RIFERIMENTO DI PRESSIONE LONGITUDINALE CON FILTRO PASSA ALTO
%  Creazione del Modello nonlineare riferimento 

clear all;
clc;
close all;

type = 'longitudinal'; %label for the output file

%% ***** SETTINGS PATHS

%path of \function_gen_ref_hp
addpath(genpath('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\Reference_generation\gen_rif\gen_rif_with_HP_filter_Long\function_gen_ref_hp'));

%path MATMPC/examples

path_examples = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples';

%path main MATMPC

path_main_matmpc = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC';

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


%% ODE Lin

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd (path_examples);
run Pressure_model_params_Lin
cd(current_path);

tspan = tt;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_lin_hpfilter_Long(t,y,tspan,ax,m,k2,c2,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%stace state Linear model

% A=[0 1; -k2/m -c2/m];
% B=[0 1]';
% C=[k2 c2];

%calcolo le uscite al modello pressorio LINEARE
[F_pres_Lin,damping_Lin,ax_corpo_Lin,pos_Lin,vel_Lin,Output_L,ypf_L,yp_L] = make_ref_Lin_HP_Long(Ts,Tf,ax,m,k2,c2,tau_hp,A,y); 


%****************** GRAFICI

%% plots delle componenti del segnale pressorio NON filtrato (studio del segnale pressorio)
   run plot_rif_pres_long

%% plots confronto tra segnali filtrati e non filtrati
   run plot_rif_pres_long_HP

%% plot stifness lineare
%  run lin_stifness_plot

%% plot damping lineare
%  run lin_damping_plot


%% ************** CREAZIONE DEL FILE DI RIFERIMENTO DI PRESSIONE PER MATMPC

rif_pressione= ypf_L; % il riferimento scelto (rif_pressione variabile utilizzata in matmpc)

% tipi:
% 
% ypf_NL
% ypf_NL_WOfriction
% ypf_L

cd([pwd,'\rif_pressure_saved'])
save('rif_pressione','rif_pressione','label','type');
cd('..');

%% *************** CREAZIONE DEI PARAMETRI DI ACCX,ACCY,ROLL DA UTILIZZARE NEL MODELLO MPC
    
    scale_f = 0.5; %fattore di scala
    rif_pitch = zeros(length(ax));

    rif_accX = ax*scale_f; 
    rif_accY = ay*scale_f;

    save([pwd,'\rif_params_saved\rif_params'],'rif_accX','rif_accY','rif_pitch');
    
%% *************** COPIARE IN MATMPC/DATA RIFERIMENTO DI PRESSIONE CREATO E PARAMETRI

dir_gen_rif = pwd;
cd([dir_gen_rif,'\rif_params_saved']);
copyfile('rif_params.mat',[path_main_matmpc,'\data\ActiveSeat_onlyP'])
cd('..\.')
cd([dir_gen_rif,'\rif_pressure_saved']);
copyfile('rif_pressione.mat',[path_main_matmpc,'\data\ActiveSeat_onlyP'])
cd(path_main_matmpc);


%% *************** FINE CREAZIONE RIFERIMENTO DI PRESSIONE E PARAMETRI ON-LINE

clc;
display('                           ');
display('Pressure Reference created.');
display('                           ');
display('On-line params file created.');
display('                           ');
display('You can simulate with the current reference files.');

