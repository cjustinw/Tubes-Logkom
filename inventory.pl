
:- dynamic(inventory/2).

initInventory  :-
    asserta(inventory([])).

pushItem(X,[],[X]).

pushItem(X,[H|T],[H|L]) :- 
    pushItem(X,T,L).

addInventory(Item) :-
    pushItem(Item,Inventory,NewInventory),
    retract(inventory(Inventory)),
    asserta(inventory(NewInventory)).

