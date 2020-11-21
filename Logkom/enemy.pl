
:- dynamic(enemy/9).

createEnemy(ID,PosX,PosY) :-
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
    asserta(enemy(ID,slime,Level,HP,MaxHP,ATT,DEF,PosX,PosY)),!.

createEnemy(ID,PosX,PosY) :-
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
    asserta(enemy(ID,goblin,Level,HP,MaxHP,ATT,DEF,PosX,PosY)),!.

createEnemy(ID,PosX,PosY) :-
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
    asserta(enemy(ID,wolf,Level,HP,MaxHP,ATT,DEF,PosX,PosY)),!.

generateEnemy(Condition) :-
    random(1,4,ID),
    random(1,30,PosX),
    random(1,15,PosY),
    (
        (
            isPlayer(PosX,PosY) -> Condition = fail
        );
        (
            isShop(PosX,PosY) ->  Condition = fail
        );
        (
            isQuest(PosX,PosY) ->  Condition = fail
        );
        (
            isDungeon(PosX,PosY) -> Condition = fail
        );
        (
            isEnemy(PosX,PosY) -> Condition = fail
        );
        (
            Condition = success,
            createEnemy(ID,PosX,PosY)
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


