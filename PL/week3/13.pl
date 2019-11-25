%a
lista_ate(1, [1]) :- !.

lista_ate(N, L) :-
    N1 is N - 1,
    lista_ate(N1, L1),
    append(L1, [N], L), !.

%b
lista_entre(N1, N2, L) :-
    lista_ate(N2, L1),
    remove_less(N1, L1, L).


remove_less(_, [], []) :- !.

remove_less(N, [H|T], L) :-
    H >= N,
    append([H], T, L), !.

remove_less(N, [_|T], L) :-
    remove_less(N, T, L), !.

%c
soma_lista([], 0) :- !.

soma_lista([H|T], Soma) :-
    soma_lista(T, S),
    Soma is H + S, !.

%d
par(N) :- N =< 0, !, fail.

par(N) :- N mod 2 =:= 0, !.

par(_) :- !, fail.

%e
lista_pares(N, Lista) :-
    lista_ate(N, L), 
    pares(L, Lista), !.

pares([], []) :- !.

pares([H|T], L) :-
    par(H),
    pares(T, L1),
    append([H], L1, L), !.

pares([_|T], L) :-
    pares(T, L), !. 

%f
lista_impares(N, Lista) :-
    lista_ate(N, L), 
    impares(L, Lista), !.

impares([], []) :- !.

impares([H|T], L) :-
    \+par(H),
    impares(T, L1),
    append([H], L1, L), !.

impares([_|T], L) :-
    impares(T, L), !.