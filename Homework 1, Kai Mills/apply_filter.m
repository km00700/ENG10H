%Convolutes a matrix with a kernal
function f = apply_filter(kernal, mat)
    %f = conv2(mat, kernal, 'valid');
    matRows = size(mat,2);
    matCols = size(mat,1);
    kernalRows = size(kernal,2);
    kernalCols = size(kernal,1);
    
    f = zeros((size(mat) - size(kernal)) + 1);
    for j = 1: matRows - kernalRows + 1
        for i = 1: matCols - kernalCols + 1
            for y = 1:kernalRows
                for x = 1:kernalCols
                    if(0 < i + x - 1 & i + x - 1 <= matCols & ...
                            0 < j + y - 1 & j + y - 1 <= matRows)
                        f(i,j) = f(i,j) + mat(i + x - 1, j + y - 1) * ...
                            kernal(x,y);
                    end
                end
            end
        end
    end
end