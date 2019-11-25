dropN(L1, N, L2) :-
    drop(L1, N, 1, L2), !.

drop([], _, _, []) :- !.

drop([_|T], N, N, L) :-
    drop(T, N, 1, L), !.

drop([H|T], N, N1, L) :-
    N2 is N1 + 1,
    drop(T, N, N2, L1),
    append([H], L1, L), !.