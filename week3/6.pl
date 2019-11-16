%a
delete_one(X, L1, L2) :-
    append(La, [X|Lb], L1),
    append(La, Lb, L2).

%b
delete_all(_, [], []).

delete_all(X, [X|Xs], Y) :- delete_all(X, Xs, Y).

delete_all(X, [T|Xs], [T|Y]) :-
    X \= T,
    delete_all(X, Xs, Y).

%c
delete_all_list([], _, _).

delete_all_list([X | Lx], L1, L2) :-
    delete_all(X, L1, Z), 
    delete_all_list(Lx, Z, L2), 
    (var(L2), L2 = Z;
     nonvar(L2)).