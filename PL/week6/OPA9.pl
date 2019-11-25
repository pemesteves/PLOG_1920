:- op(200, xfy, entre).
:- op(150, xfx, atual).
:- op(100, xfx, e).


entre(N1, N2, X) :-
    X entre N1 e N2 atual N1.

X entre N1 e N2 atual X :- 
    X >= N1,
    X =< N2.

X entre N1 e N2 atual Y :-
    Y >= N1,
    Y =< N2,
    Next is Y+1,
    X entre N1 e N2 atual Next.