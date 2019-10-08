%a
duplicar([], []).

duplicar([Y | Ys], X) :-
    duplicar(Ys, X1),
    append([Y], [Y], L),
    append(L, X1, X).

%b
duplicaElemN(X, 1, [X]).

duplicaElemN(X, N, L) :-
    N1 is N - 1,
    duplicaElemN(X, N1, L1),
    append([X], L1, L).

duplicarN([], _, []).

duplicarN([Y | Ys], N, X) :-
    duplicarN(Ys, N, X1),
    duplicaElemN(Y, N, L1),
    append(L1, X1, X).
