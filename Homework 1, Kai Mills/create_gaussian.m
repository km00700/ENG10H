%Generates a square gaussian kernal of size n with standard deviation sigma
function f = create_gaussian(n, sigma)
    f = zeros(n);
    y_mid = n / 2 + 0.5;
    x_mid = n / 2 + 0.5;
    for j = 1:n
        for i = 1:n
            f(i,j) = (1 / (2 * pi * sigma^2)) * ...
                exp(-((i - y_mid)^2 + (j - x_mid)^2) / (2 * sigma^2));
        end 
    end
    f = (1 / sum(f, 'all')) * f;
end