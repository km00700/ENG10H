global ws
ws=1;
v=10;
theta=pi/6;
vx=10*cos(theta);
vy=10*sin(theta);
V=[0;vx;0;vy];
tspan=[0:0.1:1.1];
[t x]=ode23(@ode, tspan, V)