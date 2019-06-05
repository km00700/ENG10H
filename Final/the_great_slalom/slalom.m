function [x, y]=slalom(vx0, vx, x0, y0)
    vmax=2;
    vy0=-(vmax^2-vx0^2)^(0.5);
    vy=-(vmax^2-vx^2)^(0.5);
    tspan=[0:0.1:1]; %delta t is always one second
    xinitial=[x0; vx0];
    yinitial=[y0; vy0];
    [t,X]=ode23(@xvelocity, tspan, xinitial);
    [t,Y]=ode23(@yvelocity, tspan, yinitial);
    x=X;
    y=Y;
    function xdot=xvelocity(vx, t)
        xdot=[vx; (vx-vx0)];
    end
    function ydot=yvelocity(vy, t)
        ydot=[vy; vy-vy0];
    end
end