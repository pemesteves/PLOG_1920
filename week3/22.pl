rodar(L, N, X) :-
    N > 0,
    getLists(L, N, L1, L2),
    append(L2, L1, X), !.

rodar(L, N, X) :-
    N < 0,
    length(L, Len),
    N1 is Len + N,
    getLists(L, N1, L1, L2),
    append(L2, L1, X), !.

rodar(L, _, L) :- !.

getLists([H|T], 1, [H], T) :- !.

getLists([H|T], N, L1, L2) :-
    NextN is N - 1, 
    getLists(T, NextN, L, L2),
    append([H], L, L1), !.