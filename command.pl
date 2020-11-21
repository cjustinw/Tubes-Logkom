
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
    printX(0,0),!.

% Perintah Navigasi:
% Gerak ke atas
w :-
    player_X(TempX),
    player_Y(TempY),
    Next is (TempY - 1),
	(
	Next =:= 0 -> write('Kena Batas')
	;
	shop(Y,X), Next =:= Y, TempX =:= X ->
		write('Ada di Shop!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	boss_dungeon(Y,X), Next =:= Y, TempX =:= X ->
		write('Ada di Dungeon Boss!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	water(Y,X), Next =:= Y, TempX =:= X ->
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        stamina(N),
        N1 is N - 1,
        (
        N1 =:= 0 ->
            write('You drowned! Better see your surroundings next time!'),
            quit
        ;
        retract(stamina(N)),
        asserta(stamina(N1))
        )
	;
	quest(Y,X), Next =:= Y, TempX =:= X ->
		write('Ada di Quest Board!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	enemy(_,_,_,_,_,_,_,Y,X), Next =:= Y, TempX =:= X ->
		write('Ada Musuh!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5)),
        battleMode(X,Next),
        randomEnemy,!
	;
	mount(Y,X), Next =:= Y, TempX =:= X ->
		write('Gunung ini tidak mungkin didaki!')
	;
	retract(player_Y(_)),
	asserta(player_Y(Next)),!,
	write('['),write(Next),write(','),write(TempX),write(']'),
    retract(stamina(_)),
    asserta(stamina(5))
	).

% Gerak ke kiri
a :-
    player_X(TempX),
    player_Y(TempY),
    Next is (TempX - 1),
	(
	Next =:= 0 -> write('Kena Batas')
	;
	shop(Y,X), TempY =:= Y, Next =:= X ->
		write('Ada di Shop!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	boss_dungeon(Y,X), TempY =:= Y, Next =:= X ->
		write('Ada di Dungeon Boss!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	water(Y,X), TempY =:= Y, Next =:= X ->
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        stamina(N),
        N1 is N - 1,
        (
        N1 =:= 0 ->
            write('You drowned! Better see your surroundings next time!'),
            quit
        ;
        retract(stamina(N)),
        asserta(stamina(N1))
        )
	;
    quest(Y,X), TempY =:= Y, Next =:= X ->
		write('Ada di Quest Board!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
    ;
    enemy(_,_,_,_,_,_,_,Y,X), TempY =:= Y, Next =:= X ->
		write('Ada Musuh!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5)),
        battleMode(Next,Y),
        randomEnemy,!
    ;
	mount(Y,X), TempY =:= Y, Next =:= X ->
		write('Gunung ini tidak mungkin didaki!')
	;
	retract(player_X(_)),
	asserta(player_X(Next)),!,
	write('['),write(TempY),write(','),write(Next),write(']'),
    retract(stamina(_)),
    asserta(stamina(5))
	).

% Gerak ke bawah
s :-
    player_X(TempX),
    player_Y(TempY),
    Next is (TempY + 1),
	(
	Next =:= 34 -> write('Kena Batas')
	;
	shop(Y,X), TempX =:= X, Next =:= Y ->
		write('Ada di Shop!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	boss_dungeon(Y,X), TempX =:= X, Next =:= Y ->
		write('Ada di Dungeon Boss!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	water(Y,X), TempX =:= X, Next =:= Y ->
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        stamina(N),
        N1 is N - 1,
        (
        N1 =:= 0 ->
            write('You drowned! Better see your surroundings next time!'),
            quit
        ;
        retract(stamina(N)),
        asserta(stamina(N1))
        )
	;
    quest(Y,X), TempX =:= X, Next =:= Y ->
		write('Ada di Quest Board!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
    ;
    enemy(_,_,_,_,_,_,_,Y,X), TempX =:= X, Next =:= Y ->
		write('Ada Musuh!'),nl,
		retract(player_Y(_)),
		asserta(player_Y(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']'),
        retract(stamina(_)),
        asserta(stamina(5)),
        battleMode(X,Next),
        randomEnemy,!
    ;
	mount(Y,X), TempX =:= X, Next =:= Y ->
		write('Gunung ini tidak mungkin didaki!')
	;
	retract(player_Y(_)),
	asserta(player_Y(Next)),!,
	write('['),write(Next),write(','),write(TempX),write(']'),
    retract(stamina(_)),
    asserta(stamina(5))
	).

% Gerak ke kanan
d :-
    player_X(TempX),
    player_Y(TempY),
    Next is (TempX + 1),
	(
	Next =:= 34 -> write('Kena Batas')
	;
	shop(Y,X), TempY =:= Y, Next =:= X ->
		write('Ada di Shop!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	boss_dungeon(Y,X), TempY =:= Y, Next =:= X ->
		write('Ada di Dungeon Boss!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
	;
	water(Y,X), TempY =:= Y, Next =:= X ->
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        stamina(N),
        N1 is N - 1,
        (
        N1 =:= 0 ->
            write('You drowned! Better see your surroundings next time!'),
            quit
        ;
        retract(stamina(N)),
        asserta(stamina(N1))
        )
	;
    quest(Y,X), TempY =:= Y, Next =:= X ->
		write('Ada di Quest Board!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5))
    ;
    enemy(_,_,_,_,_,_,_,Y,X), TempY =:= Y, Next =:= X ->
		write('Ada Musuh!'),nl,
		retract(player_X(_)),
		asserta(player_X(Next)),!,
		write('['),write(TempY),write(','),write(Next),write(']'),
        retract(stamina(_)),
        asserta(stamina(5)),
        battleMode(Next,Y),
        randomEnemy,!
    ;
	mount(Y,X), TempY =:= Y, Next =:= X ->
		write('Gunung ini tidak mungkin didaki!')
	;
	retract(player_X(_)),
	asserta(player_X(Next)),!,
	write('['),write(TempY),write(','),write(Next),write(']'),
    retract(stamina(_)),
    asserta(stamina(5))
	).