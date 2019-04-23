%Uses small perturbations in the coordinate of v to approximate the
%gradient of the function z2 at point v
function f = numeric_grad(v, delta) 
    f = [0 0];
    dxi = [delta 0];
    dyi = [0 delta];
    dz_dx = (z2_function(v+dxi) - z2_function(v-dxi)) / 2*delta;
    dz_dy = (z2_function(v+dyi) - z2_function(v-dyi)) / 2*delta;
    f = [dz_dx, dz_dy];
end