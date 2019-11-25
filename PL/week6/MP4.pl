%a
functor2(Term, F, Arity) :-
    length(Args, Arity),
    T =.. [F|Args].

%b
arg2(N, Term, Arg) :-
    Term =.. [_|Args],
    nth1(N, Args, Arg).