:- dynamic(positionX/1).
:- dynamic(positionY/1).
:- dynamic(shop/2).
:- dynamic(boss_dungeon/2).

initial :- 
	asserta(positionX(1)),
	asserta(positionY(1)),
	asserta(shop(11,11)),               % --> Bisa diganti*
	asserta(boss_dungeon(15,15)).       % --> Bisa diganti*

% * : Tidak menggunakan random, karena hasil random selalu sama untuk langkah ke-N pada console
% Perintah Navigasi:
% Gerak ke atas
w :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp - 1),
	(
	Next =:= 0 -> write('Kena Batas')
	;
	shop(X1,Y1), TempX =:= X1, Next =:= Y1 ->
		write('Shop boi'),
		retract(positionY(_)),
		asserta(positionY(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']')
	;
	boss_dungeon(X2,Y2), TempX =:= X2, Next =:= Y2 ->
		write('Boss boi'),
		retract(positionY(_)),
		asserta(positionY(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']')
	;
	retract(positionY(_)),
	asserta(positionY(Next)),!,
	write('['),write(Next),write(','),write(TempX),write(']')
	).

% Gerak ke kiri
a :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX - 1),
	(
	Next =:= 0 -> write('Kena Batas')
	;
	shop(X1,Y1), Temp =:= Y1, Next =:= X1 ->
		write('Shop boi'),
		retract(positionX(_)),
		asserta(positionX(Next)),!,
		write('['),write(Temp),write(','),write(Next),write(']')
	;
	boss_dungeon(X2,Y2), Temp =:= Y2, Next =:= X2 ->
		write('Boss boi'),
		retract(positionX(_)),
		asserta(positionX(Next)),!,
		write('['),write(Temp),write(','),write(Next),write(']')
	;
	retract(positionX(_)),
	asserta(positionX(Next)),!,
	write('['),write(Temp),write(','),write(Next),write(']')
	).

% Gerak ke bawah
s :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp + 1),
	(
	Next =:= 19 -> write('Kena Batas')
	;
	shop(X1,Y1), TempX =:= X1, Next =:= Y1 ->
		write('Shop boi'),
		retract(positionY(_)),
		asserta(positionY(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']')
	;
	boss_dungeon(X2,Y2), TempX =:= X2, Next =:= Y2 ->
		write('Boss boi'),
		retract(positionY(_)),
		asserta(positionY(Next)),!,
		write('['),write(Next),write(','),write(TempX),write(']')
	;
	retract(positionY(_)),
	asserta(positionY(Next)),!,
	write('['),write(Next),write(','),write(TempX),write(']')
	).

% Gerak ke kanan
d :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX + 1),
	(
	Next =:= 19 -> write('Kena Batas')
	;
	shop(X1,Y1), Temp =:= Y1, Next =:= X1 ->
		write('Shop boi'),
		retract(positionX(_)),
		asserta(positionX(Next)),!,
		write('['),write(Temp),write(','),write(Next),write(']')
	;
	boss_dungeon(X2,Y2), Temp =:= Y2, Next =:= X2 ->
		write('Boss boi'),
		retract(positionX(_)),
		asserta(positionX(Next)),!,
		write('['),write(Temp),write(','),write(Next),write(']')
	;
	retract(positionX(_)),
	asserta(positionX(Next)),!,
	write('['),write(Temp),write(','),write(Next),write(']')
	).

% Print map
% Mencapai kanan bawah
printX(X,Y) :-
	(
	X =:= 19, Y =:= 19 ->
		write('X')
	).

% Print simbol pemain
printX(X,Y) :-
	(
	positionX(A), X =:= A, positionY(B), Y =:= B ->
		write('P')),
    NextX is (X + 1),
    printX(NextX,Y).

% Print simbol shop
printX(X,Y) :-
	(
	shop(X1,Y1), X =:= X1, Y =:= Y1 ->
		write('S')),
    NextX is (X + 1),
    printX(NextX,Y).

% Print simbol boss_dungeon
printX(X,Y) :-
	(
	boss_dungeon(X1,Y1), X =:= X1, Y =:= Y1 ->
		write('D')),
    NextX is (X + 1),
    printX(NextX,Y).

% Print batas bawah
printX(X,Y) :-
	(
	Y =:= 19 ->
		write('X')
	),
    NextX is (X + 1),
    printX(NextX,Y).

% Print batas kiri
printX(X,Y) :-
	(
	X =:= 0 ->
		write('X')
	),
    NextX is (X + 1),
    printX(NextX,Y).

% Print batas kanan
printX(X,Y) :-
	(
	X =:= 19 ->
		 write('X'),nl
	),
    NextX is 0,
    NextY is (Y + 1),
    printX(NextX,NextY).

% Print batas atas
printX(X,Y) :-
	(
	Y =:= 0 ->
		write('X')
	),
    NextX is (X + 1),
    printX(NextX,Y).

% Print petak isi
printX(X,Y) :-
	(
	\+ X =:= 0, \+ X =:= 19, \+ Y =:= 0, \+ Y =:= 19 ->
    	write('-')
	),
    NextX is (X + 1),
    printX(NextX,Y).

map :- 
    printX(0,0),!.