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
/*magicNxN(N, L) :-
    NumElements is N*N,
    length(L, NumElements), 
    domain(L, 1, NumElements),
    all_distinct(L),
    sum_lines(L, [], N, Sum),
    %sum_columns(L, [], N, Sum),
    %sum_diagonals(L, [], N, Sum),
    labeling([], L).

sum_lines([], _, _, _).

sum_lines([Elem|OtherElements], List, N, Sum) :-
    append([Elem], List, NewList),
    length(NewList, N),
    sumlist(NewList, NewSum) #= Sum,
    sum_lines(OtherElements, [], N, Sum).

sum_lines([Elem|OtherElements], List, N, Sum) :-
    append([Elem], List, NewList),
    \+length(NewList, N),
    sum_lines(OtherElements, NewList, N, Sum).*/