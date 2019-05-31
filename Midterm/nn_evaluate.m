function f = nn_evaluate(A, B)
    total = 0;
    for(i=1:size(A,2))
        total = total + A(i)-B(i);
    end
    f = total / size(A,2);
end