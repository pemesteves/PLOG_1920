:- use_module(library(clpfd)).

musicos(Musicos) :-
    Nome = [Joao, Antonio, Francisco], 
    Instrumento = [_, Violino, Piano],
    Ensaio = [Terca, Quinta1, Quinta2], 

    append([Nome, Instrumento, Ensaio], Vars),
    domain(Vars, 1, 3),

    all_distinct(Nome),
    all_distinct(Instrumento),
    all_distinct(Ensaio),

    Joao #= 1,
    Antonio #= 2,
    Francisco #= 3,

    Antonio #\= Piano,
    Piano #= Terca,
    Joao #= Quinta1,
    Violino #= Quinta2,

    labeling([], Vars),

    musicos(Nome, Instrumento, Musicos).


musicos([], [], []).

musicos([Nome|Nomes], [Instrumento|Instrumentos], [Nome1-Instrumento1|Musicos]) :-
    nome(Nome, Nome1),
    instrumento(Instrumento, Instrumento1),    
    musicos(Nomes, Instrumentos, Musicos).

nome(1, joao).
nome(2, antonio).
nome(3, francisco).

instrumento(1, harpa).
instrumento(2, violino).
instrumento(3, piano).