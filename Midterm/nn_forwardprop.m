function f = nn_forwardprop(W_B, X)
    weights = W_B(:,1);
    biases = W_B(:,2);
    pre_activation = cell(size(W_B,1),1);
    post_activation = cell(size(W_B,1),1);
    
    input = X;
    
    for(x = 1:size(W_B,1))
        pre_activation{x,1} = (cell2mat(weights(x)) * input) + cell2mat(biases(x));
        post_activation{x,1} = tanh(cell2mat(pre_activation(x,1)));
        input = cell2mat(post_activation(x,1));
    end
    
    f = [pre_activation post_activation];
end