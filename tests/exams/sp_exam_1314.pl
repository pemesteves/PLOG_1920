%1
hours([7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5]).

%airTime(TvShow, DayOfWeek, Hour)
airTime('The Walking Dead',sunday,9).
airTime('Game of Thrones',sunday,8.5).
airTime('The Big Bang Theory',monday,8).
airTime('How I Met Your Mother',thursday,8).
airTime('Mad Men',sunday,10).

%views(TvShow, MillionsOfViews)
views('The Walking Dead',11).
views('Game of Thrones',5).
views('The Big Bang Theory',9).
views('Mad Men',2.5).
views('How I Met Your Mother',19).

%network(TvShow, Network)
network('The Walking Dead',amc).
network('Mad Men',amc).
network('Game of Thrones',hbo).
network('The Big Bang Theory',cbs).
network('How I Met Your Mother',cbs).

%1.a
tvShowNetwork(Network, DayOfWeek, Hour, TvShow) :-
    network(TvShow, Network),
    airTime(TvShow, DayOfWeek, Hour).

%1.b
mostViews(Network, TvShow, DayOfWeek, Hour) :- 
    getAllTvShows(Network, [], TvShows),
    sort(TvShows, [_-TvShow|_]),
    airTime(TvShow, DayOfWeek, Hour).


getAllTvShows(Network, ListTvShows, TvShows) :-
    network(TvShow, Network),
    \+member(_-TvShow, ListTvShows),
    views(TvShow, Views),
    InvertViews is 1 / Views, 
    append(ListTvShows, [InvertViews-TvShow], NewList),
    !,
    getAllTvShows(Network, NewList, TvShows), !.

getAllTvShows(_, ListTvShows, ListTvShows) :- !.

%1.c
hottestTvShows([], []) :- !.

hottestTvShows([FirstNetwork|OtherNetworks], [FirstTvShow|OtherTvShows]) :-
    hottestTvShows(OtherNetworks, OtherTvShows),
    mostViews(FirstNetwork, FirstTvShow, _, _), !.

%1.d
schedule(Network, DayOfWeek, Schedule) :-
    getTvShows(Network, DayOfWeek, [], TvShows),
    sort(TvShows, Schedule), !.

getTvShows(Network, DayOfWeek, ListTvShows, TvShows) :-
    network(TvShow, Network),
    \+member(_-TvShow, ListTvShows),
    airTime(TvShow, DayOfWeek, Hour), 
    append(ListTvShows, [Hour-TvShow], NewList),
    !,
    getTvShows(Network, DayOfWeek, NewList, TvShows), !.

getTvShows(_, _, TvShows, TvShows) :- !.

%1.e
averageViewers(Network, DayOfWeek, Average) :-
    getShowViews(Network, DayOfWeek, [], TvShows), 
    sumViews(TvShows, Sum),
    length(TvShows, L),
    Average is Sum / L.

getShowViews(Network, DayOfWeek, ListTvShows, TvShows) :-
    network(TvShow, Network),
    \+member(_-TvShow, ListTvShows),
    airTime(TvShow, DayOfWeek, _), 
    views(TvShow, Views),
    append(ListTvShows, [Views-TvShow], NewList),
    !,
    getShowViews(Network, DayOfWeek, NewList, TvShows), !.

getShowViews(_, _, TvShows, TvShows) :- !.

sumViews([], 0) :- !.

sumViews([Views-_|TvShows], Sum) :-
    sumViews(TvShows, S),
    Sum is S + Views, !.

%2
% projeto
%project(ProjID,Name). 
project(projA,qwe).

% tarefa de um projeto
%task(ProjID,TaskId,Description,NecessaryTime).
task(projA,t1,a,3).
task(projA,t2,b,2).
task(projA,t3,c,4).
task(projA,t4,d,2).

% precedência entre tarefas (TaskId1->TaskId2)
%precedence(ProjID,TaskId1,TaskId2). 
precedence(projA,t1,t2).
precedence(projA,t1,t3).
precedence(projA,t2,t4).
precedence(projA,t3,t4).

%2.a
proj_tasks(L) :-
    findall(Proj-Ntask, (project(Proj, _), 
                         findall(Task, task(Proj, Task, _, _), Tasks),
                         length(Tasks, Ntask)), L).

%2.b
p(X,P,D) :- task(X,Y,_,_), \+ precedence(X,_,Y), p(X,Y,P,D).
p(X,Y,[Y|P],D) :- precedence(X,Y,Z), task(X,Y,_,D1),
p(X,Z,P,D2), D is D1+D2.
p(X,Y,[Y],D) :- \+ precedence(X,Y,_), task(X,Y,_,D).
/*
O predicado p/3 procura para o projeto X, a lista P de tarefas a executar, 
calculando em D, o tempo total de espera para executar a última tarefa

?- p(projA, P, D).
 P = [t1, t2, t4],
 D = 7 ? ;
 P = [t1, t3, t4],
 D = 9
*/

%2.c
total_time(ProjectID, TotalTime) :-
    p(ProjectID, _, TotalTime), !.
