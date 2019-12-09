%1
% sequela(Título,Id,Tipo)
sequela('The Lord of the Rings',1,'fantasia').
sequela('Batman',2,'ficção científica').

% filme(IdSequela,Subtítulo,Ano,Personagens_e_Atores).
filme(1,'The Fellowship of the Ring',2001,[aragorn-'Viggo Mortensen',frodo-'Elijah Wood']).
filme(1,'The Two Towers',2002,[aragorn-'Viggo Mortensen',gandalf-'Ian McKellen']).
filme(1,'The Return of the King',2003,[aragorn-'Viggo Mortensen',frodo-'Elijah Wood']).
filme(2,'-',1989,[batman-'Michael Keaton',joker-'Jack Nicholson']).
filme(2,'Batman Returns',1992,[batman-'Michael Keaton',catwoman-'Michelle Pfeiffer']).
filme(2,'Batman Forever',1995,[batman-'Val Kilmer',robin-'Chris ODonnell',riddler-'Jim Carrey']).

%1.a
filme_de(Sequela, Subtitulo, Ano) :-
    sequela(Sequela, IdSequela, _),
    filme(IdSequela, Subtitulo, Ano, _).

%1.b
entrou_na_sequela(Ator, Sequela) :-
    filme(IdSequela, _, _, Actors),
    member(_-Ator, Actors),
    sequela(Sequela, IdSequela, _).

%1.c
atores(Subtitulo, ListaAtores) :-
    filme(_, Subtitulo, _, L),
    getActors(L, ListaAtores), !.

getActors([], []).

getActors([_-Actor|Actors], [Actor|L]) :-
    getActors(Actors, L), !.

%1.d
manteve_ator(Sequela, Personagem) :-
    sequela(Sequela, IdSequela, _),
    get_sequel_actors(IdSequela, [], S),
    manteve(Personagem, S).

get_sequel_actors(Sequela, LS, S) :-
    filme(Sequela, Name, _, _),
    \+member(Name, LS), 
    !,
    append(LS, [Name], NewLS), 
    get_sequel_actors(Sequela, NewLS, S1), 
    atoresPers(Name, LA),
    append([LA], S1, S), !.

get_sequel_actors(_, _, []) :- !.


manteve(_, [_|[]]) :- !.

manteve(P, [H, S|T]) :-
    (
        member(P-A1, H),
        member(P-A2, S),
        A1 = A2;

        \+member(P-A1, H);

        \+member(P-A2, S) %if some actor is not on the list
    ),
    !,  
    manteve(P, [S|T]), !.

manteve(_, _) :- !, fail.


atoresPers(Subtitulo, ListaAtores) :-
    filme(_, Subtitulo, _, L),
    getActorsPers(L, ListaAtores), !.

getActorsPers([], []).

getActorsPers([P-Actor|Actors], [P-Actor|L]) :-
    getActors(Actors, L), !.

%1.e
/*mostra_sequela(Sequela) :-
    sequela(Sequela, _, Tipo),
    write(Sequela), write(' ('), write(Tipo), write(')'), nl,
    !,
    filme_de(Sequela, Subtitulo, Ano),
    getActorsPers(Subtitulo, LA),
    write('\t'), write(Subtitulo), write(' ('), write(Ano), write(')'), nl,
    printActors(LA),
    fail.

mostra_sequela(_) :- !.

printActors([]) :- !.

printActors([P-A|OL]) :-
    write(\t\t), write(P), write(': '), write(A), nl,
    printActors(OL), !.*/