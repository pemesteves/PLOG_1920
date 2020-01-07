:- use_module(library(clpfd)).


zebra(Zebra, Agua) :-
    Cor = [Vermelha, Amarela, Azul, Verde, Branca],
    Nacionalidade = [Ingles, Espanhol, Noruegues, Portugues, Ucraniano],
    Bebida = [SumoLaranja, Cha, Cafe, Leite, Agua],
    Cigarros = [Marlboro, Chesterfields, Winston, LukyStrike, SGLights],
    Animal = [Cao, Raposa, Iguana, Cavalo, Zebra],

    append([Cor, Nacionalidade, Bebida, Cigarros, Animal], Vars),

    domain(Vars, 1, 5),

    all_distinct(Cor),
    all_distinct(Nacionalidade),
    all_distinct(Bebida),
    all_distinct(Cigarros),
    all_distinct(Animal),

    Ingles #= Vermelha,
    Espanhol #= Cao,
    Noruegues #= 1,
    Amarela #= Marlboro,
    abs(Chesterfields - Raposa) #= 1,
    abs(Noruegues - Azul) #= 1,
    Winston #= Iguana,
    LukyStrike #= SumoLaranja,
    Ucraniano #= Cha,
    Portugues #= SGLights,
    abs(Marlboro - Cavalo) #= 1,
    Verde #= Cafe,
    Verde - Branca #= 1,
    Leite #= 3,

    labeling([], Vars).