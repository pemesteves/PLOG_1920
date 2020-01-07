:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(clpfd)).

%1
prog1(N, M, L1, L2) :-
    length(L1, N),
    N1 is N - 1, length(L2, N1),
    findall(E, between(1, M, E), LE),
    fill(L1, LE, LE_),
    fill(L2, LE_, _),
    check(L1, L2).

fill([], LEf, LEf).
fill([X|Xs], LE, LEf) :-
    select(X, LE, LE_),
    fill(Xs, LE_, LEf).

check([_], []).
check([A, B|R], [X|Xs]) :-
    A+B =:= X,
    check([B|R], Xs).

/*
 O programa cria duas listas L1 e L2, em que o comprimento de L1 é N e de L2 é N - 1.
 É gerada uma lista com todos os elementos do intervalo [1, M].
 Na primeira lista são colocados N elementos da lista gerada.
 Na segunda lista coloca as somas de cada par de números da primeira lista, tais que a soma pertence ao resto da lista gerada não utilizada na primeira lista.
*/

%2
/*
M^(2N-1)
*/

%3
prog2(N, M, L1, L2) :-
    length(L1, N),
    N1 is N - 1, length(L2, N1),
    domain(L1, 1, M),
    domain(L2, 1, M),
    append([L1, L2], Vars),
    all_distinct(Vars),
    check2(L1, L2),
    labeling([], L1).

check2([_], []).
check2([A, B|R], [X|Xs]) :-
    A+B #= X,
    check2([B|R], Xs).

%4
gym_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    length(MenHeights, N),
    length(WomenIndices, N),

    all_distinct(WomenIndices),

    make_pairs(MenHeights, WomenHeights, Delta, Pairs, WomenIndices),

    labeling([], WomenIndices).

make_pairs(MenHeights, WomenHeights, Delta, [MenIndex-WomenIndex|[]], [WomenIndex|[]]) :-
    element(MenIndex, MenHeights, MenHeight),
    element(WomenIndex, WomenHeights, WomenHeight),
    MenHeight #>= WomenHeight #/\ MenHeight - WomenHeight #=< Delta.

make_pairs(MenHeights, WomenHeights, Delta, [MenIndex-WomenIndex, MenNextIndex-WomenNextIndex|Pairs], [WomenIndex, WomenNextIndex|WomenIndices]) :-
    element(MenIndex, MenHeights, MenHeight),
    element(WomenIndex, WomenHeights, WomenHeight),
    MenHeight #>= WomenHeight #/\ MenHeight - WomenHeight #=< Delta,
    MenNextIndex #> MenIndex,
    make_pairs(MenHeights, WomenHeights, Delta, [MenNextIndex-WomenNextIndex|Pairs], [WomenNextIndex|WomenIndices]).

%5
optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    make_pairs_2(1, MenHeights, WomenHeights, Delta, Pairs, WomenIndices),
    
    all_distinct(WomenIndices),
    length(Pairs, N),
    length(WomenIndices, N),

    labeling([maximize(N)], WomenIndices), !.

 
make_pairs_2(_, [], _, _, [], []).

make_pairs_2(Iter, [MenHeight | MenHeights], WomenHeights, Delta, [Iter-WomenIndex | Pairs], [WomenIndex|WomenIndices]) :-
    element(WomenIndex, WomenHeights, WomenHeight),
    Diff #= MenHeight - WomenHeight,
    Diff #>= 0 #/\ Diff #< Delta,
    Next is Iter+1,
    make_pairs_2(Next, MenHeights, WomenHeights, Delta, Pairs, WomenIndices).

make_pairs_2(Iter, [_ | MenHeights], WomenHeights, Delta, Pairs, WomenIndices) :-
    Next is Iter+1,
    make_pairs_2(Next, MenHeights, WomenHeights, Delta, Pairs, WomenIndices).