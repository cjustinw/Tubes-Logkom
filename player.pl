
:- dynamic(player/10).
:- dynamic(playerEquipment/3).

generatePlayer(Username, JobID) :-
    JobID =:= 1,
    asserta(player(Username,swordsman,1,1000,1000,80,70,0,100,1000)),!.

generatePlayer(Username, JobID) :-
    JobID =:= 2,
    asserta(player(Username,archer,1,800,800,85,65,0,90,1000)),!.

generatePlayer(Username, JobID) :-
    JobID =:= 3,
    asserta(player(Username,sorcerer,1,900,900,75,75,0,90,1000)),!. 

levelUp :-
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    Job = swordsman,
    RequiredEXP is LVL*100,
    EXP >= RequiredEXP,
    NewLVL is LVL + 1,
    NewMaxHP is NewLVL*1000,
    NewATT is NewLVL*80,
    NewDEF is NewLVL*70,
    NewEXP is EXP-MaxEXP,
    NewMaxEXP is NewLVL*100,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,NewLVL,HP,NewMaxHP,NewATT,NewDEF,NewEXP,NewMaxEXP,Gold)),
    write('Congratulations! You achieve level '),
    write(NewLVL),!.

levelUp :-
    player(_,Job,LVL,_,_,_,_,EXP,_,_),
    Job = swordsman,
    RequiredEXP is LVL*100,
    EXP < RequiredEXP,
    write('Fight more enemies to level up!'),!.

levelUp :-
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    Job = archer,
    RequiredEXP is LVL*90,
    EXP >= RequiredEXP,
    NewLVL is LVL + 1,
    NewMaxHP is NewLVL*800,
    NewATT is NewLVL*85,
    NewDEF is NewLVL*65,
    NewEXP is EXP-MaxEXP,
    NewMaxEXP is NewLVL*90,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,NewLVL,HP,NewMaxHP,NewATT,NewDEF,NewEXP,NewMaxEXP,Gold)),
    write('Congratulations! You achieve level '),
    write(NewLVL),!.

levelUp :-
    player(_,Job,LVL,_,_,_,_,EXP,_,_),
    Job = archer,
    RequiredEXP is LVL*90,
    EXP < RequiredEXP,
    write('Fight more enemies to level up!'),!.

levelUp :-
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    Job = sorcerer,
    RequiredEXP is LVL*90,
    EXP >= RequiredEXP,
    NewLVL is LVL + 1,
    NewMaxHP is NewLVL*900,
    NewATT is NewLVL*75,
    NewDEF is NewLVL*75,
    NewEXP is EXP-MaxEXP,
    NewMaxEXP is NewLVL*90,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,NewLVL,HP,NewMaxHP,NewATT,NewDEF,NewEXP,NewMaxEXP,Gold)),
    write('Congratulations! You achieve level '),
    write(NewLVL),!.

levelUp :-
    player(_,Job,LVL,_,_,_,_,EXP,_,_),
    Job = sorcerer,
    RequiredEXP is LVL*90,
    EXP < RequiredEXP,
    write('Fight more enemies to level up!'),!.

initEquipment :-
    asserta(playerEquipment(empty,empty,empty)).

printEquipment :-
    playerEquipment(Weapon,Armor,Accessories),
    write('\nWeapon     : '),write(Weapon),
    write('\nArmor      : '),write(Armor),
    write('\nAccessories: '),write(Accessories),
    write('\n').

equipment :-
    write('\n1. Show your equipment'),
    write('\n2. Use item'),
    write('\n3. Return the item to inventory\n'),
    read(Option),
    equipmentAction(Option).

useItem(Item,_,_) :-
    \+isItemAvailable(Item) ->
    write('\nYou don\'t have this item\n'),!.

useItem(Item,Job,Type) :-
    isItemAvailable(Item),
        (
            (
                Type = sword,Job = swordsman,
                removeInventory(Item),
                playerEquipment(Weapon,Armor,Accessories),
                retract(playerEquipment(Weapon,Armor,Accessories)),
                asserta(playerEquipment(Item,Armor,Accessories)),!
            );
            (
                Type = sword,Job \= swordsman,
                write('\nYou cannot use this item\n'),!
            )
        );
        (
            (
                Type = bow,Job = archer,
                removeInventory(Item),
                playerEquipment(Weapon,Armor,Accessories),
                retract(playerEquipment(Weapon,Armor,Accessories)),
                asserta(playerEquipment(Item,Armor,Accessories)),!
            );
            (
                Type = bow,Job \= archer,
                write('\nYou cannot use this item\n'),!
            )
        );
        (
            (
                Type = wand,Job = sorcerer,
                removeInventory(Item),
                playerEquipment(Weapon,Armor,Accessories),
                retract(playerEquipment(Weapon,Armor,Accessories)),
                asserta(playerEquipment(Item,Armor,Accessories)),!
            );
            (
                Type = wand,Job \= sorcerer,
                write('\nYou cannot use this item\n'),!
            )
        );
        (
            Type = armor,
            removeInventory(Item),
            playerEquipment(Weapon,Armor,Accessories),
            retract(playerEquipment(Weapon,Armor,Accessories)),
            asserta(playerEquipment(Weapon,Item,Accessories)),!
        );
        (
            Type = accessories,
            removeInventory(Item),
            playerEquipment(Weapon,Armor,Accessories),
            retract(playerEquipment(Weapon,Armor,Accessories)),
            asserta(playerEquipment(Weapon,Armor,Item)),!
        ).

equipmentAction(Option) :-
    Option =:= 1,
    printEquipment,!.

equipmentAction(Option) :-
    Option =:= 2,
    inventory,
    write('\nWhat do you want to use?\n'),
    read(Item),
    player(_,Job,_,_,_,_,_,_,_,_),
    item(_,Item,Type,_,_,_,_),
    useItem(Item,Job,Type).
    