%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

%1
madeItThrough(Participant) :-
    performance(Participant, Performance),
    pressButton(Performance).

pressButton([]) :- fail.

pressButton([120|_]).

pressButton([_|List]) :-
    pressButton(List).

%2
juriTimes(Participants, JuriMember, Times, Total) :-
    jTimes(Participants, JuriMember, Times), 
    getTotal(Times, Total).

jTimes([], _, []).

jTimes([P|T], JuriMember, Time) :-
    performance(P, Performance), 
    getValue(Performance, JuriMember, T2),
    jTimes(T, JuriMember, T1),
    append([T2], T1, Time).
    
getValue([P|_], 1, P).

getValue([_|T], JuriMember, Value):-
    NextJuri is JuriMember-1,
    getValue(T, NextJuri, V1),
    Value is V1.

getTotal([], 0).

getTotal([T|T1], Total) :-
    getTotal(T1, Tot),
    Total is Tot + T.

%3 
patientJuri(JuriMember) :-
    getAllPerformance(ListOfPerformances, []), 
    juriNotPressedButton(ListOfPerformances, JuriMember, NumPressed), !, 
    NumPressed >= 2.

juriNotPressedButton([], _, 0).

juriNotPressedButton([FirstPerformance|OtherPerformances], JuriMember, NumPressed) :-
    juriNotPressedButton(OtherPerformances, JuriMember, NewNumPressed),
    getValue(FirstPerformance, JuriMember, Result), 
    (
        Result = 120,
        NumPressed is NewNumPressed + 1;
        NumPressed is NewNumPressed
    ).

getAllPerformance(ListOfPerformances, ListOfIds) :-
    (
        performance(ID, Performance),
        \+member(ID, ListOfIds), !,
        append(ListOfIds, [ID], NewListOfIDs), !,
        getAllPerformance(NewListOfPerformances, NewListOfIDs),
        append([Performance], NewListOfPerformances, ListOfPerformances); 
        true
    ).

%4
bestParticipant(P1, P2, P) :-
    performance(P1, Perf1), 
    getTotal(Perf1, Tot1),
    performance(P2, Perf2),
    getTotal(Perf2, Tot2),
    getMax(Tot1, Tot2, MaxValue),
    (
        MaxValue = Tot1,
        P is P1;
        MaxValue = Tot2,
        P is P2
    ).

getMax(P1, P2, Max) :-
    P1 > P2,
    Max is P1.

getMax(P1, P2, Max) :-
    P2 > P1,
    Max is P2.

%5
allPerfs :-
    getAllPerformance(Performances, IDs), !,
    printEachPerformance(Performances, IDs).

printEachPerformance([], []).

printEachPerformance([FirstPerformance|OtherPerformances], [FirstID|OtherIDs]) :-
    participant(FirstID, _, PerformanceName), !,
    write(FirstID),
    write(':'),
    write(PerformanceName), 
    write(':['),
    print_list(FirstPerformance), nl, !,
    printEachPerformance(OtherPerformances, OtherIDs).

print_list([LastElem|[]]) :-
    write(LastElem),
    write(']').

print_list([FirstElem|OtherElems]) :-
    write(FirstElem), 
    write(','),
    print_list(OtherElems).

%6
nSuccessfulParticipants(T) :- %TODO
    setof(X, madeItThrough(X), L),
    length(L, T).