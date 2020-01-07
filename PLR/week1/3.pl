:- use_module(library(clpfd)).

%a
queens4x4(Cols) :-
    Cols = [R1, R2, R3, R4],
    domain(Cols, 1, 4),

    all_distinct(Cols),

    R1 #\= R2 + 1, R1 #\= R2 - 1,
    R1 #\= R3 + 2, R1 #\= R3 - 2,
    R1 #\= R4 + 3, R1 #\= R4 - 3,

    R2 #\= R3 + 1, R2 #\= R3 - 1,
    R2 #\= R4 + 2, R2 #\= R4 - 2,

    R3 #\= R4 + 1, R3 #\= R4 - 1,

    labeling([], Cols).

%b
queensNxN(N, Cols) :-
    length(Cols, N),
    domain(Cols, 1, N),

    all_distinct(Cols),

    constraint_colums(Cols),

    labeling([], Cols).

constraint_colums([]).

constraint_colums([Col|Cols]) :-
    const_col(Col, Cols, 1),
    constraint_colums(Cols).

const_col(_, [], _).

const_col(Col, [Col1|Cols], N) :-
    Col #\= Col1 + N,
    Col #\= Col1 - N,
    NextN is N + 1,
    const_col(Col, Cols, NextN).