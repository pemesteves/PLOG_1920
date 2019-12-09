:- use_module(library(clpfd)).

lazy_postman(TotalTime, Houses) :-
    length(FirstHouses, 9),
    append(FirstHouses, [6], Houses),
    domain(Houses, 1, 10),
    all_distinct(Houses),

    get_total(Houses, TotalTime),
    TotalTime #> 45,
    labeling([maximize(TotalTime)], Houses).



get_total([_], 0) :- !.

get_total([House, SecondHouse|OtherHouses], Total) :-
    get_total([SecondHouse|OtherHouses], T),
    Total #= abs(House - SecondHouse) + T, !.