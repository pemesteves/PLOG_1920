male(phil).
male(luke).
female(claire).
parent(phil, luke).

father(X, Y):- parent(X, Y), male(X).
father(aldo, chris).
