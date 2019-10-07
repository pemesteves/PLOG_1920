%a
membro(X, [X|_]).
membro(X, [_|L]) :-
    membro(X, L).

%b
membro(X, L) :- append(_, [X|_], L).

%c
last(L, X) :- append(_, [X], L).

%d
n_esimo(1, [X|_], X).
n_esimo(N, [_|L], X) :-
    N > 1,
    N1 is N - 1,
    n_esimo(N1, L, X).