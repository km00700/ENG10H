load q_values.mat
<<<<<<< HEAD

vmax=1.65; %APPEARS IN SLALOM_TRAIN
yfinal=-25; %APPEARS IN SLALOM_TRAIN

=======
vmax=1; %APPEARS IN SLALOM_TRAIN
yfinal=-10; %APPEARS IN SLALOM_TRAIN
>>>>>>> 3a5ced139bf8970718eef1e2a1f307e530563ff2
x0=0;
y0=0;
vx0=0;
xvals=[];
yvals=[];
xstarts=[];
ystarts=[];
tspan=[0:0.1:1];
time=0;
global ax ay
hold on
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
<<<<<<< HEAD
    if round(vx)==-round(vx0)
        vx=0;
        choice=2;
    end
    if(q_table(index, 1)==q_table(index, 2)&&q_table(index, 2)==q_table(index, 3))
        choice=2;
        vx=0;
=======
    if vx0==-vmax
        if vx==vmax
            vx=0;
        end
    elseif vx0==vmax
        if vx==-vmax
            vx=0;
        end
>>>>>>> 3a5ced139bf8970718eef1e2a1f307e530563ff2
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
    xstarts=[xstarts;x0];
    ystarts=[ystarts;y0];
end
disp("Time:");
disp(time);
rectangle('Position', [-2.5 yfinal 5 abs(yfinal)], 'EdgeColor', 'r', 'LineWidth', 1)
axis([-6 6 yfinal 0])
for i=1:length(flags)
    rectangle('Position', [flags(i,1)-0.5 flags(i,2)-0.5 1 1], 'FaceColor', 'g')
end
plot(xvals, yvals, '--b', 'LineWidth', 2);
plot(xstarts, ystarts, '*');
hold off;