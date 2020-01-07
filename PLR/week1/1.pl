:-use_module(library(clpfd)).
:-use_module(library(lists)).

%a
magic3x3(L) :-
    L = [E1, E2, E3, E4, E5, E6, E7, E8, E9],
    domain(L, 1, 9),
    all_different(L), 
    E1 + E2 + E3 #= Sum,
    E4 + E5 + E6 #= Sum,
    E7 + E8 + E9 #= Sum,
    E1 + E4 + E7 #= Sum,
    E2 + E5 + E8 #= Sum,
    E3 + E6 + E9 #= Sum,
    E1 + E5 + E9 #= Sum,
    E7 + E5 + E3 #= Sum,
    labeling([], L).


magic4x4(L) :-
    L = [E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15, E16],
    domain(L, 1, 16),
    all_different(L), 
    E1 + E2 + E3 + E4 #= Sum,
    E5 + E6 + E7 + E8 #= Sum,
    E9 + E10 + E11 + E12 #= Sum,
    E13 + E14 + E15 + E16 #= Sum,
    E1 + E5 + E9 + E13 #= Sum,
    E2 + E6 + E10 + E14 #= Sum,
    E3 + E7 + E11 + E15 #= Sum,
    E4 + E8 + E12 + E16 #= Sum,
    E1 + E6 + E11 + E16 #= Sum,
    E13 + E10 + E7 + E4 #= Sum,
    labeling([], L).

%b
magicNxN(N, L) :-
    NumElements is N*N,
    length(L, N),
    create_lists(L, N, NumElements), 
    append(L, Vars),
    all_distinct(Vars),

    sum_lines(L, Sum),
    sum_columns(L, N, 1, Sum),
    sum_diagonals(L, N, Sum),
    labeling([], Vars).

create_lists([], _, _).

create_lists([L|L1], N, NumElements) :-
    length(L, N),
    domain(L, 1, NumElements),
    create_lists(L1, N, NumElements).

sum_lines([], _).

sum_lines([L|L1], Sum) :-
    sum(L, #=, Sum),
    sum_lines(L1, Sum).

sum_columns(L, N, N, Sum) :-
    length(Column, N),
    get_column(L, N, Column),

    sum(Column, #=, Sum).

sum_columns(L, N, C, Sum) :-
    length(Column, N),
    get_column(L, C, Column),

    sum(Column, #=, Sum),

    NextColumn is C + 1,
    sum_columns(L, N, NextColumn, Sum).

get_column([], _, []).

get_column([L|L1], NCol, [C|C1]) :-
    element(NCol, L, C),
    get_column(L1, NCol, C1).

sum_diagonals(L, N, Sum) :-
    length(Diagonal1, N),
    get_diagonal_1(L, 1, Diagonal1),
    sum(Diagonal1, #=, Sum),

    length(Diagonal2, N),
    get_diagonal_2(L, N, Diagonal2),
    sum(Diagonal2, #=, Sum).

get_diagonal_1([], _, []).

get_diagonal_1([L|L1], NCol, [Value|Diagonal1]) :-
    element(NCol, L, Value),
    NextCol is NCol + 1,
    get_diagonal_1(L1, NextCol, Diagonal1).
    
get_diagonal_2([], _, []).

get_diagonal_2([L|L1], NCol, [Value|Diagonal2]) :-
    element(NCol, L, Value),
    NextCol is NCol - 1,
    get_diagonal_2(L1, NextCol, Diagonal2).