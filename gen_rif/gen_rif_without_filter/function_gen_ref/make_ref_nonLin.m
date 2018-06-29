function [ F_el_nonLin,F_att,damping_nonLin,ay_corpo_nonLin,pos_nonLin,vel_nonLin,zm,elastic_effect,damping_effect,Output_NL,yp_NL] = make_ref_nonLin_HP(Ts,Tf,ay,m,k1,k2,c1,c2,sigma_0,A,y)

% Calcolo uscite modello pressione nonLin

%% Calcolo uscite nonLin
for i = 1:Tf/Ts
    k(i) = k1*(y(i,1)).^2+k2; 
    F_el_nonLin(i) = k(i)*y(i,1); % forza di elastica
    F_att(i) = sigma_0*y(i,3); % forza di attrito [sigma_2=0]
    
    c(i)= c1*(y(i,1)).^2+c2;
    damping_nonLin(i) = c(i)*y(i,2); %forza damping
    ay_corpo_nonLin(i) = ay(i)-F_att(i)/m -damping_nonLin(i)/m-F_el_nonLin(i)/m;
    pos_nonLin(i)=y(i,1);
    vel_nonLin(i)=y(i,2);
    zm(i) = y(i,3);
    
    
    elastic_effect(i)=(k(i)-k2)*y(i,1);
    damping_effect(i)=(c(i)-c2)*y(i,2);
    
    Output_NL(i)= elastic_effect(i)+damping_effect(i);
    
end

yp_NL = Output_NL./A;

end

