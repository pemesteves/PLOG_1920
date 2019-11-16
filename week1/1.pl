male('Aldo Burrows').
male('Lincoln Burrows').
male('Michael Scofield').
male('LJ Burrows').

female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

%parent(parent_name, child_name).
parent('Aldo Burrows', 'Lincoln Burrows').
parent('Christina Rose Scofield', 'Lincoln Burrows').
parent('Aldo Burrows', 'Michael Scofield').
parent('Christina Rose Scofield', 'Michael Scofield').
parent('Lisa Rix', 'LJ Burrows').
parent('Lincoln Burrows').
parent('Michael Scofield', 'Ella Scofield').
parent('Sara Tancredi', 'Ella Scofield').

%parents(child_name, father_name, mother_name).
parents(X, Dad, Mom) :- 
    parent(Dad, X), 
    male(Dad), 
    parent(Mom, X),
    female(Mom).

%a) parents('Michael Scofield', Dad, Mom).

%son(parent_name)
son(X, Son) :-
    parent(X, Son),
    male(Son).

%b) son('Aldo Burrows', Son).