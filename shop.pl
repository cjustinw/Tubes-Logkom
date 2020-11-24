/* Belum Selesai */

isGoldEnough(Gold,Price) :-
    Gold >= Price.

buyItem(Option) :-
    (
        Option =:= 1 ->
        (
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            isGoldEnough(Gold,50) -> 
                NewGold is Gold-50,
                addInventory(potion),
                retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,NewGold)),
                write('\nYou get potion\n'),!
        );
        (
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            \+isGoldEnough(Gold,50) -> 
                write('\nYour gold is not sufficient\n'),!
        )
    );
    (
        Option =:= 2 ->
        (
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            isGoldEnough(Gold,200) -> 
                NewGold is Gold-200,
                random(2,21,ID),
                item(ID,ItemName,_,_,_,_,_),
                addInventory(ItemName),
                retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,NewGold)),
                write('\nYou get '),write(ItemName),write('\n'),!
        );
        (
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            \+isGoldEnough(Gold,200) -> 
                write('\nYour gold is not sufficient\n'),!
        )
    ).

shop :- 
    write('\nWelcome to Shop\n'),
    write('What do you want to buy?\n'),
    write('1. Potion (50)\n'),
    write('2. Gacha Item (200)\n'),
    read(Option),
    buyItem(Option).

