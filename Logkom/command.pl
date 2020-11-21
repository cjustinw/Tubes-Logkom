
status :-
    init(_),
    player(Username,Job,Level,HP,MaxHP,Att,Def,EXP,MaxEXP,Gold),
    write('\nUsername :'),
    write(Username),
    write('\nJob      :'),
    write(Job),
    write('\nLevel    :'),
    write(Level),
    write('\nHealth   :'),
    write(HP),write('/'), write(MaxHP),
    write('\nAttack   :'),
    write(Att),
    write('\nDefense  :'),
    write(Def),
    write('\nEXP      :'),
    write(EXP),write('/'), write(MaxEXP),
    write('\nGold     :'),
    write(Gold).
    
map :-
    init(_),
    printMap(0,0).

w :-
    playerPosition(X,Y),
    Y1 is Y-1,
    \+isShop(X,Y1),
    \+isQuest(X,Y1),
    \+isDungeon(X,Y1),
    \+isTopBorder(X,Y1),
    \+isLeftBorder(X,Y1),
    \+isBottomBorder(X,Y1),
    \+isRightBorder(X,Y1),
    \+isEnemy(X,Y1),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),!.

w :-
    playerPosition(X,Y),
    Y1 is Y-1,
    isShop(X,Y1),
    write('You re at the Shop'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),!.

w :-
    playerPosition(X,Y),
    Y1 is Y-1,
    isQuest(X,Y1),
    write('You re at the Quest'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),!.

w :-
    playerPosition(X,Y),
    Y1 is Y-1,
    isEnemy(X,Y1),
    write('You face the enemy!'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),
    battleMode(X,Y1),
    randomEnemy,!.

a :-
    playerPosition(X,Y),
    X1 is X-1,
    \+isShop(X1,Y),
    \+isQuest(X1,Y),
    \+isDungeon(X1,Y),
    \+isTopBorder(X1,Y),
    \+isLeftBorder(X1,Y),
    \+isBottomBorder(X1,Y),
    \+isRightBorder(X1,Y),
    \+isEnemy(X1,Y),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),!.

a :-
    playerPosition(X,Y),
    X1 is X-1,
    isShop(X1,Y),
    write('You re at the Shop'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),!.

a :-
    playerPosition(X,Y),
    X1 is X-1,
    isQuest(X1,Y),
    write('You re at the Quest'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),!.

a :-
    playerPosition(X,Y),
    X1 is X-1,
    isEnemy(X1,Y),
    write('You face the enemy!'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),
    battleMode(X1,Y),
    randomEnemy,!.

s :-
    playerPosition(X,Y),
    Y1 is Y+1,
    \+isShop(X,Y1),
    \+isQuest(X,Y1),
    \+isDungeon(X,Y1),
    \+isTopBorder(X,Y1),
    \+isLeftBorder(X,Y1),
    \+isBottomBorder(X,Y1),
    \+isRightBorder(X,Y1),
    \+isEnemy(X,Y1),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),!.

s :-
    playerPosition(X,Y),
    Y1 is Y+1,
    isShop(X,Y1),
    write('You re at the Shop'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),!.

s :-
    playerPosition(X,Y),
    Y1 is Y+1,
    isQuest(X,Y1),
    write('You re at the Quest'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),!.

s :-
    playerPosition(X,Y),
    Y1 is Y+1,
    isEnemy(X,Y1),
    write('You face the enemy!'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X,Y1)),
    battleMode(X,Y1),
    randomEnemy,!.

d :-
    playerPosition(X,Y),
    X1 is X+1,
    \+isShop(X1,Y),
    \+isQuest(X1,Y),
    \+isDungeon(X1,Y),
    \+isTopBorder(X1,Y),
    \+isLeftBorder(X1,Y),
    \+isBottomBorder(X1,Y),
    \+isRightBorder(X1,Y),
    \+isEnemy(X1,Y),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),!.

d :-
    playerPosition(X,Y),
    X1 is X+1,
    isShop(X1,Y),
    write('You re at the Shop'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),!.

d :-
    playerPosition(X,Y),
    X1 is X+1,
    isQuest(X1,Y),
    write('You re at the Quest'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),!.

d :-
    playerPosition(X,Y),
    X1 is X+1,
    isEnemy(X1,Y),
    write('You face the enemy!'),
    retract(playerPosition(_,_)),
    asserta(playerPosition(X1,Y)),
    battleMode(X1,Y),
    randomEnemy,!.

