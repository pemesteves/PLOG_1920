permutacao(L1, L2) :-
    length(L1, Len1),
    length(L2, Len2),
    Len1 = Len2,
    perm(L1, L1, L2).

perm([], _, _).

perm([Elem|OtherElem], L1, L2) :-
    conta_elem(Elem, L1, N1),
    conta_elem(Elem, L2, N2),
    N1 = N2,
    perm(OtherElem, L1, L2).

conta_elem(_, [], 0).

conta_elem(Elem, [FirtElem|OtherElem], N) :-
    FirtElem = Elem,
    conta_elem(Elem, OtherElem, N1),
    N is N1 + 1.

conta_elem(Elem, [FirtElem|OtherElem], N) :-
    FirtElem \= Elem,
    conta_elem(Elem, OtherElem, N).
    