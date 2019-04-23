%Uses partial derivatives of the function z to return the gradient of the 
%function z at point v
function f = analytic_grad(v) 
    f = [0 0];
    dz_dx = 0.16*v(1)^3 - 10*v(1)*v(2) - 0.9*v(2)*v(1)^2 - 3*v(1)^2;
    dz_dy = -5*v(1)^2 + 0.04*v(2)^3 - 0.3*v(1)^3 + 0.03*v(2)^5;
    f = [dz_dx, dz_dy];
end