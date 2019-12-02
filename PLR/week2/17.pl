:- use_module(library(clpfd)).

:- include('count_equals.pl').

other_car_line(FinalLine) :-
    Line = [Car1, Car2, Car3, Car4, Car5, Car6, Car7, Car8, Car9, Car10, Car11, Car12],
    domain(Line, 1, 4), % 1-yellow, 2-green, 3-red, 4-blue

    Car5 #= 4,
    Car1 #= Car12,
    Car2 #= Car11,

    count_equals(1, Line, 4), % 4 yellow cars
    count_equals(2, Line, 2), % 2 green cars
    count_equals(3, Line, 3), % 3 red cars
    count_equals(4, Line, 3), % 3 blue cars

    get_3_distinct(Line),
    count_sub_list(Line, 1), 

    labeling([], Line),
    substNumByColor(Line, FinalLine).


get_3_distinct([F, S, T|[]]) :-
    all_distinct([F, S, T]).

get_3_distinct([F, S, T|Rest]) :-
    all_distinct([F, S, T]),
    get_3_distinct([S, T|Rest]).

count_sub_list([_, _, _|[]], 0).

count_sub_list([C1, C2, C3, C4|OtherCars], Count) :-
    C1 #= 1 #/\ C2 #= 2 #/\ C3 #= 3 #/\ C4 #= 4 #<=> Count1,
    Count #= Count2 + Count1,
    count_sub_list([C2, C3, C4|OtherCars], Count2).


substNumByColor([], []).

substNumByColor([1|Cars], [yellow|OtherCars]) :-   
    substNumByColor(Cars, OtherCars).

substNumByColor([2|Cars], [green|OtherCars]) :-   
    substNumByColor(Cars, OtherCars).

substNumByColor([3|Cars], [red|OtherCars]) :-   
    substNumByColor(Cars, OtherCars).

substNumByColor([4|Cars], [blue|OtherCars]) :-   
    substNumByColor(Cars, OtherCars).