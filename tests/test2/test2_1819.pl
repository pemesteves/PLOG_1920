:- use_module(library(clpfd)).
:- use_module(library(lists)).

%1
/*
 2^(NK)
*/

%2
/*
 K^N
*/

%3
pres(N, K, Vars) :-
    length(Vars, N),
    domain(Vars, 1, K),

    indices(1, Vars),

    labeling([], Vars).

indices(I, [V|Vs]) :-
    V mod 2 #\= I mod 2,
    I1 is I + 1,
    indices(I1, Vs).

indices(_, []).
/*
 O programa obtém solução em que a paridade entre os índices das pessoas e dos presentes é diferente.
*/

%4
/*
 Sim, mas apenas em algumas das variáveis
*/

%5
constroi_binarias(I, K, Vars, [LBin|LBins]) :-
    I =< K, !,
    constroi_bins(I, Vars, LBin),
    I1 is I+1,
    constroi_binarias(I1, K, Vars, LBins).

constroi_binarias(_, _, _, []).

constroi_bins(_, [], []).

constroi_bins(I, [Var|Vars], [LBin|LBins]) :-
    (I #= Var) #<=> LBin,
    constroi_bins(I, Vars, LBins).

%7
armario([[20, 30, 6, 50], [50, 75, 15, 125], [60, 90, 18, 150], [30, 45, 9, 75], [40, 60, 12, 100]]).
objetos([114-54, 305-30, 295-53, 376-39, 468-84, 114-48, 337-11, 259-80, 473-28, 386-55, 258-39, 391-37, 365-76, 251-18, 144-42, 399-94, 463-48, 473-9, 132-56, 367-8]).

prat(Prateleiras, Objetos, Vars) :-
    length(Objetos, N),
    length(Vars, N),

    append(Prateleiras, Armario),
    length(Armario, N1),
    domain(Vars, 1, N1),

    length(Prateleiras, N2),
    N3 is N2 + 1,
    N4 is ((N2 * N2) - N2) + 1,
    constraintWeights(1, N3, N4, Objetos, Vars),

    getTasks(Objetos, Tasks, Vars),
    getMachines(1, Armario, Machines),

    cumulatives(Tasks, Machines, [bound(upper)]),
    
    labeling([ffc], Vars).


getTasks([], [], []).

getTasks([_-Volume|Objetos], [task(1, 1, _, Volume, Var)|Tasks], [Var|Vars]) :-
    getTasks(Objetos, Tasks, Vars).

getMachines(_, [], []).

getMachines(Index, [Armario|Armarios], [machine(Index, Armario)|Machines]) :-
    NextIndex is Index + 1,
    getMachines(NextIndex, Armarios, Machines).

constraintWeights(N, _, N, _, _).

constraintWeights(N1, N2, MaxN, Objetos, Vars) :-
    countWeigth(N1, Objetos, Vars, Weight),
    countWeigth(N2, Objetos, Vars, Weight2),
    Weight #=< Weight2,
    NextN1 is N1 + 1,
    NextN2 is N2 + 1,
    constraintWeights(NextN1, NextN2, MaxN, Objetos, Vars).

countWeigth(_, [], [], 0).

countWeigth(N1, [ObjectWeight-_|Objetos], [Var|Vars], Weight) :-
    (Var #= N1 #/\ Weight #= NextWeight + ObjectWeight)
    #\/
    (Var #\= N1 #/\ Weight #= NextWeight),
    countWeigth(N1, Objetos, Vars, NextWeight).

%8
objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa, 2, 15).
homens(4).
tempo_max(60).

furniture :-
    tempo_max(TempoMax),
    homens(MaxTrabalhadores),

    findall(Nome-NumTrab-Tempo, objeto(Nome, NumTrab, Tempo), Objetos),

    length(Objetos, N),
    length(Start, N),
    length(End, N),

    domain(Start, 0, TempoMax),
    domain(End, 0, TempoMax),
    domain([X], 0, TempoMax),

    getTasks(1, Objetos, Start, End, Tasks),

    cumulative(Tasks, [limit(MaxTrabalhadores)]), 

    maximum(X, End),

    append([Start, End], Vars),

    labeling([minimize(X)], Vars),

    write('Total Time: '), write(X), nl,
    writeObjects(Tasks, Objetos).


getTasks(_, [], [], [], []).

getTasks(ID, [_-NumTrab-Tempo|Objetos], [StartI|Start], [EndI|End], [task(StartI, Tempo, EndI, NumTrab, ID)|Tasks]) :-
    NextID is ID + 1,
    getTasks(NextID, Objetos, Start, End, Tasks).

writeObjects([], []).

writeObjects([task(Start, _, End, _, _)|Tasks], [Nome-_-_|Objetos]) :-
    write(Nome), write(': '), write(Start-End), nl,
    writeObjects(Tasks, Objetos).