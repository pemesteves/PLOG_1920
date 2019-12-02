puzzle(3,[0,S,E,N,D],[0,M,O,R,E],[M,O,N,E,Y]).
puzzle(1,[D,O,N,A,L,D],[G,E,R,A,L,D],[R,O,B,E,R,T]).
puzzle(2,[0,C,R,O,S,S],[0,R,O,A,D,S],[D,A,N,G,E,R]).

%a
money(Vars) :-
    Vars = [S, E, N, D, M, O, R, Y],
    domain(Vars, 0, 9),
    all_different(Vars),
    S #\= 0, M #\= 0,
    S * 1000 + E*100 + N*10 + D 
    + M*1000 + O*100 + R*10 + E
    #= M*10000 + O*1000 + N*100 + E*10 + Y,
    labeling([], Vars).

%b
robert(Vars) :-
    Vars = [D, O, N, A, L, G, E, R, B, T],
    domain(Vars, 0, 9),
    domain([C1, C2, C3, C4, C5], 0, 1),
    all_distinct(Vars),
    D #\= 0, G #\= 0, R #\= 0,
    D + D #= T + C1*10,
    L + L + C1 #= R + C2*10,
    A + A + C2 #= E + C3*10,
    N + R + C3 #= B + C4*10,
    O + E + C4 #= O + C5*10,
    D + G + C5 #= R,
    labeling([], Vars).

%d
/*criptogram(Id, Vars) :-
    puzzled(Id, First, Second, Result),*/
