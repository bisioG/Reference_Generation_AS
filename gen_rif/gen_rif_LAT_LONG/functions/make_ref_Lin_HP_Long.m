function [F_pres_Lin,damping_Lin,ax_corpo_Lin,pos_Lin,vel_Lin,Output_L,ypf_L,yp_L] = make_ref_Lin_HP_Long(Ts,Tf,ax,m,k2,c2,tau_hp,A,y,G_hp)

% Calcolo uscite modello pressorio Lin
for i = 1:Tf/Ts

    F_pres_Lin(i) = k2*y(i,1); % forza di pressione
    damping_Lin(i) = c2*y(i,2); %smorzamento
    ax_corpo_Lin(i) = ax(i)-damping_Lin(i)/m-F_pres_Lin(i)/m;
    
    pos_Lin(i)=y(i,1);
    vel_Lin(i)=y(i,2);
    
    Output_L(i) = F_pres_Lin(i)+damping_Lin(i);  %forza premente
    ypf_L(i) = (-1/tau_hp)*G_hp*y(i,3)+G_hp*Output_L(i)./A; %pressione filtrata
    
end

yp_L = Output_L./A;



end

