
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
    playerEquipment(Weapon,Armor,Accessories),
    item(_,Weapon,_,EquipmentATT,_,_,_),
    item(_,Armor,_,_,EquipmentDEF,_,_),
    item(_,Accessories,_,_,_,EquipmentHP,_),
    Job = swordsman,
    RequiredEXP is LVL*100,
    EXP >= RequiredEXP,
    NewLVL is (EXP div RequiredEXP)+LVL,
    NewMaxHP is (NewLVL*1000)+EquipmentHP,
    NewATT is (NewLVL*80)+EquipmentATT,
    NewDEF is (NewLVL*70)+EquipmentDEF,
    NewMaxEXP is NewLVL*100,
    NewEXP is EXP-MaxEXP,
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
    playerEquipment(Weapon,Armor,Accessories),
    item(_,Weapon,_,EquipmentATT,_,_,_),
    item(_,Armor,_,_,EquipmentDEF,_,_),
    item(_,Accessories,_,_,_,EquipmentHP,_),
    Job = archer,
    RequiredEXP is LVL*90,
    EXP >= RequiredEXP,
    NewLVL is (EXP div RequiredEXP)+LVL,
    NewMaxHP is (NewLVL*800)+EquipmentHP,
    NewATT is (NewLVL*85)+EquipmentATT,
    NewDEF is (NewLVL*65)+EquipmentDEF,
    NewMaxEXP is NewLVL*90,
    NewEXP is EXP-MaxEXP,
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
    playerEquipment(Weapon,Armor,Accessories),
    item(_,Weapon,_,EquipmentATT,_,_,_),
    item(_,Armor,_,_,EquipmentDEF,_,_),
    item(_,Accessories,_,_,_,EquipmentHP,_),
    Job = sorcerer,
    RequiredEXP is LVL*90,
    EXP >= RequiredEXP,
    NewLVL is (EXP div RequiredEXP)+LVL,
    NewMaxHP is (NewLVL*900)+EquipmentHP,
    NewATT is (NewLVL*75)+EquipmentATT,
    NewDEF is (NewLVL*75)+EquipmentDEF,
    NewMaxEXP is NewLVL*90,
    NewEXP is EXP-MaxEXP,
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

initEquipment(Job) :-
    (
        Job = swordsman ->
            asserta(playerEquipment(sword,empty,empty)),!
    ;
        Job = archer ->
            asserta(playerEquipment(bow,empty,empty)),!
    ;
        Job = sorcerer ->
            asserta(playerEquipment(wand,empty,empty)),!
    ),
    playerEquipment(Item,_,_),
    item(_,Item,_,EquipmentATT,_,_,_),
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    NewATT is ATT+EquipmentATT,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,LVL,HP,MaxHP,NewATT,DEF,EXP,MaxEXP,Gold)).

printEquipment :-
    playerEquipment(Weapon,Armor,Accessories),
    write('\nWeapon     : '),write(Weapon),
    write('\nArmor      : '),write(Armor),
    write('\nAccessories: '),write(Accessories),
    write('\n').

equipment :-
    write('\n1. Show your equipment'),
    write('\n2. Use item'),
    write('\n3. Return item to inventory\n'),
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
                ;
                
                    Weapon \= empty,
                    write('\nYou have already used a sword!\n'),!
                ) 
            ;
            
                Type = sword,Job \= swordsman,
                write('\nYou cannot use this item\n'),!
            )
        ;
        
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
                ;
                
                    Weapon \= empty,
                    write('\nYou have already used a bow!\n'),!
                ) 
            ;
            
                Type = bow,Job \= archer,
                write('\nYou cannot use this item\n'),!
            )
        ;
        
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
                ;
                
                    Weapon \= empty,
                    write('\nYou have already used a wand!\n'),!
                ) 
            ;
            
                Type = wand,Job \= sorcerer,
                write('\nYou cannot use this item\n'),!
            )
        ;
        
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
            ;
            
                Armor \= empty,
                write('\nYou have already used armor!\n'),!
            ) 
        ;
        
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
            ;
            
                Accessories \= empty,
                write('\nYou have already used accessories!\n'),!
            ) 
        ;
            Type = healing,
            Item = potion,
            usePotion,!
        ),!.

useItem(Item,_,_) :-
    \+isItemAvailable(Item) ->
    write('\nYou don\'t have this item\n'),!.

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
    ;
    
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
    ;
    
        playerEquipment(Weapon,Armor,Accessories),
        Item == Accessories ->
            addInventory(Item),
            item(_,Accessories,_,_,_,EquipmentHP,_),
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            NewMaxHP is MaxHP-EquipmentHP,
            (
                HP > NewMaxHP, 
                NewHP = NewMaxHP
            ;
                NewHP = HP
            ),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,NewMaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            retract(playerEquipment(Weapon,Armor,Accessories)),
            asserta(playerEquipment(Weapon,Armor,empty)),!
    ;
        write('\nYou don\'t have this item\n'),!
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