:- use_module(library(lists)).

:- dynamic played/4.

%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16
).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).


%1
achievedLittle(Player) :-
    played(Player, _, _, PercentUnlocked),
    PercentUnlocked < 10.

%2
isAgeAppropriate(Name, Game) :-
    player(Name, _, Age),
    game(Game, _, MinAge),
    Age >= MinAge.

%3
timePlayingGames(Player, Games, ListOfTimes, SumTimes) :-
    getTimes(Player, Games, ListOfTimes, SumTimes).

getTimes(_, [], [], 0).

getTimes(Player, [FirstGame|OtherGames], ListOfTimes, SumTimes) :-
    played(Player, FirstGame, HoursPlayed, _),
    getTimes(Player, OtherGames, NewList, NewSum),
    append([HoursPlayed], NewList, ListOfTimes),
    SumTimes is NewSum + HoursPlayed.

getTimes(Player, [FirstGame|OtherGames], ListOfTimes, SumTimes) :-
    \+played(Player, FirstGame, HoursPlayed, _),
    getTimes(Player, OtherGames, NewList, SumTimes),
    append([0], NewList, ListOfTimes).

%4
listGamesOfCategory(Cat) :-
    game(Game, Categories, MinAge),
    member(Cat, Categories),
    write(Game), write(' ('), write(MinAge), write(')'), nl,
    fail.

listGamesOfCategory(_).

%5
updatePlayer(Player, Game, Hours, Percentage) :-
    retract(played(Player, Game, PrevHours, PrevPercentage)), !,
    NewHours is PrevHours + Hours,
    NewPercentage is PrevPercentage + Percentage,
    assert(played(Player, Game, NewHours, NewPercentage)).

updatePlayer(Player, Game, Hours, Percentage) :-
    assert(played(Player, Game, Hours, Percentage)).

%6
littleAchievement(Player, Games) :-
    getAllGames(Player, [], Games).

getAllGames(Player, ListOfGames, Games) :-
    played(Player, Game, _, Percentage),
    \+member(Game, ListOfGames),
    append(ListOfGames, [Game], NewList), !,
    getAllGames(Player, NewList, NewGames), !,
    (
        Percentage < 20,
        append([Game], NewGames, Games);
        Games = NewGames
    ), !.

getAllGames(_, _, []) :- !.

%7
ageRange(MinAge, MaxAge, Players) :-
    findall(Player, valid_player(Player, MinAge, MaxAge), Players).

valid_player(Player, MinAge, MaxAge) :-
    player(Player, _, Age), 
    Age =< MaxAge,
    Age >= MinAge.

%8
averageAge(Game, AverageAge) :-
    findall(Age, (played(Player, Game, _, _), player(_, Player, Age)), PlayersAge),
    length(PlayersAge, NumPlayers),
    sumlist(PlayersAge, Total),
    AverageAge is Total / NumPlayers.

%9
mostEffectivePlayers(Game, Players) :-
    findall(Ef, (played(_, Game, Hours, Perc), Ef is Perc/Hours), EfList), !,
    getBestValue(EfList, BestValue), !,
    findall(Player, (played(Player, Game, Hours, Perc), Ef is Perc/Hours, Ef = BestValue), Players).

getBestValue([LastElement|[]], LastElement).

getBestValue([FirstElement|OtherElements], BestValue) :-
    getBestValue(OtherElements, NewValue),
    (
        FirstElement > NewValue,
        BestValue = FirstElement;
        BestValue = NewValue
    ).

%10
whatDoesItDo(X):-
    player(Y, X, Z), !,
    \+ (played(X, G, L, M),
        game(G, N, W),
        W > Z ).

whatDoesItDo(UserName) :-
    player(_, UserName, Age), !,
    \+ (played(UserName, Game, _, _),
        game(Game, _, MinAge),
        MinAge > Age).

/* 
É sugerida a mudança do predicado whatDoesItDo para o predicado acima:
    X -> UserName
    Y -> Name
    Z -> Age
    G -> Game
    L -> HoursPlayed
    M -> PercentUnlocked
    N -> Categories
    W -> MinAge
Algumas foram substituídas por _ porque não acrescentam nada de novo ao predicado

Este predicado verifica se o jogador com o UserName dado, jogou algum jogo para o qual tem idade mínima

O cut é verde, ou seja, apenas serve para melhorar a eficiência de execução do predicado
*/

%11
/*
Uma boa representação para armazenar esta informação é uma lista 
de listas, na qual cada linha contém mais 1 elemento que a anterior,
uma vez que a matrix é simétrica. Também é ignorada a primeira linha,
pois a matriz tem apenas 0's na diagonal.
Representação da matriz dada:
L = [[8], [8, 2], [7, 4, 3], [7, 4, 3, 1]]
*/

%12
areFar(Dist, Matriz, List) :-
    Line = 2,
    areFar_helper(Dist, Matriz, Line, List).

areFar_helper(_, [], _, []) :- !.

areFar_helper(Dist, [FirstLine|OtherLines], Line, List) :-
    NextLine is Line + 1, !,
    areFar_helper(Dist, OtherLines, NextLine, NewLineList),
    Column = 1, !,
    areFar_line_helper(Dist, FirstLine, Line, Column, LineList),
    append(LineList, NewLineList, List), !.

areFar_line_helper(_, [], _, _, []) :- !.

areFar_line_helper(Dist, [FirstElem|OtherElems], Line, Column, LineList) :-
    NextColumn is Column + 1,
    areFar_line_helper(Dist, OtherElems, Line, NextColumn, NewList),
    (
        FirstElem >= Dist,
        append([Line/Column], NewList, LineList);
        LineList = NewList
    ), !.

%13
/*
Estrutura proposta: lista com 1 inteiro, e dois elementos que podem 
ser de dois tipos (lista ou átomo (quando é folha)). Assim, ficam 
representados os 3 elementos necessários em cada nó: o id, o filho da 
esquerda e o filho da direita

L = [0, [ 1, [ 2, [ 3, [ 4, australia, [ 5, [6, staHelena, anguila],
    georgiaDoSul]], reinoUnido], [7, servia, franca]], [8, 
    [9, niger, india], irlanda]], brasil]
*/

%14
distance(C1, C2, Dendogram, Dist) :-
    D = 0,
    getDistance(C1, Dendogram, D, D1),
    getDistance(C2, Dendogram, D, D2),
    Dist is 1 + abs(D1 - D2).

%Percorrer até encontrar átomo certo. Se encontrar átomo errado voltar atrás
getDistance(C, [_, Left, Right], Dist, FinalDist) :-
    NewDist is Dist + 1,
    call_getDistance(C, Left, NewDist, OtheDist),
    (
        nonvar(OtheDist),
        FinalDist = OtheDist;

        call_getDistance(C, Right, NewDist, FinalDist)
    ), !.

call_getDistance(C, C, Dist, Dist) :- !.

call_getDistance(C, L, Dist, FinalDist) :-
    is_list(L),
    getDistance(C, L, Dist, FinalDist), !.

call_getDistance(_, NL, _, _) :-
    \+is_list(NL), !.

