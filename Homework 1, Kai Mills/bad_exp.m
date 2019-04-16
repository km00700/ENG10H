function f = bad_exp(A, n)
    f = 1;
    for i = 0: n - 1
        f = f * A;
    end