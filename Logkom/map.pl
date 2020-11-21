
:- dynamic(size/2).
:- dynamic(playerPosition/2).
:- dynamic(shopPosition/2).
:- dynamic(questPosition/2).
:- dynamic(dungeonPosition/2).

createMapSize :- 
    asserta(size(30,15)).

createPlayer :-
    asserta(playerPosition(1,1)).

createShop :-
    asserta(shopPosition(2,1)).

createQuest :-
    asserta(questPosition(5,2)).

createDungeon :-
    asserta(dungeonPosition(29,14)).

createMap :-
    createMapSize,
    createPlayer,
    createShop,
    createQuest,
    createDungeon.

isPlayer(X,Y) :-
    playerPosition(A,B),
    X =:= A,
    Y =:= B.

isShop(X,Y) :-
    shopPosition(A,B),
    X =:= A,
    Y =:= B.

isQuest(X,Y) :-
    questPosition(A,B),
    X =:= A,
    Y =:= B.

isDungeon(X,Y) :-
    dungeonPosition(A,B),
    X =:= A,
    Y =:= B.

isEnemy(X,Y) :-
    enemy(_,_,_,_,_,_,_,A,B),
    X =:= A,
    Y =:= B.

isTopBorder(_,Y) :-
    Y =:= 0.

isLeftBorder(X,_) :-
    X =:= 0.

isBottomBorder(_,Y) :-
    size(_,H),
    Y =:= H.

isRightBorder(X,_) :-
    size(W,_),
    X =:= W.

printMap(X,Y) :-
    isRightBorder(X,Y),
    isBottomBorder(X,Y),
    write('#'),!.

printMap(X,Y) :-
    isTopBorder(X,Y),
    \+isRightBorder(X,Y),
    write('#'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    isBottomBorder(X,Y),
    \+isRightBorder(X,Y),
    write('#'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    isLeftBorder(X,Y),
    write('#'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    isRightBorder(X,Y),
    write('#\n'),
    X1 is 0,
    Y1 is Y+1,
    printMap(X1,Y1),!.

printMap(X,Y) :-
    isShop(X,Y),
    write('S'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    isQuest(X,Y),
    write('Q'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    isDungeon(X,Y),
    write('D'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    isPlayer(X,Y),
    write('P'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    isEnemy(X,Y),
    write('E'),
    X1 is X+1,
    printMap(X1,Y),!.

printMap(X,Y) :-
    \+isTopBorder(X,Y),
    \+isBottomBorder(X,Y),
    \+isLeftBorder(X,Y),
    \+isRightBorder(X,Y),
    \+isPlayer(X,Y),
    \+isShop(X,Y),
    \+isQuest(X,Y),
    \+isDungeon(X,Y),
    write('-'),
    X1 is X+1,
    printMap(X1,Y),!.


