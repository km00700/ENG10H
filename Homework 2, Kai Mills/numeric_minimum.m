%{
    NOTE: This implementation will get stuck at local minima! 
    (i.e. starting from -4, 4)
    This could be avoided by testing at multiple points and comparing the
    results, at the expense of time.
%}
alpha = 0.0004;
delta = 0.2;
stopping_value = 0.01;
prev_point = [4, 4];
current_point = prev_point;
iterations = 0;
gradient = [100 100];


[X Y] = meshgrid(-8:1:8,-8:1:8);
Z = ((0.04*X.^4)-(5*X.^2.*Y)+(0.01*Y.^4)-(0.3*X.^3.*Y)+(0.005*Y.^6)-(X.^3))...
    ./(0.0003*X.^8 + 0.002*Y + 1);
surf(X,Y,Z,'EdgeColor','None');
hold on;

%Iterates until the gradient is closer to zero than the stopping value and
%steps down the gradient by alpha units using numeric descent.
while (norm(gradient) > stopping_value)
    iterations = iterations + 1;
    gradient = numeric_grad(current_point, delta);
    current_point = prev_point - alpha * gradient;
    plot3(current_point(1), current_point(2), z2_function(current_point),'m*');
    prev_point = current_point;
end


disp("Minimum Point: " + current_point);
disp("Minimum Value: " + z2_function(current_point));
disp("Gradient: " + gradient);
disp("Iterations: " + iterations);

