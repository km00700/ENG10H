% Takes existing weights and biases, pre and post-activated values,
% training results and the training input and returns a matrix of gradients
function f = nn_backprop(W_B, Z_A, Y, X)
    f = cell(size(W_B));
    num_layers = size(W_B,1);
    y_length = size(Y, 2);
    weights = W_B(:,1);
    biases = W_B(:,2);
    layer_out_values = Z_A(:,1);
    A = Z_A(:,2);
    d_W = cell(num_layers, 1);
    d_B = cell(num_layers, 1);
    
    dA = 2 * (cell2mat(A(num_layers)) - Y);
    dZ = dA .* (1 - cell2mat(A(num_layers)).^2);
    dA_prev = (cell2mat(weights(num_layers)))' * dZ;
    d_W{num_layers, 1} = dZ * dA_prev' / y_length;
    d_B{num_layers, 1} = sum(dZ, 2) / y_length;
    for(x = num_layers - 1:-1:1)
        dA = dA_prev;
        dZ = dA .* (1 - cell2mat(A(x)).^2);
        dA_prev = (cell2mat(weights(x)))' * dZ;
        if(x == 1)
            d_W{x, 1} = dZ * X' / y_length;
        else
            d_W{x, 1} = dZ * cell2mat(A(x - 1))' / y_length;
        end
        d_B{x, 1} = sum(dZ, 2) / y_length;
    end
    f = [d_W d_B];
end