function [F_pres_Lin,damping_Lin,ay_corpo_Lin,pos_Lin,vel_Lin,Output_L,yp_L] = make_ref_Lin_HP(Ts,Tf,ay,m,k2,c2,A,y)

% Calcolo uscite modello pressorio Lin
for i = 1:Tf/Ts

    F_pres_Lin(i) = k2*y(i,1); % forza di pressione
    damping_Lin(i) = c2*y(i,2); %smorzamento
    ay_corpo_Lin(i) = ay(i)-damping_Lin(i)/m-F_pres_Lin(i)/m;
    
    pos_Lin(i)=y(i,1);
    vel_Lin(i)=y(i,2);
    
    Output_L(i) = F_pres_Lin(i)+damping_Lin(i);  %forza premente
    
    
end

yp_L = Output_L./A;



end

