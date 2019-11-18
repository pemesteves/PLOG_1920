:- use_module(library(sets)).
:- dynamic film/4.

%film(Title, Categories, Duration, AvgClassification).
film('Doctor Strange', [action, adventure, fantasy], 115, 7.6).
film('Hacksaw Ridge', [biography, drama, romance], 131, 8.7).
film('Inferno', [action, adventure, crime], 121, 6.4).
film('Arrival', [drama, mystery, scifi], 116, 8.5).
film('The Accountant', [action, crime, drama], 127, 7.6).
film('The Girl on the Train', [drama, mystery, thriller], 112, 6.7).

%user(Username, YearOfBirth, Country).
user(john, 1992, 'USA').
user(jack, 1989, 'UK').
user(peter, 1983, 'Portugal').
user(harry, 1993, 'USA').
user(richard, 1982, 'USA').

%vote(Username, List_of_film-Rating).
vote(john, ['Inferno'-7, 'Doctor Strange'-9, 'The Accountant'-6]).
vote(jack, ['Inferno'-8, 'Doctor Strange'-8, 'The Accountant'-7]).
vote(peter, ['The Accountant'-4, 'Hacksaw Ridge'-7, 'The Girl on the Train'-3]).
vote(harry, ['Inferno'-7, 'The Accountant'-6]).
vote(richard, ['Inferno'-10, 'Hacksaw Ridge'-10, 'Arrival'-9]).

%1
curto(Movie) :-
    film(Movie, _, Duration, _),
    Duration < 125.

%2
diff(User1, User2, Difference, Film) :-
    vote(User1, List1), 
    vote(User2, List2), !,
    getRating(Film, List1, Rat1), !,
    getRating(Film, List2, Rat2), !,
    Diff is Rat1 - Rat2,
    Difference is abs(Diff).

getRating(_, [], _) :- !, fail.

getRating(Film, [Film1-Rat1|_], Rating) :-
    Film = Film1,
    Rating = Rat1.

getRating(Film, [Film1-_|Films], Rating) :-
    Film \= Film1,
    getRating(Film, Films, Rating).

%3
niceGuy(User) :-
    vote(User, List), 
    getNumSup8(List, Num), 
    Num >= 2.

getNumSup8([], 0).

getNumSup8([_-Rat|Films], Num) :-
    Rat >= 8,
    getNumSup8(Films, NewNum),
    Num is NewNum + 1.

getNumSup8([_-Rat|Films], Num) :-
    Rat < 8,
    getNumSup8(Films, Num).

%4
elemsComuns([], [], _) :- !.

elemsComuns([FirstElem|OtherElems], Common, List2) :-
    member(FirstElem, List2),
    elemsComuns(OtherElems, NewCommon, List2),
    append([FirstElem], NewCommon, Common), !.

elemsComuns([_|OtherElems], Common, List2) :-
    elemsComuns(OtherElems, Common, List2).

%5
printCategory(Category) :-
    film(Film, Categories, Duration, AvgClassification),
    findCategory(Categories, Category),
    write(Film),
    write(' ('),
    write(Duration),
    write('min, '),
    write(AvgClassification),
    write('/10)'), nl,
    fail.

printCategory(_) :- !.

findCategory([], _) :- !, fail.

findCategory([FirstCategory|_], Category) :-
    FirstCategory = Category, !.

findCategory([_|OtherCategories], Category) :-
    findCategory(OtherCategories, Category), !.

%6
similarity(Film1, Film2, Similarity) :-
    film(Film1, Cat1, Dur1, Clas1),
    film(Film2, Cat2, Dur2, Clas2),
    getCatNums(Cat1, Cat2, NumDiff, NumEqual),
    PercentCommonCat is NumEqual / NumDiff,
    DurDiff is abs(Dur1 - Dur2),
    ScoreDiff is abs(Clas1 - Clas2),
    Similarity is 100*PercentCommonCat - 3*DurDiff - 5*ScoreDiff.

getCatNums(Cat1, [], N, 0) :- length(Cat1, N), !.

getCatNums(Cat1, [FirstCat|OtherCats], NumDiff, NumEqual) :-
    member(FirstCat, Cat1),
    getCatNums(Cat1, OtherCats, NumDiff, N), 
    NumEqual is N + 1, !.

getCatNums(Cat1, [_|OtherCats], NumDiff, NumEqual) :-
    getCatNums(Cat1, OtherCats, N, NumEqual),
    NumDiff is N + 1, !.
    
%7
mostSimilar(Film, Similarity, Films) :-
    setof(Sim-Film2, (similarity(Film, Film2, Sim), Film2 \= Film), List),
    getBestFilms(List, Similarity, Films), !.

mostSimilar(_, Similarity, Films) :-
    Similarity = 0,
    Films = [], !.

getBestFilms([LastSim-_|[]], _, _) :-
    LastSim =< 10,
    !, fail.

getBestFilms([LastSim-LastFilm|[]], LastSim, [LastFilm]) :- !.

getBestFilms([Sim-Film|L], Similarity, Films) :-
    getBestFilms(L, Similarity, NewFilms),
    (
        Sim = Similarity,
        append([Film], NewFilms, Films);

        Films = NewFilms
    ), !.

%8
distancia(User1, Distancia, User2) :-
    vote(User1, List1),
    vote(User2, List2),
    filmCom(List1, Com, List2),
    getTotalClas(List1, List2, Com, Total),
    user(User1, Y1, C1),
    user(User2, Y2, C2),
    AgeDiff is abs(Y1 - Y2),
    getCountryDiff(C1, C2, CountryDiff),
    length(Com, NumCommon),
    AvgDiff is Total / NumCommon,
    Distancia is AvgDiff + AgeDiff / 3 + CountryDiff.

getCountryDiff(C, C, 0) :- !.

getCountryDiff(_, _, 2) :- !.

getTotalClas(_, _, [], 0).

getTotalClas(List1, List2, [FirstFilm|Others], Total) :-
    getTotalClas(List1, List2, Others, NewTotal),
    getRating(FirstFilm, List1, R1),
    getRating(FirstFilm, List2, R2),
    Rat is abs(R1 - R2),
    Total is Rat + NewTotal.


filmCom([], [], _) :- !.

filmCom([FirstElem-_|OtherElems], Common, List2) :-
    find_in_list(FirstElem, List2),
    filmCom(OtherElems, NewCommon, List2),
    append([FirstElem], NewCommon, Common), !.

filmCom([_|OtherElems], Common, List2) :-
    filmCom(OtherElems, Common, List2).

find_in_list(_, []) :- !, fail.

find_in_list(E, [E-_|_]) :- !.

find_in_list(E, [_-_|L]) :- find_in_list(E, L), !.

%9
update(Film) :-
    retract(film(Film, Categories, Duration, _)),
    findall(FR, vote(_, FR), L),
    getTotalRatings(Film, L, Total, NumRat), 
    Avg is Total / NumRat,
    assert(film(Film, Categories, Duration, Avg)).


getTotalRatings(_, [], 0, 0) :- !.

getTotalRatings(Film, [FR1|OtherFR], Total, NumRat) :-
    getRating(Film, FR1, Rating), 
    getTotalRatings(Film, OtherFR, NewTotal, NewNumRat),
    Total is NewTotal + Rating,
    NumRat is NewNumRat + 1, !.

getTotalRatings(Film, [_|OtherFR], Total, NumRat) :-
    getTotalRatings(Film, OtherFR, Total, NumRat), !.

%10
calculateUserAverageClassification(Username, AverageClassification) :-
    vote(Username, ListFilmRating), !, 
    findall(Rating, member(_F-Rating, ListFilmRating), Ratings), 
    length(Ratings, NumRatings),
    sumlist(Ratings, TotalRating),
    AverageClassification is TotalRating/NumRatings.

/*
Este predicado calcula a média de classificações atribuídas por um utilizador
O cut é verde, uma vez que não altera o resultado do programa. Serve apenas,
para o tornar mais eficiente, evitando a procura repetida da lista de votos
do utilizador
*/

%11
move(InPos, Celulas) :-
    setof(FinalPos, valid_move(InPos, FinalPos), Celulas).

valid_move(Row/Column, FinalPos) :-
    FinalRow is Row - 2,
    FinalRow > 0,
    (
        FinalColumn is Column + 1,
        FinalColumn =< 8;

        FinalColumn is Column - 1,
        FinalColumn > 0
    ), 
    FinalPos = FinalRow/FinalColumn.

valid_move(Row/Column, FinalPos) :-
    FinalRow is Row + 2,
    FinalRow =< 8,
    (
        FinalColumn is Column + 1,
        FinalColumn =< 8;

        FinalColumn is Column - 1,
        FinalColumn > 0
    ), 
    FinalPos = FinalRow/FinalColumn.

valid_move(Row/Column, FinalPos) :-
    FinalColumn is Column - 2,
    FinalColumn > 0,
    (
        FinalRow is Row + 1,
        FinalRow =< 8;

        FinalRow is Row - 1,
        FinalRow > 0
    ), 
    FinalPos = FinalRow/FinalColumn.

valid_move(Row/Column, FinalPos) :-
    FinalColumn is Column + 2,
    FinalColumn =< 8,
    (
        FinalRow is Row + 1,
        FinalRow =< 8;

        FinalRow is Row - 1,
        FinalRow > 0
    ), 
    FinalPos = FinalRow/FinalColumn.

%12
podeMoverEmN(InPos, N, ListaFinal) :-
    calcValidMoves(InPos, N, L),
    list_to_set(L, L1),
    sort(L1, ListaFinal).
    
calcValidMoves(_, 0, []) :- !.

calcValidMoves(InPos, N, L) :-
    move(InPos, LPos), 
    NextN is N - 1,
    call_calValidMoves(LPos, NextN, L1), 
    append(LPos, L1, L), !.

call_calValidMoves([], _, []) :- !.

call_calValidMoves([FirstPos|OtherPos], N, L) :-
    call_calValidMoves(OtherPos, N, L1),
    calcValidMoves(FirstPos, N, L2),
    append(L2, L1, L), !.

%13
minJogadas(PosIn, PosF, N) :-
    min_aux(PosIn, PosF, N), !.

min_aux(PosIn, PosF, N) :-
    move(PosIn, Cells),
    (
        member(PosF, Cells),
        N = 1;

        call_min_aux(Cells, PosF, N1),
        N is N1 + 1
    ), !.

call_min_aux([FPos|[]], PosF, N) :-
    min_aux(FPos, PosF, N), !.

call_min_aux([FPos|OtherPos], PosF, N) :-
    min_aux(FPos, PosF, N1), 
    call_min_aux(OtherPos, PosF, N2),
    (
        N1 < N2,
        N is N1;

        N is N2
    ), !.