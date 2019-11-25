
%a
substitui(_, _, [], []).

substitui(X, Y, [X|Lista1], Lista2) :- !,
    substitui(X, Y, Lista1, NovaLista),
    append([Y], NovaLista, Lista2).

substitui(X, Y, [H|Lista1], Lista2) :- !,
    substitui(X, Y, Lista1, NovaLista),
    append([H], NovaLista, Lista2).

%b
elimina_duplicados([LastElement|[]], [LastElement]) :- !.

elimina_duplicados([FirstElement|OtherElements], Lista2) :- !,
    elimina_duplicados(OtherElements, NovaLista),
    elim_duplicado(NovaLista, FirstElement, L2),
    append([FirstElement], L2, Lista2).

elim_duplicado([LastElement|[]], LastElement, []) :- !.

elim_duplicado([LastElement|[]], _, [LastElement]) :- !.

elim_duplicado([Elem|OtherElements], Elem, Lista) :- !,
    elim_duplicado(OtherElements, Elem, Lista).

elim_duplicado([FirstElement|OtherElements], Elem, Lista) :- !,
    elim_duplicado(OtherElements, Elem, NovaLista),
    append([FirstElement], NovaLista, Lista).