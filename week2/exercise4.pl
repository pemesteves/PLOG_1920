%a)
factorial(0, 1).
factorial(1, 1).
factorial(N, Value) :- 
    N > 1,
    N1 is N - 1, factorial(N1, V1),
    Value is N * V1.

%b)
fibonacci(0,1).
fibonacci(1,1).
fibonacci(N,F):-
    N > 1,
    N1 is N - 1, fibonacci(N1,F1),
    N2 is N - 2, fibonacci(N2,F2),
    F is F1 + F2. 