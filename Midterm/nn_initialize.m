function f = nn_initialize(neurons, inputs)
    working_array = [inputs neurons];
    f = cell(size(neurons,2), 2);
    for(x = 2:size(working_array,2))
        std_dev = sqrt(2 / (working_array(1,x) + working_array(1,x - 1)));
        W = zeros(working_array(1,x), working_array(1,x - 1));
        for(i = 1:size(W, 1))
            for(j = 1:size(W, 2))
                W(i,j) = normrnd(0, std_dev);
            end
        end
        b = zeros(working_array(1,x), 1);
        f(x - 1, 1) = {W};
        f(x - 1, 2) = {b};
    end
end