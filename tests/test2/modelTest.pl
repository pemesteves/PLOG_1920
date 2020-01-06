:- use_module(library(clpfd)).
:- use_module(library(lists)).

%1
p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),
    test(Xs).

/*
O programa gera listas L2 com os elementos de uma lista L1 (em gen/2) e de seguida testa-os de modo que a lista fique ordenada de forma crescente ou decrescente sem elementos duplicados (test/2).
Sempre que o predicado test/2, que verifica as "restrições", ocorre backtracking para o predicado gen/2 que tenta gerar uma nova lista de valores se possível. 
O programa não é eficiente, já que este mecanismo de Generate & Test pode levar a muitos backtracks, o que leva a um tempo de execução e gastos de memória elevados. Assim, deviam ser utilizadas restrições com o mecanismo de propagação (forward checking), de modo a tornar o programa mais eficiente.
*/

%2
p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    %
    labeling([],Is),
    test(L2),
    fd_statistics.

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    nth1(I,L2,X),
    pos(Xs,L2,Is).

% As variáveis de domínio estão a ser instanciadas antes da fase de pesquisa e nem todas as restrições foram colocadas antes da fase da pesquisa.

%3 
p3(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    %
    new_test(L2),
    labeling([],Is),
    fd_statistics.

new_test([]).
new_test([_]).
new_test([_,_]).
new_test([X1,X2,X3|Xs]) :-
    (X1 #< X2 #/\ X2 #< X3) #\/ (X1 #> X2 #/\ X2 #> X3),
    test(Xs).

%4
sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs) :-
    Cookings = [A, B, C],
    length(RecipeEggs, L),
    
    domain(Cookings, 1, L),

    all_distinct(Cookings),
    
    domain([Eggs], 1, NEggs),

    element(A, RecipeTimes, Time1),
    element(A, RecipeEggs, Egg1),

    element(B, RecipeTimes, Time2),
    element(B, RecipeEggs, Egg2),

    element(C, RecipeTimes, Time3),
    element(C, RecipeEggs, Egg3),

    Time1 + Time2 + Time3 #=< MaxTime,

    MidEgg #= Egg1 + Egg2,

    Eggs #= MidEgg + Egg3,

    append([Cookings, [Eggs]], Vars),

    labeling([maximize(Eggs)], Vars).

%5
embrulha(Rolos, Presentes, RolosSelecionados) :-
    length(Presentes, N),
    length(RolosSelecionados, N),
    length(Rolos, N1),
    domain(RolosSelecionados, 1, N1),

    generate_tasks(Presentes, Tasks, RolosSelecionados),
    generate_machines(Rolos, Machines, 1),

    cumulatives(Tasks, Machines, [bound(upper)]),

    labeling([], RolosSelecionados).

generate_tasks([], [], []).

generate_tasks([P1|Presentes], [task(1, 1, _, P1, R1)|Tasks], [R1|RolosSelecionados]) :-
    generate_tasks(Presentes, Tasks, RolosSelecionados).

generate_machines([], [], _).

generate_machines([R1|Rolos], [machine(Counter, R1)|Machines], Counter) :-
    Next is Counter + 1,
    generate_machines(Rolos, Machines, Next).
    