:- use_module(library(clpfd)).

sum(Nums) :-
    length(A, 10),
    length(B, 10),

    append([A, B], Nums),

    domain(Nums, 1, 9),

    get_num(A, NumA),
    get_num(B, NumB),

    NumA * NumB #= 1000000000,

    labeling([], Nums).

get_num([N|[]], N).

get_num([N|N1], Num) :-
    Next10 #= NextNum * 10,
    Num #= Next10 + N,
    get_num(N1, NextNum).
