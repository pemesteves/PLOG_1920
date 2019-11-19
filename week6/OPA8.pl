:- op(900, fx, se).
:- op(850, xfx, entao).
:- op(800, xfx, senao).
:- op(100, xfx, :=).

se X entao Y senao _ :- X, !, Y.

se _ entao _ senao Z :- Z.

X := Y :- X = Y.