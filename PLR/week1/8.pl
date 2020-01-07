:- use_module(library(clpfd)).

mercearia(Prods) :-
    Prods = [Arroz, Batatas, Esparguete, Atum],

    domain(Prods, 1, 711),

    all_distinct(Prods),

    711 #= Arroz + Batatas + Esparguete + Atum,
    711 * 100 * 100 * 100 #= Arroz * Batatas * Esparguete * Atum,   
    
    Batatas #> Atum, 
    Atum #> Arroz, 
    Esparguete #< Arroz,
    Esparguete #< Atum,
    Esparguete #< Batatas,
    (
        (Arroz mod 10 #= 0 #/\ (Batatas mod 10 #= 0 #\/ Atum mod 10 #= 0 #\/ Esparguete mod 10 #= 0)) #\/
        (Batatas mod 10 #= 0 #/\ (Atum mod 10 #= 0 #\/ Esparguete mod 10 #= 0)) #\/
        (Atum mod 10 #= 0 #/\ Esparguete mod 10 #= 0) 
    ),

    labeling([], Prods).