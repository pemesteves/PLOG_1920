%Examples

f(X,Y):- Y is X*X.

duplica(X,Y) :- Y is 2*X.

%Exercise

map([], _, []).

map([H|T], Transf, [H1|T1]) :-
    Res =.. [Transf, H, H1],
    Res,
    map(T, Transf, T1).