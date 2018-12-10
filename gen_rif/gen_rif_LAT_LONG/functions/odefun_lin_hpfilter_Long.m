function dydt = odefun_lin_Long(t,y,time,ax,m,k2,c2,tau_hp,A,G_hp)

ax = interp1(time,ax,t); % Interpolate the data set (gt,g) at time t

k = (k2)*y(1); %elastic force
c = (c2)*y(2); %damping


dydt = [y(2); ...
       -(c2)/m.*y(2)-(k2)/m.*y(1)+ax; ... 
       (-1/tau_hp)*G_hp*y(3)+G_hp*(c+k)/A]; 
