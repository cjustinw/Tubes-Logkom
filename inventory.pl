/* Belum Selesai */

:- dynamic(playerInventory/2).

initInventory  :-
    asserta(playerInventory([],0)),
    addInventory(potion),
    addInventory(potion),
    addInventory(potion),
    addInventory(potion),
    addInventory(potion).

isInventoryFull :-
    playerInventory(_,Total),
    Total =:= 100.

isInventoryEmpty :-
    playerInventory(_,Total),
    Total =:= 0.

pushItem(X,[],[X]).

pushItem(X,[H|T],[H|L]) :- 
    pushItem(X,T,L).

deleteItem(A,[A|B],B).

deleteItem(A,[B,C|D],[B|E]) :- 
	deleteItem(A,[C|D],E),!.

addInventory(_) :-
    isInventoryFull,
    write('\nYour inventory is full\n'),!.

addInventory(Item) :-
    \+isInventoryFull,
    playerInventory(Inventory,Total),
    \+member([Item,_],Inventory),
    pushItem([Item,1],Inventory,NewInventory),
    NewTotal is Total+1,
    retract(playerInventory(Inventory,Total)),
    asserta(playerInventory(NewInventory,NewTotal)).

addInventory(Item) :-
    \+isInventoryFull, 
    playerInventory(Inventory,Total),
    member([Item,TotalItem],Inventory),
    deleteItem([Item,TotalItem],Inventory,Inventorytmp),
    NewTotalItem is TotalItem + 1,
    pushItem([Item,NewTotalItem],Inventorytmp,NewInventory),
    NewTotal is Total+1,
    retract(playerInventory(Inventory,Total)),
    asserta(playerInventory(NewInventory,NewTotal)),!.

removeInventory(Item) :-
    \+isInventoryEmpty,
    playerInventory(Inventory,_),
    \+member([Item,_],Inventory),
    write('\nYou don\'t have '),write(Item),write(' to remove\n'),!.

removeInventory(Item) :-
    \+isInventoryEmpty,
    playerInventory(Inventory,Total),
    member([Item,TotalItem],Inventory),
    TotalItem =:= 1,
    deleteItem([Item,TotalItem],Inventory,NewInventory),
    NewTotal is Total-1,
    retract(playerInventory(Inventory,Total)),
    asserta(playerInventory(NewInventory,NewTotal)),!.

removeInventory(Item) :-
    \+isInventoryEmpty,
    playerInventory(Inventory,Total),
    member([Item,TotalItem],Inventory),
    TotalItem > 1,
    deleteItem([Item,TotalItem],Inventory,Inventorytmp),
    NewTotalItem is TotalItem - 1,
    pushItem([Item,NewTotalItem],Inventorytmp,NewInventory),
    NewTotal is Total-1,
    retract(playerInventory(Inventory,Total)),
    asserta(playerInventory(NewInventory,NewTotal)),!.

isItemAvailable(Item) :-
    playerInventory(Inventory,_),
    member([Item,_],Inventory).

printInventory([]).
printInventory([[A|[B|_]]|T]) :-
    write(B),write(' '),write(A),write('\n'),
    printInventory(T).

inventory :-
    (
        isInventoryEmpty ->
            write('\nempty\n')
    );
    (
        \+isInventoryEmpty ->
            playerInventory(Inventory,_),
            printInventory(Inventory)
    ).

usePotion:-
    (
        \+isItemAvailable(potion) ->
            write('\nThere is no potion in your inventory\n')
    );
    (
        isItemAvailable(potion),
        item(_,ItemName,_,_,_,HPEffect,_),
        ItemName = potion,
        player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
        NewHP is HP+HPEffect,
        NewHP =< MaxHP ->
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            removeInventory(potion),
            write('\nYou heal 500 exp\n'),!
    );
    (
        isItemAvailable(potion),
        item(_,ItemName,_,_,_,HPEffect,_),
        ItemName = potion,
        player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
        NewHP is HP+HPEffect,
        NewHP > MaxHP ->
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,MaxHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            removeInventory(potion),
            Heal is MaxHP-HP,
            write('\nYou heal '),write(Heal),write('exp\n'),!
    ).
