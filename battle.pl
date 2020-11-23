
actionName :-
    player(_,Job,_,_,_,_,_,_,_,_),
    (
        Job = swordsman ->
            write('\n1. Use Slash'),
            write('\n2. Use Ravage Conqueror'),
            write('\n3. Use Potion'),
            write('\n4. Run\n'),!
    );
    (
        Job = archer ->
            write('\n1. Take Aim'),
            write('\n2. Use Divine Puncture'),
            write('\n3. Use Potion'),
            write('\n4. Run\n'),!
    );
    (
        Job = sorcerer ->
            write('\n1. Use Fireball'),
            write('\n2. Use Elemental Armageddon'),
            write('\n3. Use Potion'),
            write('\n4. Run\n'),!
    ).
    

playerAttack(Option,X,Y) :-
    player(_,Job,_,_,_,_,_,_,_,_),
    (
        Job = swordsman ->
            swordsmanAttack(Option,X,Y),!
    );
    (
        Job = archer ->
            archerAttack(Option,X,Y),!
    );
    (
        Job = sorcerer ->
            sorcererAttack(Option,X,Y),!
    ).

swordsmanAttack(Option,X,Y) :-
    (
        Option =:= 1 ->
        (   
            player(_,_,_,_,_,ATT,_,_,_,_),
            enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X),
            write('\nYou use Slash\n'),
            Damage is ATT*(100/(100+EnemyDEF)),
            NewEnemyHP is round(EnemyHP-Damage),
            retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X)),
            asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X))
        )
    );
    (
        Option =:= 2 ->
        (
            player(_,_,_,_,_,ATT,_,_,_,_),
            enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X),
            write('\nYou use Ravage Conqueror\n'),
            Damage is ATT*(100/(100+EnemyDEF))*3,
            NewEnemyHP is round(EnemyHP-Damage),
            retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X)),
            asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X))
        )
    );
    (
        Option =:= 3 ->
            usePotion
    ).
    

archerAttack(Option,X,Y) :-
    (
        Option =:= 1 ->
            player(_,_,_,_,_,ATT,_,_,_,_),
            enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X),
            write('\nYou Take Aim\n'),
            Damage is ATT*(100/(100+EnemyDEF)),
            NewEnemyHP is round(EnemyHP-Damage),
            retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X)),
            asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X))
    );
    (
        Option =:= 2 ->
            player(_,_,_,_,_,ATT,_,_,_,_),
            enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X),
            write('\nYou use Divine Puncture\n'),
            Damage is ATT*(100/(100+EnemyDEF))*3,
            NewEnemyHP is round(EnemyHP-Damage),
            retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X)),
            asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X))
    );
    (
        Option =:= 3 ->
            usePotion
    ).

sorcererAttack(Option,X,Y) :-
    (
        Option =:= 1 ->
            player(_,_,_,_,_,ATT,_,_,_,_),
            enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X),
            write('\nYou use Fireball\n'),
            Damage is ATT*(100/(100+EnemyDEF)),
            NewEnemyHP is round(EnemyHP-Damage),
            retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X)),
            asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X))
    );
    (
        Option =:= 2 ->
            player(_,_,_,_,_,ATT,_,_,_,_),
            enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X),
            write('\nYou use Elemental Armageddon\n'),
            Damage is ATT*(100/(100+EnemyDEF))*3,
            NewEnemyHP is round(EnemyHP-Damage),
            retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X)),
            asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,Y,X))      
    );
    (
        Option =:= 3 ->
            usePotion
    ).

run :- 
    random(1,11,R),
    (
    R =:= 1 -> 
        write('\nN I G E R U N D A Y O ! S M O K E Y !\n')
    ;
    write('\nYou\'re running away from the enemy\n')
    ).

enemyAttack(X,Y) :-
    write('\nEnemy turn\n'),
    enemy(_,EnemyName,_,_,_,_,_,Y,X),
    (
        EnemyName = slime ->
            random(1,3,Option),
            slimeAttack(Option,X,Y)
    );
    (
        EnemyName = goblin ->
            random(1,3,Option),
            goblinAttack(Option,X,Y)
    );
    (
        EnemyName = wolf ->
            random(1,3,Option),
            wolfAttack(Option,X,Y)
    ).

slimeAttack(Option,X,Y) :-
    (
        Option =:= 1 ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            enemy(_,EnemyName,_,_,_,EnemyATT,_,Y,X),
            % write(EnemyName),
            write('Slime uses normal attack'),
            Damage is EnemyATT*(100/(100+DEF)),
            NewHP is round(HP-Damage),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold))
    );
    (
        Option =:= 2 ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            enemy(_,EnemyName,_,_,_,EnemyATT,_,Y,X),
            % write(EnemyName),
            write('Slime uses special attack'),
            Damage is EnemyATT*(100/(100+DEF)),
            NewHP is round(HP-Damage),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold))
    ).
    

goblinAttack(Option,X,Y) :-
    (
        Option =:= 1 ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            enemy(_,EnemyName,_,_,_,EnemyATT,_,Y,X),
            % write(EnemyName),
            write('Group of Goblins use normal attack'),
            Damage is EnemyATT*(100/(100+DEF)),
            NewHP is round(HP-Damage),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold))
    );
    (
        Option =:= 2 ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            enemy(_,EnemyName,_,_,_,EnemyATT,_,Y,X),
            % write(EnemyName),
            write('Group of Goblins use special attack'),
            Damage is EnemyATT*(100/(100+DEF)),
            NewHP is round(HP-Damage),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold))
    ).

wolfAttack(Option,X,Y) :-
    (
        Option =:= 1 ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            enemy(_,EnemyName,_,_,_,EnemyATT,_,Y,X),
            % write(EnemyName),
            write('Wild Wolf uses normal attack'),
            Damage is EnemyATT*(100/(100+DEF)),
            NewHP is round(HP-Damage),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold))
    );
    (
        Option =:= 2 ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            enemy(_,EnemyName,_,_,_,EnemyATT,_,Y,X),
            write(EnemyName),
            write('Wild Wolf uses special attack'),
            Damage is EnemyATT*(100/(100+DEF)),
            NewHP is round(HP-Damage),
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold))
    ).

isPlayerDefeated :-
    player(_,_,_,HP,_,_,_,_,_,_),
    HP =< 0.

isEnemyDefeated(X,Y) :-
    enemy(_,_,_,EnemyHP,_,_,_,Y,X),
    EnemyHP =< 0.

expIncrease(X,Y) :-
    (
        enemy(_,EnemyType,EnemyLVL,_,_,_,_,Y,X),EnemyType = slime ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            IncreaseEXP is EnemyLVL*30,
            NewEXP is EXP+IncreaseEXP,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,Gold))
    );
    (
        enemy(_,EnemyType,EnemyLVL,_,_,_,_,Y,X),EnemyType = goblin ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            IncreaseEXP is EnemyLVL*30,
            NewEXP is EXP+IncreaseEXP,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,Gold))
    );
    (
        enemy(_,EnemyType,EnemyLVL,_,_,_,_,Y,X),EnemyType = wolf ->
            player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
            IncreaseEXP is EnemyLVL*30,
            NewEXP is EXP+IncreaseEXP,
            retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
            asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,Gold))
    ).
    

playerStatus :-
    player(Name,_,Level,HP,MaxHP,ATT,DEF,_,_,_),
    write('\n\nYour\'s status:\n\n'),
    write(Name),
    write('\nLevel    :'),
    write(Level),
    write('\nHealth   :'),
    write(HP),write('/'), write(MaxHP),
    write('\nAttack   :'),
    write(ATT),
    write('\nDefense  :'),
    write(DEF).
    
enemyStatus(X,Y) :-
    enemy(_,Name,Level,HP,MaxHP,_,_,Y,X),
    write('\n\nEnemy\'s status:\n\n'),
    (
        Name = slime ->
            write('Slime')
        ;
        Name = goblin ->
            write('Group of Goblins')
        ;
        Name = wolf ->
            write('Wild Wolf')
    ),
    write('\nLevel    :'),
    write(Level),
    write('\nHealth   :'),
    write(HP),write('/'), write(MaxHP).

battleMode(_,_) :-
    isPlayerDefeated,
    write('\n\nYou\'re defeated!\n'),
    write('\nGame Over!\n'),
    quit,!.

battleMode(X,Y) :-
    isEnemyDefeated(X,Y),
    write('\nEnemy is defeated!\n'),
    expIncrease(X,Y),
    questEnemyKilled(X,Y),
    levelUp,!.

battleMode(X,Y) :-
    \+isEnemyDefeated(X,Y),
    playerStatus,
    enemyStatus(X,Y),
    write('\n\nYour action: '),
    actionName,
    read(Option),
    (
        (
            Option =:= 4 -> run
        );
        (
            playerAttack(Option,X,Y),
            (
                (
                    isEnemyDefeated(X,Y)
                );
                (
                    enemyAttack(X,Y)
                )
            ),
            battleMode(X,Y)
        )
    ).
