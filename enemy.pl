
:- dynamic(enemy/9).

createEnemy(ID,PosY,PosX) :-
    player(_,_,PlayerLevel,_,_,_,_,_,_,_),
    ID =:= 1,
    LVL is PlayerLevel+2,
    random(1,LVL,Level),
    random(300,500,Health),
    random(50,60,Attack),
    random(30,40,Defense),
    HP is Health*Level,
    MaxHP = HP,
    ATT is Attack*Level,
    DEF is Defense*Level,
    asserta(enemy(ID,slime,Level,HP,MaxHP,ATT,DEF,PosY,PosX)),!.

createEnemy(ID,PosY,PosX) :-
    player(_,_,PlayerLevel,_,_,_,_,_,_,_),
    ID =:= 2,
    LVL is PlayerLevel+2,
    random(1,LVL,Level),
    random(400,600,Health),
    random(60,70,Attack),
    random(40,50,Defense),
    HP is Health*Level,
    MaxHP = HP,
    ATT is Attack*Level,
    DEF is Defense*Level,
    asserta(enemy(ID,goblin,Level,HP,MaxHP,ATT,DEF,PosY,PosX)),!.

createEnemy(ID,PosY,PosX) :-
    player(_,_,PlayerLevel,_,_,_,_,_,_,_),
    ID =:= 3,
    LVL is PlayerLevel+2,
    random(1,LVL,Level),
    random(500,700,Health),
    random(60,70,Attack),
    random(40,50,Defense),
    HP is Health*Level,
    MaxHP = HP,
    ATT is Attack*Level,
    DEF is Defense*Level,
    asserta(enemy(ID,wolf,Level,HP,MaxHP,ATT,DEF,PosY,PosX)),!.

generateEnemy(Condition) :-
    random(1,34,PosX),
    random(1,34,PosY),
    (
        (
            player_X(TempX), player_Y(TempY), PosY =:= TempY, PosX =:= TempX ->
                Condition = fail
        );
        (
            shop(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            quest(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            monstadt(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            liyue_harbor(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            qingyun_peak(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            boss_dungeon(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            enemy(_,_,_,_,_,_,_,Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            water(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            Condition = success,
            (
                slime_Z(Y,X), PosY =:= Y, PosX =:= X ->
                    createEnemy(1,PosY,PosX)
                ;
                goblin_Z(Y,X), PosY =:= Y, PosX =:= X ->
                    createEnemy(2,PosY,PosX)
                ;
                wolf_Z(Y,X), PosY =:= Y, PosX =:= X ->
                    createEnemy(3,PosY,PosX)
                ;
                random(1,4,ID),
                createEnemy(ID,PosY,PosX)
            )
            
        )
    ).

generateAllEnemy(0).

generateAllEnemy(N) :-
    generateEnemy(Condition),
    (
        (
            Condition = success ->
                N1 is N-1,
                generateAllEnemy(N1)
        );
        (
            generateAllEnemy(N)
        )
    ).

randomEnemy :-
    retractall(enemy(_,_,_,_,_,_,_,_,_)),
    generateAllEnemy(50).


