A = rand(10);
exponent = 1000000;

bad_exp(A, exponent);
A^exponent;

%{
    Using the built-in exponent function, results in funtion run times
    under an average of 2ms. 
    Using the bad_exp function (which uses time-costly multiplicative
    operations) results in a processing time that approaches 800ms. 

    This difference isn't as noticable for low values of the exponent, as
    both operations are relatively fast, but the bad_exp increases processing 
    time exponentially.
%}