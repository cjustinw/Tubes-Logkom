
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
    write('\nCongratulations! You achieve level '),
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
    write('\nCongratulations! You achieve level '),
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
    write('\nCongratulations! You achieve level '),
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
    write('\n1. Show your equipments'),
    write('\n2. Use an item'),
    write('\n3. Return an item to inventory\n'),
    read(Option),
    equipmentAction(Option).

useItem(Item,Job,Type) :-
    isItemAvailable(Item),
        (
            (
                Type = sword,Job = swordsman,
                playerEquipment(Weapon,Armor,Accessories),
                (
                    Weapon = empty,
                    removeInventory(Item),
                    retract(playerEquipment(Weapon,Armor,Accessories)),
                    asserta(playerEquipment(Item,Armor,Accessories)),
                    item(_,Item,_,EquipmentATT,_,_,_),
                    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
                    NewATT is ATT+EquipmentATT,
                    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                    asserta(player(Username,Job,LVL,HP,MaxHP,NewATT,DEF,EXP,MaxEXP,Gold)),!,!
                );
                (
                    Weapon \= empty,
                    write('\nYou have already equipped a sword!\n'),!
                ) 
            );
            (
                Type = sword,Job \= swordsman,
                write('\nYou can not use this item\n'),!
            )
        );
        (
            (
                Type = bow,Job = archer,
                playerEquipment(Weapon,Armor,Accessories),
                (
                    Weapon = empty,
                    removeInventory(Item),
                    retract(playerEquipment(Weapon,Armor,Accessories)),
                    asserta(playerEquipment(Item,Armor,Accessories)),
                    item(_,Item,_,EquipmentATT,_,_,_),
                    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
                    NewATT is ATT+EquipmentATT,
                    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                    asserta(player(Username,Job,LVL,HP,MaxHP,NewATT,DEF,EXP,MaxEXP,Gold)),!
                );
                (
                    Weapon \= empty,
                    write('\nYou have already equipped a bow!\n'),!
                ) 
            );
            (
                Type = bow,Job \= archer,
                write('\nYou can not use this item\n'),!
            )
        );
        (
            (
                Type = wand,Job = sorcerer,
                playerEquipment(Weapon,Armor,Accessories),
                (
                    Weapon = empty,
                    removeInventory(Item),
                    retract(playerEquipment(Weapon,Armor,Accessories)),
                    asserta(playerEquipment(Item,Armor,Accessories)),
                    item(_,Item,_,EquipmentATT,_,_,_),
                    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
                    NewATT is ATT+EquipmentATT,
                    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                    asserta(player(Username,Job,LVL,HP,MaxHP,NewATT,DEF,EXP,MaxEXP,Gold)),!
                );
                (
                    Weapon \= empty,
                    write('\nYou have already equipped a wand!\n'),!
                ) 
            );
            (
                Type = wand,Job \= sorcerer,
                write('\nYou can not use this item\n'),!
            )
        );
        (
            Type = armor,
            playerEquipment(Weapon,Armor,Accessories),
            (
                Armor = empty,
                removeInventory(Item),
                retract(playerEquipment(Weapon,Armor,Accessories)),
                asserta(playerEquipment(Weapon,Item,Accessories)),
                item(_,Item,_,_,EquipmentDEF,_,_),
                player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
                NewDEF is DEF+EquipmentDEF,
                retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                asserta(player(Username,Job,LVL,HP,MaxHP,ATT,NewDEF,EXP,MaxEXP,Gold)),!
            );
            (
                Armor \= empty,
                write('\nYou have already equipped an armor!\n'),!
            ) 
        );
        (
            Type = accessories,
            playerEquipment(Weapon,Armor,Accessories),
            (
                Accessories = empty,
                removeInventory(Item),
                retract(playerEquipment(Weapon,Armor,Accessories)),
                asserta(playerEquipment(Weapon,Armor,Item)),
                item(_,Item,_,_,_,EquipmentHP,_),
                player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
                NewMaxHP is MaxHP+EquipmentHP,
                retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                asserta(player(Username,Job,LVL,HP,NewMaxHP,ATT,DEF,EXP,MaxEXP,Gold)),!
            );
            (
                Accessories \= empty,
                write('\nYou have already equipped an accessories!\n'),!
            ) 
        ),!.

useItem(Item,_,_) :-
    \+isItemAvailable(Item) ->
    write('\nYou do not have this item!\n'),!.

returnItem(Item) :-
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Weapon ->
            addInventory(Item),
            item(_,Weapon,_,EquipmentATT,_,_,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewATT is ATT-EquipmentATT,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,NewATT,DEF,EXP,MaxEXP,Gold)),
            retract(playerEquipment(Weapon,Armor,Accessories)),
            asserta(playerEquipment(empty,Armor,Accessories)),!
    );
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Armor ->
            addInventory(Item),
            item(_,Armor,_,_,EquipmentDEF,_,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewDEF is DEF-EquipmentDEF,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,ATT,NewDEF,EXP,MaxEXP,Gold)),
            retract(playerEquipment(Weapon,Armor,Accessories)),
            asserta(playerEquipment(Weapon,empty,Accessories)),!
    );
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Accessories ->
            addInventory(Item),
            item(_,Accessories,_,_,_,EquipmentHP,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewMaxHP is MaxHP-EquipmentHP,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,NewMaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            retract(playerEquipment(Weapon,Armor,Accessories)),
            asserta(playerEquipment(empty,Armor,empty)),!
        
    );
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Accessories ->
            addInventory(Item),
            item(_,Accessories,_,_,_,EquipmentHP,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewMaxHP is MaxHP-EquipmentHP,
            HP > NewMaxHP, 
            NewHP is NewMaxHP,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,NewMaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            retract(playerEquipment(Weapon,Armor,Accessories)),
            asserta(playerEquipment(empty,Armor,empty)),!
    );
    (
        write('\nYou do not have this item!\n'),!
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
    useItem(Item,Job,Type),!.

equipmentAction(Option) :-
    Option =:= 3,
    printEquipment,
    write('\nWhat do you want to return?\n'),
    read(Item),
    returnItem(Item),!.

/*
addEquipmentEffect(Item) :-
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Weapon ->
            item(_,Weapon,_,EquipmentATT,_,_,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewATT is ATT+EquipmentATT,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,NewATT,DEF,EXP,MaxEXP,Gold)),!
    );
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Armor ->
            item(_,Armor,_,_,EquipmentDEF,_,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewDEF is DEF+EquipmentDEF,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,ATT,NewDEF,EXP,MaxEXP,Gold)),!
    );
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Accessories ->
            item(_,Accessories,_,_,_,EquipmentHP,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewMaxHP is MaxHP+EquipmentHP,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,NewMaxHP,ATT,DEF,EXP,MaxEXP,Gold)),!
    ).

removeEquipmentEffect(Item) :-
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Weapon ->
            item(_,Weapon,_,EquipmentATT,_,_,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewATT is ATT-EquipmentATT,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,NewATT,DEF,EXP,MaxEXP,Gold)),!
    );
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Armor ->
            item(_,Armor,_,_,EquipmentDEF,_,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewDEF is DEF-EquipmentDEF,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,ATT,NewDEF,EXP,MaxEXP,Gold)),!
    );
    (
        playerEquipment(Weapon,Armor,Accessories),
        Item == Accessories ->
            item(_,Accessories,_,_,_,EquipmentHP,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewMaxHP is MaxHP-EquipmentHP,
            (
                HP > NewMaxHP,
                NewHP is NewMaxHP,
                retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                asserta(player(Username,Job,LVL,NewHP,NewMaxHP,ATT,DEF,EXP,MaxEXP,Gold)),!
            );
            (
                NewHP = HP,
                retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
                asserta(player(Username,Job,LVL,NewHP,NewMaxHP,ATT,DEF,EXP,MaxEXP,Gold)),!
            )
    ).
*/
    