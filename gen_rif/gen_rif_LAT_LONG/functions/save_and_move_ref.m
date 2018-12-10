% CREA IN LOCALE IL FILE DI RIFERIMENTO DI PRESSIONE ED IL FILE DEI PARAMETRI ONLINE 

%% ************** CREAZIONE DEL FILE DI RIFERIMENTO DI PRESSIONE PER MATMPC
if strcmp(param_name,'AS')
    cd([save_local,'\data\',sim_type,'\rif_pressure_saved']);
    save('rif_pressione','rif_pressione_hp','rif_pressione','rif_type','sim_type');
    cd('..');
else
    cd([save_local,'\data\rif_pressure_saved']);
    save('rif_pressione','rif_pressione_hp','rif_pressione','rif_type','sim_type');
    cd('..');
end

%% *************** CREAZIONE DEI PARAMETRI DI ACCX,ACCY,ROLL DA UTILIZZARE NEL MODELLO MPC
    
if strcmp(param_name,'AS') % non scala le accelerazioni di ingresso ma usa quelle campionate 
    
    if type == 1 % caso laterale (roll)
    
        rif_accX = (resample(acc_lin(:,1),4,5))';
        rif_accY = (resample(acc_lin(:,2),4,5))';
        rif_roll = (resample(pos_ang(:,1),4,5))';
        
        if platform_action == 0
            % per simulare senza contributi della piattaforma
            rif_accX = [];
            rif_accY = []
            rif_roll = [];
            N_sim=0;
        end
        
        
    
        % to have 25s of simulation

        if N_sim*Ts < Tf
    
            N_zeros = (Tf/Ts)-N_sim;
            rif_accX = [rif_accX,zeros(1,N_zeros)];
            rif_accY = [rif_accY,zeros(1,N_zeros)];
            rif_roll = [rif_roll,zeros(1,N_zeros)];
    
        end
        
        if N_sim*Ts > Tf
    
            N_end = Tf/Ts;
            rif_accX = rif_accX(1,1:N_end);
            rif_accY = rif_accY(1,1:N_end);
            rif_roll = rif_roll(1,1:N_end);
        end

        save([pwd,'\rif_params_saved\rif_params'],'rif_accX','rif_accY','rif_roll','type');
    
    end

    if type ==2 %caso longitudinale (pitch)

        
        rif_accX = (resample(acc_lin(:,1),4,5))';
        rif_accY = (resample(acc_lin(:,2),4,5))';
        rif_roll = (resample(pos_ang(:,1),4,5))';
        
        rif_accX = (resample(acc_lin(:,1),4,5))';
        rif_accY = (resample(acc_lin(:,2),4,5))';
        rif_pitch = (resample(pos_ang(:,2),4,5))';
        
        if platform_action == 0
            % per simulare senza contributi della piattaforma
            rif_accX = [];
            rif_accY = []
            rif_roll = [];
            N_sim=0;
        end
    
        % to have 25s of simulation

        if N_sim*Ts < Tf
    
            N_zeros = (Tf/Ts)-N_sim;
            rif_accX = [rif_accX,zeros(1,N_zeros)];
            rif_accY = [rif_accY,zeros(1,N_zeros)];
            rif_pitch = [rif_pitch,zeros(1,N_zeros)];
    
        end
        
        if N_sim*Ts > Tf
    
            N_end = Tf/Ts;
            rif_accX = rif_accX(1,1:N_end);
            rif_accY = rif_accY(1,1:N_end);
            rif_pitch = rif_pitch(1,1:N_end);
        end

        save([pwd,'\rif_params_saved\rif_params'],'rif_accX','rif_accY','rif_pitch','type');
    
    end
else
    if type ==1 %lateral
        rif_roll = zeros(length(ax));

        rif_accX = ax*scale_f; 
        rif_accY = ay*scale_f;

        save([pwd,'\rif_params_saved\rif_params'],'rif_accX','rif_accY','rif_roll','type');
    end
    if type ==2 %longitudinal
        rif_pitch = zeros(length(ax));

        rif_accX = ax*scale_f; 
        rif_accY = ay*scale_f;

        save([pwd,'\rif_params_saved\rif_params'],'rif_accX','rif_accY','rif_pitch','type');
    end
end
    
%% *************** COPIARE IN MATMPC/DATA RIFERIMENTO DI PRESSIONE CREATO E PARAMETRI

cd([pwd,'\rif_params_saved']);
copyfile('rif_params.mat',[path_main_matmpc,'\data\ActiveSeat_onlyP'])
cd('..\.')
cd([pwd,'\rif_pressure_saved']);
copyfile('rif_pressione.mat',[path_main_matmpc,'\data\ActiveSeat_onlyP'])
cd(path_main_matmpc);


%% *************** FINE CREAZIONE RIFERIMENTO DI PRESSIONE E PARAMETRI ON-LINE

clc;
display('                           ');
display(['Pressure Reference created: ', rif_type]);
display('                           ');
display(['Simulation type: ', sim_type]);
display('                           ');
display('On-line params file created.');
display('                           ');
display('You can simulate with the current reference files.');