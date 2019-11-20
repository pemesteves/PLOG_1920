:- use_module(library(lists)).

%airport(Name, ICAO, Country).
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO, Name, Year, Country).
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin, Destination, DepartureTime, Duration, Company).
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').


%1
short(Flight) :-
    flight(Flight, _, _, _, Duration, _), !,
    Duration < 90.

%2
shorter(Flight1, Flight2, ShorterFlight) :-
    flight(Flight1, _, _, _, Dur1, _), !,
    flight(Flight2, _, _, _, Dur2, _), !,
    (
        Dur1 < Dur2,
        ShorterFlight = Flight1, !;
        Dur2 < Dur1,
        ShorterFlight = Flight2, !;
        fail
    ).

%3
arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _, _, DepartureTime, Duration, _),
    calc_arrivalTime(DepartureTime, Duration, ArrivalTime).

calc_arrivalTime(DepartureTime, Duration, ArrivalTime) :-
    DepMins is DepartureTime mod 100,
    TotalMins is DepMins + Duration,
    Minutes is TotalMins mod 60,
    Hours = TotalMins // 60,
    ArrivalTime is DepartureTime + Hours*100 - DepMins + Minutes.

%4
countries(Company, ListOfCountries) :-
    company(Company, _, _, _),
    findCountries(Company, ListOfCountries, []), !.

countries(_, ListOfCountries) :-
    ListOfCountries = [].

findCountries(Company, [Country | ListOfCountries], Seen) :-
    airport(_, _, Country),
    companyOperatesInCountry(Company, Country),
    \+member(Country, Seen), !,
    findCountries(Company, ListOfCountries, [Country | Seen]).
    
findCountries(_, [], _) :- !.

companyOperatesInCountry(Company, Country) :-
    flight(_, Origin, Dest, _, _, Company),
    airport(_, Origin, OriginCountry),
    airport(_, Dest, DestCountry),
    (
        OriginCountry = Country;
        DestCountry = Country
    ), !.

%5
pairableFlights :-  
    is_pairable(F1, F2, Dest),
    write(Dest), write(' - '), write(F1), write(' \\ '), write(F2), nl,
    fail.

pairableFlights :- !.

is_pairable(F1, F2, Dest) :-
    flight(F1, _, Dest, _, _, _), 
    flight(F2, Dest, _, Dep2, _, _),
    arrivalTime(F1, T1), 
    Diff is ((Dep2 mod 100) + 60*(Dep2//100)) - ((T1 mod 100) + 60*(T1//100)),
    Diff >= 30, 
    Diff =< 90.

%6
tripDays([_], _, [], 1) :- !.

tripDays([Orig, Dest | Rest], Time, [DepTime | Times], Days) :-
    flight(F, Origin, Destination, DepTime, _, _),
    airport(_, Origin, Orig),
    airport(_, Destination, Dest),

    arrivalTime(F, ArrivalTime),
    calc_arrivalTime(ArrivalTime, 30, NextAvailable),
    tripDays([Dest | Rest], NextAvailable, Times, RemainingDays),
    (
        Time > ArrivalTime, Days is RemainingDays+1;
        Days is RemainingDays
    ), !.

%7
avgFlightLengthFromAirport(Airport, AvgLength) :-
    findall(Duration, flight(_, Airport, _, _, Duration, _), List),
    sumlist(List, Total),
    length(List, NumFlights),
    AvgLength is Total / NumFlights.

%8
mostInternational(ListOfCompanies) :-
    findall(Company, company(Company, _, _, _), Companies), %Get all the companies
    getMostInternational(Companies, _, ListOfCompanies).    

getMostInternational([], 0, []) :- !.

getMostInternational([FirstCompany|OtherCompanies], NumCountries, ListOfCompanies) :-
    getMostInternational(OtherCompanies, NewNumCountries, NewListOfCompanies), !,
    getCompanyCountries(FirstCompany, CompanyCountries), !,
    (
        CompanyCountries > NewNumCountries,
        ListOfCompanies = [FirstCompany],
        NumCountries = CompanyCountries;

        CompanyCountries = NewNumCountries,
        append([FirstCompany], NewListOfCompanies, ListOfCompanies),
        NumCountries = NewNumCountries;

        NumCountries = NewNumCountries,
        ListOfCompanies = NewListOfCompanies
    ), !.

getCompanyCountries(Company, NumCountries) :- 
    setof((Origin, Destiny), flight(_, Origin, Destiny, _, _, Company), Countries),
    length(Countries, NumCountries), !.

getCompanyCountries(_, 0) :- !. %If setof fails
    
%9
dif_max_2(X, Y) :- X < Y, X >= Y-2.

make_pairs([], _, []) :- !.

make_pairs(L, P, [X-Y|Zs]) :-
    select(X, L, L2),
    select(Y, L2, L3), 
    G =.. [P, X, Y], 
    G,
    make_pairs(L3, P, Zs).


%10 - Não funciona
/*make_pairs(L, P, [X-Y|Zs]) :-
    select(X, L, L2),
    select(Y, L2, L3), 
    G =.. [P, X, Y], 
    G,
    make_pairs(L3, P, Zs).

make_pairs(L, P, Zs) :-
    select(_X, L, L2),
    select(_Y, L2, L3),
    make_pairs(L3, P, Zs).*/

%11
make_max_pairs(L, P, S) :-
    setof(Sol, make_pairs(L, P, Sol), Solutions),
    get_max_list(Solutions, S).

get_max_list([], []) :- !.

get_max_list([FirstPair|OtherPairs], S) :-
    get_max_list(OtherPairs, S1),
    length(S1, L1),
    length(FirstPair, L),
    (
        L > L1,
        S = FirstPair;

        L =< L1,
        S = S1
    ), !.

%12