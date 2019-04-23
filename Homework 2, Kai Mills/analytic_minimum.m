alpha = 0.000002;
stopping_value = 0.1;
prev_point = [300, 50];
current_point = prev_point;
iterations = 0;
gradient = [100 100];
z = 0;

while (norm(gradient) > stopping_value)
    iterations = iterations + 1;
    gradient = analytic_grad(current_point);
    current_point = prev_point - alpha * gradient;
    z = z_function(current_point);
    
    
    
    prev_point = current_point;
end

disp(current_point);
disp(z);
disp(gradient);
disp(iterations);
