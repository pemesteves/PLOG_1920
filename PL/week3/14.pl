%a
primo(2).
primo(3).

primo(N) :-
    N1 is N // 2,
    N1 >= 2,
    e_primo(2, N1, N), !.

e_primo(Nf, Nf, N) :- N mod Nf =:= 0, !, fail.

e_primo(Nf, Nf, _) :- !.

e_primo(Ni, _, N) :- N mod Ni =:= 0, !, fail.

e_primo(Ni, Nf, N) :-
    NextNi is Ni + 1,
    e_primo(NextNi, Nf, N), !.

%b
lista_primos(N, Lista) :-
    lista_primos_N(N, Lista).


lista_primos_N(2, [2]) :- !.

lista_primos_N(N, L) :-
    primo(N),    
    NextN is N - 1,
    lista_primos_N(NextN, L1),
    append(L1, [N], L), !.

lista_primos_N(N, L) :-
    NextN is N - 1,
    lista_primos_N(NextN, L), !.
