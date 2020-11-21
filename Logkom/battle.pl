
attack(Option,X,Y) :-
    Option =:= 1,
    normalAttack(X,Y),!.

attack(Option,X,Y) :-
    Option =:= 2,
    specialAttack(X,Y),!.

run :- 
    write('\nyou\'re running away from the enemy\n').

normalAttack(X,Y) :-
    player(_,_,_,_,_,ATT,_,_,_,_),
    enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,X,Y),
    Damage is ATT*(100/(100+EnemyDEF)),
    NewEnemyHP is round(EnemyHP-Damage),
    retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,X,Y)),
    asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,X,Y)),
    write('you use normal attack\n'),!.

specialAttack(X,Y) :-
    player(_,_,_,_,_,ATT,_,_,_,_),
    enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,X,Y),
    Damage is ATT*(100/(100+EnemyDEF))*3,
    NewEnemyHP is round(EnemyHP-Damage),
    retract(enemy(EnemyID,EnemyType,EnemyLVL,EnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,X,Y)),
    asserta(enemy(EnemyID,EnemyType,EnemyLVL,NewEnemyHP,EnemyMaxHP,EnemyATT,EnemyDEF,X,Y)),
    write('you use special attack\n'),!.

enemyAttack(X,Y) :-
    write('\nEnemy turn\n'),
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    enemy(_,EnemyName,_,_,_,EnemyATT,_,X,Y),
    Damage is EnemyATT*(100/(100+DEF)),
    NewHP is round(HP-Damage),
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,LVL,NewHP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    write(EnemyName),
    write(' use normal attack\n'),!.

isPlayerDefeated :-
    player(_,_,_,HP,_,_,_,_,_,_),
    HP =< 0.

isEnemyDefeated(X,Y) :-
    enemy(_,_,_,EnemyHP,_,_,_,X,Y),
    EnemyHP =< 0.

expIncrease(X,Y) :-
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    enemy(_,EnemyType,EnemyLVL,_,_,_,_,X,Y),
    EnemyType = slime,
    IncreaseEXP is EnemyLVL*30,
    NewEXP is EXP+IncreaseEXP,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,Gold)),!.

expIncrease(X,Y) :-
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    enemy(_,EnemyType,EnemyLVL,_,_,_,_,X,Y),
    EnemyType = goblin,
    IncreaseEXP is EnemyLVL*30,
    NewEXP is EXP+IncreaseEXP,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,Gold)),!.

expIncrease(X,Y) :-
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    enemy(_,EnemyType,EnemyLVL,_,_,_,_,X,Y),
    EnemyType = wolf,
    IncreaseEXP is EnemyLVL*30,
    NewEXP is EXP+IncreaseEXP,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,Gold)),!.

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
    enemy(_,Name,Level,HP,MaxHP,_,_,X,Y),
    write('\n\nEnemy\'s status:\n\n'),
    write(Name),
    write('\nLevel    :'),
    write(Level),
    write('\nHealth   :'),
    write(HP),write('/'), write(MaxHP).

battleMode(_,_) :-
    isPlayerDefeated,
    write('\nYou\'re defeated!\n'),
    write('\nGame Over!\n'),
    quit,!.

battleMode(X,Y) :-
    isEnemyDefeated(X,Y),
    write('\nEnemy is defeated!\n'),
    expIncrease(X,Y),
    levelUp,!.

battleMode(X,Y) :-
    \+isEnemyDefeated(X,Y),
    playerStatus,
    enemyStatus(X,Y),
    write('\n\nYour action: '),
    write('\n1. Use normal attack'),
    write('\n2. Use special attack'),
    write('\n3. Run\n'),
    read(Option),
    (
        (
            Option = 3 -> run
        );
        (
            attack(Option,X,Y),
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
