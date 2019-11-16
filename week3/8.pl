%a
conta([], 0, 0).

conta([X|Xs], N, Nc) :-
    N1 is N - 1,
    conta(Xs, N1, Nc1),
    Nc is Nc1 + 1.

conta(L, N) :-
    conta(L, N, Nc),
    N = Nc.

%b
aux_conta_elem(_, [], 0, 0).

aux_conta_elem(X, [Y|Ys], N, Nc) :-
    X = Y,
    N1 is N-1,
    aux_conta_elem(X, Ys, N1, Nc1),
    Nc is Nc1 + 1.

aux_conta_elem(X, [Y|Ys], N, Nc) :-
    X \= Y,
    aux_conta_elem(X, Ys, N, Nc).

conta_elem(X, Lista, N) :-
    aux_conta_elem(X, Lista, N, Nc),
    N = Nc.
