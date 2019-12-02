:- use_module(library(clpfd)).

turkeyCost(P, T) :-
    D1 in 1..9,
    D2 in 0..9,
    T #= D1*1000 + 670 + D2,
    P*72 #= T,
    labeling([], [P, T]).