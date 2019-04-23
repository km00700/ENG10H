function z = z2_function(x)
    z = z_function(x) / (0.0003*x(1).^8 + 0.002*x(2) + 1);
end