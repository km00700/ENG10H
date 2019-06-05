function [x, y]=slalom(vx0, vx, x0, y0)
    vmax=2;
    vy0=-(vmax^2-vx0^2)^(0.5);
    vy=-(vmax^2-vx^2)^(0.5);
    ax=(vx-vx0); %makes acceleration constant
    ay=(vy-vy0);
    VX=[x0; vx0];
    VY=[y0; vy0];
    tspan=[0:0.1:1]; %delta t is always one second
    xinitial=[x0; vx0];
    yinitial=[y0; vy0];
    [t,X]=ode23(@xvelocity, tspan, xinitial);
    [t,Y]=ode23(@yvelocity, tspan, yinitial);
    x=X(:,1);
    y=Y(:,1);
    function xdot=xvelocity(t, VX)
        xdot=[VX(2,1); ax];
    end
    function ydot=yvelocity(t, VY)
        ydot=[VY(2,1); ay];
    end
end