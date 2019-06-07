load q_values.mat
vmax=1.5; %APPEARS IN SLALOM_TRAIN
yfinal=-10; %APPEARS IN SLALOM_TRAIN
x0=0;
y0=0;
vx0=0;
xvals=[];
yvals=[];
tspan=[0:0.1:1];
time=0;
global ax ay
while y0>=yfinal && abs(x0)<=2.5
    time=time+1;
    index=(round(x0)+3)-5*round(y0);
    choice=max(q_table(index,:)); 
    if choice==q_table(index,1)
        vx=-vmax;
    elseif choice==q_table(index, 2)
        vx=0;
    elseif choice==q_table(index,3)
        vx=vmax;
    end
    if vx0==-vmax || vx0==vmax
        vx=0;
    end
    vy0=-(vmax^2-vx0^2)^(0.5);
    vy=-(vmax^2-vx^2)^(0.5);
    ax=vx-vx0;
    ay=vy-vy0;
    initial=[x0; vx0; y0; vy0];
    [t vals]=ode23(@slalom, tspan, initial);
    x=vals(:,1);
    vx=vals(:,2);       
    y=vals(:,3);
    xvals=[xvals;x];
    yvals=[yvals;y];
    vx0=vx(11,1);
    x0=x(11,1);
    y0=y(11,1);
end
rectangle('Position', [-2.5 yfinal 5 abs(yfinal)], 'EdgeColor', 'r', 'LineWidth', 1)
axis([-6 6 yfinal 0])
hold on
for i=1:length(flags)
    rectangle('Position', [flags(i,1)-0.5 flags(i,2)-0.5 1 1], 'FaceColor', 'g')
end
plot(xvals, yvals, '--b', 'LineWidth', 2)