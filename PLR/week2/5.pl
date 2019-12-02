:-use_module(library(clpfd)).

car_line(FirstCar) :-
    Sizes = [BlueSize, YellowSize, BlackSize, GreenSize], 
    Positions = [BluePosition, YellowPosition, BlackPosition, GreenPosition],
    
    domain(Sizes, 1, 4),
    domain(Positions, 1, 4),
    
    GreenSize #= 1,
    BlueSize #> GreenSize, YellowSize #> GreenSize, BlackSize #> GreenSize,    
    
    AfterBlue #= BluePosition + 1,
    BeforeBlue #= BluePosition - 1,
    element(BeforeBlue, Sizes, BeforeBlueSize),
    element(AfterBlue, Sizes, AfterBlueSize),
    BeforeBlueSize #< AfterBlueSize,
    
    GreenPosition #> BluePosition,
    YellowPosition #> BlackPosition,

    append(Positions, Sizes, List),

    labeling([], List), !,

    getFirstCar(Positions, FirstCar, 1), !.


getFirstCar([], FirstCar, _) :- FirstCar = naoDeterminado, !.

getFirstCar([1|_], FirstCar, 1) :- FirstCar = blue, !.
getFirstCar([1|_], FirstCar, 2) :- FirstCar = yellow, !.
getFirstCar([1|_], FirstCar, 3) :- FirstCar = black, !.
getFirstCar([1|_], FirstCar, 4) :- FirstCar = green, !.

getFirstCar([_|Cars], FirstCar, N) :- 
    N1 is N + 1,
    getFirstCar(Cars, FirstCar, N1), !.