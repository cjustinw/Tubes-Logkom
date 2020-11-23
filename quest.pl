
:- dynamic(killcount/3).
:- dynamic(killreq/3).
:- dynamic(questing/1).


quest :-
    \+questing(_),
    write('You are not on a quest! "questlist" to choose quest!'),!.

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
    questing(QuestID),
    killcount(Cslime,Cgoblin,Cwolf),
    killreq(Rslime,Rgoblin,Rwolf),
    Rslime =:= Cslime,
    Rgoblin =:= Cgoblin,
    Rwolf =:= Cwolf,
    questComplete,
    retract(questing(QuestID)),
    retract(killcount(Cslime,Cgoblin,Cwolf)),
    retract(killreq(Rslime,Rgoblin,Rwolf)),!.


questlist :-
    \+questing(_),
    write('\nChoose quest\n'),
    write('1. kill 3 slime\n'),
    write('2. kill 4 goblin\n'),
    write('3. kill 2 wolf\n'),
    write('4. kill 2 slime 2 goblin 1 wolf\n'),
    read(QuestID),
    asserta(questing(QuestID)),
    getQuest(QuestID),!.

questlist :-
    questing(_),
    write('\nYou are on a quest! "quest" to see progress\n'),!.

getQuest(QuestID) :-
    QuestID =:= 1,
    write('\nDialogue quest 1 kill 3 slime \n'),
    asserta(killcount(0,0,0)),
    asserta(killreq(3,0,0)),!.


getQuest(QuestID) :-
    QuestID =:= 2,
    write('\nDialogue quest 2 kill 4 goblin \n'),
    asserta(killcount(0,0,0)),
    asserta(killreq(0,4,0)),!.
    
getQuest(QuestID) :-
    QuestID =:= 3,
    write('\nDialogue quest 3 kill 2 wolf \n'),
    asserta(killcount(0,0,0)),
    asserta(killreq(0,0,2)),!.

getQuest(QuestID) :-
    QuestID =:= 4,
    write('\nDialogue quest 4 kill 2 slime 2 goblin 1 wolf\n'),
    asserta(killcount(0,0,0)),
    asserta(killreq(2,2,1)),!.

questRemain :-
    questing(_),
    write('You are on a quest!'),
    killcount(Cslime,Cgoblin,Cwolf),
    killreq(Rslime,Rgoblin,Rwolf),
    write('\nTo complete quest kill : '),
    SlimeRemain is Rslime-Cslime,
    write(SlimeRemain),
    write(' Slime(s) '),
    GoblinRemain is Rgoblin-Cgoblin,
    write(GoblinRemain),
    write(' Goblin(s) '),
    WolfRemain is Rwolf-Cwolf,
    write(WolfRemain),
    write(' Wolf(s)\n'),!.

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
    write('\nQuest complete ! '),
    player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold),
    killreq(Rslime,Rgoblin,Rwolf),
    IncreaseEXP is (Rslime+Rgoblin+Rwolf)*50,
    IncreaseGold is (Rslime+Rgoblin+Rwolf)*30,
    NewEXP is EXP+IncreaseEXP,
    NewGold is Gold+IncreaseGold,
    write('\nExp Reward : '),
    write(IncreaseEXP),
    write('\nGold Reward : \n'),
    write(IncreaseGold),
    retract(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,EXP,MaxEXP,Gold)),
    asserta(player(Username,Job,LVL,HP,MaxHP,ATT,DEF,NewEXP,MaxEXP,NewGold)).

