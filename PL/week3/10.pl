%a
ordenada([_]). %Lista só com um elemento está ordenada

ordenada([E1, E2 | OtherElements]) :-
    E1 =< E2,
    ordenada([E2|OtherElements]).
