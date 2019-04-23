alpha = 0.000002;
stopping_value = 0.1;
prev_point = [300, 50];
current_point = prev_point;
iterations = 0;
gradient = [100 100];


[X Y] = meshgrid(300:1:320,40:1:60);
Z = (0.04*X.^4)-(5*X.^2.*Y)+(0.01*Y.^4)-(0.3*X.^3.*Y)+(0.005*Y.^6)-(X.^3);
surf(X,Y,Z,'EdgeColor','None');
hold on;

while (norm(gradient) > stopping_value)
    iterations = iterations + 1;
    gradient = analytic_grad(current_point);
    current_point = prev_point - alpha * gradient;
    plot3(current_point(1), current_point(2), z_function(current_point),'m*');
    prev_point = current_point;
end


disp(current_point);
disp(z);
disp(gradient);
disp(iterations);
