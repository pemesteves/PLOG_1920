/*
Perguntas 1 a 4 iguais ao teste modelo (modelTest.pl)
*/

%5
cut(Shelves, Boards, SelectedBoards) :-
    
    length(Shelves, N),
    length(SelectedBoards, N),

    length(Boards, N1),

    domain(SelectedBoards, 1, N1),

    create_tasks(Shelves, Tasks, SelectedBoards),
    create_machines(1, Boards, Machines),  

    cumulatives(Tasks, Machines, [bound(upper)]),

    labeling([], SelectedBoards).


create_tasks([], [], []).

create_tasks([Shelf|Shelves], [task(1, 1, _, Shelf, SelectedBoard)|Tasks], [SelectedBoard|SelectedBoards]) :-
    create_tasks(Shelves, Tasks, SelectedBoards).

create_machines(_, [], []).

create_machines(Id, [Board|Boards], [machine(Id, Board)|Machines]) :-
    NextId is Id + 1,
    create_machines(NextId, Boards, Machines).