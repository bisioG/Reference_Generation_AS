% VERSIONE: GENERAZIONE DEL RIFERIMENTO DI PRESSIONE CON FILTRO PASSA ALTO
%  Creazione del Modello nonlineare riferimento 

clear all;
clc;
close all;

%% ***** SETTINGS PATHS

%path of \function_gen_rif_LAT_LONG
addpath(genpath('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\Reference_Generation\gen_rif\gen_rif_LAT_LONG\functions'));

%path main MATMPC
path_main_matmpc = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC';

%path local saved reference and online params
save_local = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\Reference_Generation\gen_rif\gen_rif_LAT_LONG'; 

%% ***** SETTINGS SIMULATION PARAMS

N_sim = 5000;   %number of samples
Ts = 0.005;     %sampling time Hz = 200
Tf = 25;        %simulation time = 25s
tt = linspace(Ts,N_sim*Ts,N_sim);

type = 1; % 1= lateral 2=longitudinal

sim_type = 'Calabogie track';  %setting the type of reference to generate

% choose from:
% 
% Calabogie track
% Sinusoidal
% Step
% Chicane

scale_f = 0.5; %scale factor to simulate the on-line params (accX,accY,roll,pitch) of the platform

%% ************** SET THE REFERENCE TYPE

rif_type = 'Non linear lateral HP';

% TYPE:

% Non linear lateral
% Non linear lateral HP
% Linear lateral
% Linear lateral HP
% Non linear lateral WOfriction
% Non linear lateral WOfriction HP
% Linear longitudinal
% Linear longitudinal HP

%% ***** start make the ref

switch sim_type
    case 'Sinusoidal'
        %% parametri ax,ay  SINUSOIDE *******************************************************
        param_name = 'Sinusoidal';
        Amp = 10;   %amplitude
        fr = 1/25;  %frenquency
        ay = Amp*sin(2*pi*fr*tt); %sin
        ax = ay;

%         label = 'sinusoidal_ref'
        
    case 'Step'
        %% parametri ax,ay GRADINO ************************************************************
        param_name = 'Step';
        Amp = 10;  %amplitude
        ay = [zeros(1,100) Amp*ones(1,(length(tt)-100))]; %step
        ax = ay;

%         label = 'step_response'

    case 'Calabogie track'
        %% parametri ax,ay CALABOGIE *********************************************************
        param_name = 'Calabogie track';
        g=9.81;
        load ('acc_data\ay.mat')
        load ('acc_data\ax.mat')
        ax = IN1_XY(1:N_sim)*g;
        ay = IN1_YX(1:N_sim)*g; % trasformo in m/s^2

%         label = 'calabogie_track'

    case 'Chicane'
        %% parametri ax,ay CHICANE **********************************************************
        param_name = 'Chicane';
        g =9.81;
        load ('acc_data\ay2.mat')
        load ('acc_data\ax2.mat')
        ay = -IN1_YX(1:N_sim)*g; % trasformo in m/s^2
        ax = IN1_XY(1:N_sim)*g;

%         label = 'chicane_segment'
end

%% create the references
mainfolder = pwd;

run create_matmpc_reference_files.m
run set_ref_type.m
run save_and_move_ref.m
