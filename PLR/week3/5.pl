:- use_module(library(clpfd)).

domestic_tasks(Total, Tasks) :-
    length(Tasks, 4),
    domain(Tasks, 1, 2),
    global_cardinality(Tasks, [1-2, 2-2]),

    getTotal(Tasks, 1, Total),

    labeling([minimize(Total)], Tasks).


getTotal([], _, 0) :- !.

getTotal([Task|OtherTasks], 1, Total) :-
    getTotal(OtherTasks, 2, T1),
    Task #= 1 #/\ Total #= T1 + 45 #\/
    Task #= 2 #/\ Total #= T1 + 49, !.

getTotal([Task|OtherTasks], 2, Total) :-
    getTotal(OtherTasks, 3, T1),
    Task #= 1 #/\ Total #= T1 + 78 #\/
    Task #= 2 #/\ Total #= T1 + 72, !.

getTotal([Task|OtherTasks], 3, Total) :-
    getTotal(OtherTasks, 4, T1),
    Task #= 1 #/\ Total #= T1 + 36 #\/
    Task #= 2 #/\ Total #= T1 + 43, !.

getTotal([Task|OtherTasks], 4, Total) :-
    getTotal(OtherTasks, _, T1),
    Task #= 1 #/\ Total #= T1 + 29 #\/
    Task #= 2 #/\ Total #= T1 + 31, !.