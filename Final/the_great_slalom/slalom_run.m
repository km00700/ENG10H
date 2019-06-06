load q_values.mat
vmax=2; %note: this value also appears in all three files
x0=0;
y0=0;
vx0=0;
xvals=[];
yvals=[];
t=0;
while y0>=-10 && abs(x0)<=2.5
    t=t+1;
    choice=max(q_table(abs(round(y0))+1,:)); 
    if choice==q_table(abs(round(y0))+1,1) %vx=-vmax
        vx=-vmax;
        [x y]=slalom(vx0, vx, vx0, y0)
        xvals=[xvals; x(:,1)];
        yvals=[yvals; y(:,1)];
    elseif choice==q_table(abs(round(y0))+1,3) %vx=0
        vx=0;
        [x, y]=slalom(vx0, vx, x0, y0);
        xvals=[xvals; x(:,1)];
        yvals=[yvals; y(:,1)];
     elseif choice==q_table(abs(round(y0))+1,3) %vx=vmax
         vx=vmax;
         [x, y]=slalom(vx0, vx, x0, y0);
         
                end
                vx0=vx; %update vx0, x0, and y0
                x0=x(11,1);
                y0=y(11,1);
            end