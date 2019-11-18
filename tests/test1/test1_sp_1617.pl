:- dynamic vote/2.

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
raro(Movie) :-
    film(Movie, _, Duration, _),
    is_rare(Duration).

is_rare(Duration) :- Duration < 60.
is_rare(Duration) :- Duration > 120.

%2
happierGuy(User1, User2, HappierGuy) :-
    vote(User1, Rat1),
    countRatings(Rat1, C1),
    length(Rat1, L1),
    Avg1 is C1 / L1,
    vote(User2, Rat2),
    countRatings(Rat2, C2),
    length(Rat2, L2),
    Avg2 is C2 / L2,
    (
        Avg1 > Avg2,
        HappierGuy = User1;

        Avg2 > Avg1,
        HappierGuy = User2
    ), !.

countRatings([], 0) :- !.

countRatings([_-R1|OtherFilms], Count) :-
    countRatings(OtherFilms, C),
    Count is C + R1, !.

%3
likedBetter(User1, User2) :-
    vote(User1, Rat1),
    getMaxRating(Rat1, R1), 
    vote(User2, Rat2),
    getMaxRating(Rat2, R2),
    !,
    R1 > R2.

getMaxRating([_-LR|[]], LR) :- !.

getMaxRating([_-R1|OtherFilms], MaxRat) :-
    getMaxRating(OtherFilms, MR),
    (
        R1 > MR,
        MaxRat = R1;

        MaxRat = MR
    ), !.

%4
recommends(User, Movie) :-
    vote(User, FL), !,
    vote(User1, FL1), User1 \= User,
    is_similar(FL, FL1), 
    getFirstDiffFilm(FL, FL1, Movie), !.

is_similar([F1-_|[]], FL1) :-
    is_in_list(F1, FL1), !.

is_similar([F1-_|OtherFilms], FL1) :-
    is_in_list(F1, FL1), 
    is_similar(OtherFilms, FL1), !.

is_similar([_|OtherFilms], FL1) :-
    is_similar(OtherFilms, FL1).

is_in_list(_, []) :- !, fail.

is_in_list(F1, [F1-_|_]) :- !.

is_in_list(F1, [_|OtherFilms]) :-
    is_in_list(F1, OtherFilms), !.

getFirstDiffFilm(_, [], '') :- !.

getFirstDiffFilm(FL, [F1-_|OtherFilms], Movie) :-
    is_in_list(F1, FL),
    getFirstDiffFilm(FL, OtherFilms, Movie), !.

getFirstDiffFilm(_, [F1-_|_], F1) :- !.

%5
invert(PredicateSymbol, Arity) :-
    functor(T, PredicateSymbol, Arity),
    retract(T),
    invert(PredicateSymbol, Arity),
    assertz(T), !.

invert(_, _) :- !.

%6
onlyOne(User1, User2, OnlyOneList) :-
    vote(User1, M1),
    vote(User2, M2),
    findall(Mov, (member(Mov-_, M1), \+member(Mov-_, M2)), List1),
    findall(Mov, (member(Mov-_, M2), \+member(Mov-_, M1)), List2),
    append(List1, List2, OnlyOneList), !.

%7
filmVoting :-
    findall(Film, film(Film, _, _, _), FilmList),
    filmVoting(FilmList).

filmVoting([]) :- !.

filmVoting([FirstFilm|OtherFilms]) :-
    filmVoting(OtherFilms),
    findall(User-Vote, (vote(User, Movies), member(FirstFilm-Vote, Movies)), UsersVotes),
    assert(filmUsersVotes(FirstFilm, UsersVotes)), !.    

%8
dumpDataBase(FileName) :-
    tell(FileName), 
    dump_user,
    dump_film,
    dump_vote,
    told.

dump_user :-
    findall(user(Name, Birth, Country), user(Name, Birth, Country), Users),
    dump_list(Users).

dump_film :-
    findall(film(Title, Categories, Duration, Avg), film(Title, Categories, Duration, Avg), Films),
    dump_list(Films).

dump_vote :-
    findall(vote(User, List), vote(User, List), Votes),
    dump_list(Votes).

dump_list([]) :- !.

dump_list([H|T]) :-
    portray_clause(H),
    dump_list(T), !.