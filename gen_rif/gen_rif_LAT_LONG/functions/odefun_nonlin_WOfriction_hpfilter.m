function dydt = odefun_nonlin_WOfriction(t,y,time,ay,m,k1,k2,c1,c2,tau_hp,A,p,G_hp)

ay = interp1(time,ay,t); % Interpolate the data set (gt,g) at time t

k = ((k1*(y(1)).^p+k2)-k2)*y(1); %elastic force
c = ((c1*(y(1)).^p+c2)-c2)*y(2); %damping

dydt = [y(2); ...
       -(c1*(y(1)).^p+c2)/m.*y(2)-(k1*(y(1)).^p+k2)/m.*y(1)+ay; ... 
        (-1/tau_hp)*G_hp*y(3)+G_hp*(c+k)/A]; 
