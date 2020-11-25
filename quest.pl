
:- dynamic(killcount/3).
:- dynamic(killreq/3).
:- dynamic(questing/1).

quest :-
    \+questing(_),
    write('\nYou are not on a quest, Traveler! Go to Quest Board (*Q) to get your quest! \n'),!.

quest :-
    questing(_),
    killcount(Cslime,_,_),
    killreq(Rslime,_,_),
    Cslime < Rslime,
    questRemain,!.

quest :-
    questing(_),
    killcount(_,Cgoblin,_),
    killreq(_,Rgoblin,_),
    Cgoblin < Rgoblin,
    questRemain,!.

quest :-
    questing(_),
    killcount(_,_,Cwolf),
    killreq(_,_,Rwolf),
    Cwolf < Rwolf,
    questRemain,!.

quest :-
    questing(_),
    questRemain,!.


questlist :-
    \+questing(_),
    write('\nPick a Quest:\n'),
    write('1. Kill 3 Slime(s)\n'),
    write('2. Kill 4 Group of Goblins\n'),
    write('3. Kill 2 Wild Wolf(es)\n'),
    write('4. Kill 2 Slime(s), 2 Group of Goblins, 1 Wild Wolf(es)\n'),
    write('5. Cancel\n\n'),    
    read(QuestID),
    asserta(questing(QuestID)),
    getQuest(QuestID),!.

questlist :-
    questing(_),
    killcount(Cslime,Cgoblin,Cwolf),
    killreq(Rslime,Rgoblin,Rwolf),
    Rslime =:= Cslime,
    Rgoblin =:= Cgoblin,
    Rwolf =:= Cwolf,
    questComplete,
    retract(questing(_)),
    retract(killcount(Cslime,Cgoblin,Cwolf)),
    retract(killreq(Rslime,Rgoblin,Rwolf)),
    questlist,!.


questlist :-
    questing(_),
    write('\nYou are on a quest, Traveler! Type "quest." to see your progress or type "questquit." to abandon your quest\n'),!.


questquit :-
    questing(_),
    retract(questing(_)),!.

getQuest(QuestID) :-
    QuestID =:= 1,
    asserta(killcount(0,0,0)),
    write('\n[Quest] --==++ Kill 3 Slime(s) ++==--\n'),
    asserta(killreq(3,0,0)),!.


getQuest(QuestID) :-
    QuestID =:= 2,
    write('\n[Quest] --==++ Clear 4 Camp of Goblins ++==--\n'),
    asserta(killcount(0,0,0)),
    asserta(killreq(0,4,0)),!.
    
getQuest(QuestID) :-
    QuestID =:= 3,
    write('\n[Quest] --==++ Eliminate 2 Wild Wolf(es) ++==--\n'),
    asserta(killcount(0,0,0)),
    asserta(killreq(0,0,2)),!.

getQuest(QuestID) :-
    QuestID =:= 4,
    write('\n[Quest] --==++ Annihilate 2 Slime(s), 2 Camp of Goblins, and 1 Wild Wolf(es) ++==--\n'),
    asserta(killcount(0,0,0)),
    asserta(killreq(2,2,1)),!.

getQuest(QuestID) :-
    QuestID =:= 5,
    questing(QuestID),  
    retract(questing(QuestID)),
    cancel,!.

questRemain :-
    questing(_),
    killcount(Cslime,Cgoblin,Cwolf),
    killreq(Rslime,Rgoblin,Rwolf),
    Rslime =:= Cslime,
    Rgoblin =:= Cgoblin,
    Rwolf =:= Cwolf,
    write('\nQuest complete! Go to Quest Board (*Q) to get your reward! \n'),!.


questRemain :-
    questing(_),
    write('\nYou are on a quest!\n'),
    killcount(Cslime,Cgoblin,Cwolf),
    killreq(Rslime,Rgoblin,Rwolf),
    write('\nEnemy(s) remaining : '),
    SlimeRemain is Rslime-Cslime,
    write(SlimeRemain),
    write(' Slime(s), '),
    GoblinRemain is Rgoblin-Cgoblin,
    write(GoblinRemain),
    write(' Group of Goblin(s), '),
    WolfRemain is Rwolf-Cwolf,
    write(WolfRemain),
    write(' Wild Wolf(es)\n'),!.

questEnemyKilled(_,_):-
    \+questing(_).

questEnemyKilled(X,Y):-
    (
            questing(_),enemy(_,EnemyType,_,_,_,_,_,Y,X),EnemyType = slime,killreq(Rslime,_,_),Rslime =:= 0
    );
    (
            questing(_),enemy(_,EnemyType,_,_,_,_,_,Y,X),EnemyType = slime,killreq(Rslime,_,_),Rslime =\= 0 ->               
                killcount(Cslime,Cgoblin,Cwolf),
                killreq(Rslime,_,_),
                Cslime < Rslime,
                NewCslime is Cslime+1,
                retract(killcount(Cslime,Cgoblin,Cwolf)),
                asserta(killcount(NewCslime,Cgoblin,Cwolf)),
                quest
    );
    (
            questing(_),enemy(_,EnemyType,_,_,_,_,_,Y,X),EnemyType = goblin,killreq(_,Rgoblin,_),Rgoblin =:= 0
    );
    (
            questing(_),enemy(_,EnemyType,_,_,_,_,_,Y,X),EnemyType = goblin,killreq(_,Rgoblin,_),Rgoblin =\= 0 ->
                killcount(Cslime,Cgoblin,Cwolf),
                killreq(_,Rgoblin,_),
                Cgoblin < Rgoblin,
                NewCgoblin is Cgoblin+1,
                retract(killcount(Cslime,Cgoblin,Cwolf)),
                asserta(killcount(Cslime,NewCgoblin,Cwolf)),
                quest
    );
    (
            questing(_),enemy(_,EnemyType,_,_,_,_,_,Y,X),EnemyType = wolf,killreq(_,_,Rwolf),Rwolf =:= 0 
    );
    (
            questing(_),enemy(_,EnemyType,_,_,_,_,_,Y,X),EnemyType = wolf,killreq(_,_,Rwolf),Rwolf =\= 0 ->
                killcount(Cslime,Cgoblin,Cwolf),
                killreq(_,_,Rwolf),
                Cwolf < Rwolf,
                NewCwolf is Cwolf+1,
                retract(killcount(Cslime,Cgoblin,Cwolf)),
                asserta(killcount(Cslime,Cgoblin,NewCwolf)),
                quest
    ).



questComplete :-
    write('\nQuest completed! '),
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    killreq(Rslime,Rgoblin,Rwolf),
    IncreaseEXP is (Rslime+Rgoblin+Rwolf)*50,
    IncreaseGold is (Rslime+Rgoblin+Rwolf)*400,
    NewEXP is EXP+IncreaseEXP,
    NewGold is Gold+IncreaseGold,
    write('\nExp Reward : '),
    write(IncreaseEXP),
    write('\nGold Reward : '),
    write(IncreaseGold),nl,
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,NewGold)).

