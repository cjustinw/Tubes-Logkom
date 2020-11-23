/* Belum Selesai */

:- dynamic(playerInventory/2).

initInventory  :-
    asserta(playerInventory([],0)).

isInventoryFull :-
    playerInventory(_,Total),
    Total =:= 100.

pushItem(X,[],[X]).

pushItem(X,[H|T],[H|L]) :- 
    pushItem(X,T,L).

deleteItem(A,[A|B],B).

deleteItem(A,[B,C|D],[B|E]) :- 
	deleteItem(A,[C|D],E),!.

addInventory(Item) :-
    playerInventory(Inventory,TotalItem),
    pushItem(Item,Inventory,NewInventory),
    NewTotalItem is TotalItem+1,
    retract(playerInventory(Inventory,TotalItem)),
    asserta(playerInventory(NewInventory,NewTotalItem)).

removeInventory(Item) :-
    playerInventory(Inventory,TotalItem),
    deleteItem(Item,Inventory,NewInventory),
    NewTotalItem is TotalItem-1,
    retract(playerInventory(Inventory,TotalItem)),
    asserta(playerInventory(NewInventory,NewTotalItem)).


isItemAvailable(Item) :-
    playerInventory(Inventory,_),
    member(Item,Inventory).

inventory :-
    playerInventory(Item,_),
    write(Item).

usePotion:-
    (
        \+isItemAvailable(potion) ->
            write('\nThere is no potion in your inventory\n')
    );
    (
        isItemAvailable(potion),
        item(_,ItemName,_,_,HPEffect,_),
        ItemName = potion,
        player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
        NewHP is HP+HPEffect,
        NewHP =< MaxHP ->
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            removeInventory(potion),!
    );
    (
        isItemAvailable(potion),
        item(_,ItemName,_,_,HPEffect,_),
        ItemName = potion,
        player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
        NewHP is HP+HPEffect,
        NewHP > MaxHP ->
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,MaxHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            removeInventory(potion),!
    ).
