inverter([], []).

inverter([FirstElement|OtherElements], L2) :-
    inverter(OtherElements, L),
    append(L, [FirstElement], L2).