%Dados para teste
idade(maria,30).
idade(pedro,25).
idade(jose,25).
idade(rita,18). 

mais_proximos(Idade, [N|ListaProximos]) :-
    setof(Dif-Nome, diff(Idade, Dif, Nome), [D-N|L]),
    proximos(D, L, ListaProximos).

diff(I, Dif, Nome) :-
    idade(Nome, Id),
    Dif is abs(Id - I).

proximos(_, [], []) :- !.

proximos(D, [Dif-Nome|T], ListaProximos) :-
    Dif = D,
    proximos(D, T, L),
    append([Nome], L, ListaProximos), !.

proximos(_, _, []) :- !.