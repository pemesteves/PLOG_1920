:- use_module(library(clpfd)).

count_equals(_, [], 0).

count_equals(Val, [V1|OtherValues], Count) :-
    Val #= V1 #<=> C1,
    Count #= C2 + C1,
    count_equals(Val, OtherValues, C2).