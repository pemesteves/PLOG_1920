:- use_module(library(clpfd)).

nums(Nums) :-
    Nums = [A, B, C],
    domain(Nums, 1, 100),

    all_distinct(Nums),

    A + B + C #= A * B * C,

    A #< B #/\ A #< C #/\ B #< C,

    labeling([], Nums).