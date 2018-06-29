% Crea un riferimento NONlineare con modello di attrito di de Wit, i parametri F_c e 
% F_s variano secondo l'accelerazione longitudinale 

clc
clear
% close all


%% parametri simulazione
N_sim = 5000;
Ts = 0.005;

%% parametri modello pressorio
current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params
cd(current_path);

A = 0.016; %area di contatto

%% carico dati di simulazione
load ay.mat
load ax.mat
ax = IN1_XY(1:N_sim)*g;
ay = IN1_YX(1:N_sim)*g; % trasformo in m/s^2

%% ODE
tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,vs,alpha,MM,ax,g,Fs,Fc);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite
for i = 1:N_sim
    k(i) = k1*(y(i,1)).^2+k2;
    c(i)= c1*(y(i,1)).^2+c2;
    
    Output_NL(i)=((k(i)-k2)*y(i,1)) + ((c(i)-c2)*y(i,2));
    
end


rif_pressione = Output_NL/A;


%% plot
tt=Ts:Ts:N_sim*Ts;
figure
plot(tt,rif_pressione)
legend('rif pressione calabogie NON Lineare')

%  save('rif_pressione_calabogie','rif_pressione)