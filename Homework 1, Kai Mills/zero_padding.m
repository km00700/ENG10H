%Adds a border of zeroes around a matrix
function f = zero_padding(mat, border)
    %f = padarray(mat, floor([border border]));
    f = zeros(size(mat) + 2*border);
    for j = 1:size(mat,2)
        for i = 1:size(mat,1)
            f(i + border,j + border) = mat(i,j);
        end
    end
end