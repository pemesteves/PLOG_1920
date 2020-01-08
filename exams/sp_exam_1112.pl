:- use_module(library(clpfd)).

%4
%4.a
seq(Vars) :-
    Vars = [_A, _B, C, _D, _E],

    C in {1, 2},

    domain(Vars, 1, 9),
    
    all_distinct(Vars),

    par_impar(Vars),

    labeling([], Vars).

par_impar([_|[]]).

par_impar([V1, V2|Vars]) :-
    (V1 mod 2 #= 0 #/\ V2 mod 2 #\= 0) #\/
    (V1 mod 2 #\= 0 #/\ V2 mod 2 #= 0),
    par_impar([V2|Vars]). 

%4.b
seqn(Vars, N) :-
    N mod 3 #= 0,
    N mod 2 #\= 0, 

    length(Vars, N),
    domain(Vars, 1, 9),

    count_nums(Vars, 1),

    par_impar(Vars),

    element(1, Vars, X),
    element(N, Vars, Y),

    Middle is (N + 1)//2,
    element(Middle, Vars, Z),

    Z #> X, Z #> Y,

    labeling([], Vars). 

count_nums(_, 10).

count_nums(Vars, N) :-
    count(N, Vars, #=<, 3),
    NextN is N + 1,
    count_nums(Vars, NextN).

%4.c 
/* ffc */