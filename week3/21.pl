slice(L, I1, I2, R) :-
    getSlicedList(L, I1, I2, 1, R), !.

getSlicedList([], _, _, _, []) :- !.

getSlicedList(_, _, I2, I, []) :-
    I > I2, !.

getSlicedList([_|T], I1, I2, I, R) :-
    I < I1,
    NextI is I + 1,
    getSlicedList(T, I1, I2, NextI, R), !.

getSlicedList([H|T], I1, I2, I, R) :-
    NextI is I + 1,
    getSlicedList(T, I1, I2, NextI, R1),
    append([H], R1, R), !.