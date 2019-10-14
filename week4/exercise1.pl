:-use_module(library(lists)).

ligado(a,b). 
ligado(f,i).
ligado(a,c). 
ligado(f,j).
ligado(b,d). 
ligado(f,k).
ligado(b,e). 
ligado(g,l).
ligado(b,f). 
ligado(g,m).
ligado(c,g). 
ligado(k,n).
ligado(d,h). 
ligado(l,o).
ligado(d,i). 
ligado(i,f). 

%a)
dfs_search(Start, End, Solution):-
    dfs([], Start, End, Sol_inv),
    reverse(Sol_inv, Solution). 

dfs(Path, End, End, [End|Path]).
dfs(Path, Node, End, Sol):-
    ligado(Node, Node1),
    \+member(Node1, Path),
    profundidade([Node|Path], Node1, End, Sol).
