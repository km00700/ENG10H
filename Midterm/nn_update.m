function f = nn_update(W_B, gradients, learning_rate)
    f = cell(size(W_B));
    for(i = 1:size(W_B, 1))
        for(j = 1:size(W_B, 2))
            f{i,j} = cell2mat(W_B(i,j)) - (learning_rate * cell2mat(gradients(i,j)));
        end
    end
end