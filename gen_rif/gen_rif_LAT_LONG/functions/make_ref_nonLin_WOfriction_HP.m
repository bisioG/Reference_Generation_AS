function [F_el_nonLin_WOfriction,damping_nonLin_WOfriction,ay_corpo_nonLin_WOfriction,pos_nonLin_WOfriction,vel_nonLin_WOfriction,Output_NL_WOfriction,ypf_NL_WOfriction,yp_NL_WOfriction ] = make_ref_nonLin_WOfriction_HP(Ts,Tf,ay,m,k1,k2,c1,c2,tau_hp,A,y,p,G_hp)

% Calcolo uscite nonLin WOfriction model
for i = 1:Tf/Ts
    k(i) = k1*(y(i,1)).^p+k2; 
    F_el_nonLin_WOfriction(i) = k(i)*y(i,1); % forza di elastica
    c(i)= c1*(y(i,1)).^p+c2;
    damping_nonLin_WOfriction(i) = c(i)*y(i,2); %forza damping
    ay_corpo_nonLin_WOfriction(i) = ay(i)-damping_nonLin_WOfriction(i)/m-F_el_nonLin_WOfriction(i)/m;
    pos_nonLin_WOfriction(i)=y(i,1);
    vel_nonLin_WOfriction(i)=y(i,2);
    
    
    Output_NL_WOfriction(i)=((k(i)-k2)*y(i,1)) + ((c(i)-c2)*y(i,2));
    ypf_NL_WOfriction(i) = (-1/tau_hp)*G_hp*y(i,3)+ G_hp*Output_NL_WOfriction(i)./A;
    
end

yp_NL_WOfriction = Output_NL_WOfriction./A;



end

