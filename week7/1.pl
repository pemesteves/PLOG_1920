%a
salto_cavalo(Quad1, Quad2) :-
    valid_move(Quad1, Quad2).

valid_move(X/Y, NewX/NewY) :-
    move(X/Y, NewX/NewY),
    NewX >= 1,
    NewX =< 8,
    NewY >= 1,
    NewY =< 8.

move(X/Y, NewX/NewY) :-
    NewX is X - 2,
    NewY is Y - 1. 

move(X/Y, NewX/NewY) :-
    NewX is X - 2,
    NewY is Y + 1.

move(X/Y, NewX/NewY) :-
    NewX is X + 2,
    NewY is Y - 1.

move(X/Y, NewX/NewY) :-
    NewX is X + 2,
    NewY is Y + 1.

move(X/Y, NewX/NewY) :-
    NewY is Y - 2,
    NewX is X - 1.

move(X/Y, NewX/NewY) :-
    NewY is Y + 2,
    NewX is X - 1.

move(X/Y, NewX/NewY) :-
    NewY is Y - 2,
    NewX is X + 1.

move(X/Y, NewX/NewY) :-
    NewY is Y + 2,
    NewX is X + 1.    

%b
trajeto_cavalo([_|[]]) :- !.

trajeto_cavalo([P1,P2|Traj]) :-
    salto_cavalo(P1, P2),
    trajeto_cavalo([P2|Traj]), !.

%c
trajeto_cavalo([2/1, J1, 5/4, J3, J4x/8]).