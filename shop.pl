/* Belum Selesai */

isGoldEnough(Gold,Price) :-
    Gold >= Price.

buyItem(Option) :-
    (
        player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
        Option =:= 1, isGoldEnough(Gold,50) -> 
            NewGold is Gold-50,
            addInventory(potion),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,NewGold)),!
    );
    (
        player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
        Option =:= 1, \+isGoldEnough(50) -> 
            write('\nYour gold is not sufficient\n')
    ).

shop :- 
    write('\nWelcome to Shop\n'),
    write('What do you want to buy?\n'),
    write('1. Potion (50)\n'),
    write('2. Gacha Item (200)\n'),
    read(Option),
    buyItem(Option).

