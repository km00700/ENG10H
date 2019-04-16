function f = lyapunov(A, B)
if size(A) == size(B)
    f = -1*(A' * B + B * A);
else
    f = "Matrix dimensions do not agree.";
end