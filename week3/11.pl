achata_lista([], []) :- !.

achata_lista(Elem, [Elem]) :- atomic(Elem), !.

achata_lista([FirstElement|OtherElements], Lista) :- !,
    achata_lista(FirstElement, FirstList),
    achata_lista(OtherElements, NewList),
    append(FirstList, NewList, Lista).