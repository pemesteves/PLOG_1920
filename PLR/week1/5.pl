:- use_module(library(clpfd)).

guards(Rooms) :-
    Rooms = [R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12],
    domain(Rooms, 1, 12),
    R1 + R2 + R3 + R4 #= 5,
    R1 + R5 + R7 + R9 #= 5,
    R4 + R6 + R8 + R12 #= 5,
    R9 + R10 + R11 + R12 #= 5,
    labeling([], Rooms).