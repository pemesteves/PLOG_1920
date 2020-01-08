:- use_module(library(clpfd)).

%12
ups_and_downs(Min, Max, N, L) :-
    length(L, N),

    domain(L, Min, Max),

    oscila(L),

    labeling([], L).

oscila([L1, L2|[]]) :-
    L1 #< L2 #\/ L2 #< L1.

oscila([L1, L2, L3|L]) :-
    (L2 #< L1 #/\ L2 #< L3) #\/
    (L2 #> L1 #/\ L2 #> L3),
    oscila([L2, L3|L]).

%13
%concelho(Nome, Distancia, NEleitoresIndecisos)
concelho(x, 120, 410).
concelho(y, 10, 800).
concelho(z, 543, 2387).
concelho(w, 3, 38).
concelho(k, 234, 376).

%concelhos(+NDias, +MaxDist, -ConcelhosVisitados, -DistTotal, -TotalEleitores)
concelhos(NDias, MaxDist, ConcelhosVisitados, DistTotal, TotalEleitores) :-
    findall(C, concelho(C, _, _), ListaConcelhos),
    findall(D, concelho(_, D, _), ListaDistancias),
    findall(E, concelho(_, _, E), ListaEleitores),

    length(ListaConcelhos, NConcelhos),
    
    length(Concelhos, NDias),

    domain(Concelhos, 1, NConcelhos),
    domain([DistTotal], 0, MaxDist),

    all_distinct(Concelhos),

    TotalEleitores #>= 0,

    get_concelhos(ListaDistancias, ListaEleitores, Concelhos, DistTotal, TotalEleitores),

    append(Concelhos, [DistTotal], Vars),

    labeling([maximize(TotalEleitores)], Vars),

    get_concelhos_visitados(Concelhos, ListaConcelhos, ConcelhosVisitados).


get_concelhos(LD, LE, [Concelho|[]], Dist, Eleitores) :-
    element(Concelho, LD, Dist),
    element(Concelho, LE, Eleitores).

get_concelhos(LD, LE, [Concelho|Concelhos], Dist, Eleitores) :-
    element(Concelho, LD, D),
    element(Concelho, LE, E),
    Dist #= D + NextDist,
    Eleitores #= E + NextEleitores,
    get_concelhos(LD, LE, Concelhos, NextDist, NextEleitores).

get_concelhos_visitados([], _, []).

get_concelhos_visitados([Concelho|Concelhos], ListaConcelhos, [ConcelhoVisitado|ConcelhosVisitados]) :-
    nth1(Concelho, ListaConcelhos, ConcelhoVisitado),
    get_concelhos_visitados(Concelhos, ListaConcelhos, ConcelhosVisitados).

% TODO Acrescentar length variável na lista Concelhos de modo a passar o 4º teste 