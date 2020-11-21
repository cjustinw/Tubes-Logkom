:- dynamic(koord_P_X/1).
:- dynamic(koord_P_Y/1).
:- dynamic(shop/2).
:- dynamic(boss_dungeon/2).

initial :- 
	asserta(koord_P_X(1)),
	asserta(koord_P_Y(1)),
	asserta(shop(11,11)),           /* --> Bisa diganti* */
	asserta(boss_dungeon(15,15)).   /* --> Bisa diganti* */

/* * : Tidak menggunakan random, karena hasil random selalu sama untuk langkah ke-N pada console */

/* Perintah Navigasi: */
/* Gerak ke atas */
w :-
    koord_P_X(TempX),
    koord_P_Y(Temp),
    Next is (Temp - 1),
	(
	Next =:= 0 ->
        write('Kena Batas')
	;
    shop(X1,Y1), TempX =:= X1, Next =:= Y1 ->
        write('Shop boi'),
        retract(koord_P_Y(_)),
        asserta(koord_P_Y(Next)),!,
        write('['),write(Next),write(','),write(TempX),write(']')
    ;
    boss_dungeon(X2,Y2), TempX =:= X2, Next =:= Y2 ->
        write('Boss boi'),
        retract(koord_P_Y(_)),
        asserta(koord_P_Y(Next)),!,
        write('['),write(Next),write(','),write(TempX),write(']')
    ;
	retract(koord_P_Y(_)),
	asserta(koord_P_Y(Next)),!,
	write('['),write(Next),write(','),write(TempX),write(']')
	).

/* Gerak ke kiri */
a :-
    koord_P_X(TempX),
    koord_P_Y(Temp),
    Next is (TempX - 1),
	(
	Next =:= 0 -> write('Kena Batas')
	;
    shop(X1,Y1), Temp =:= Y1, Next =:= X1 ->
        write('Shop boi'),
        retract(koord_P_X(_)),
        asserta(koord_P_X(Next)),!,
        write('['),write(Temp),write(','),write(Next),write(']')
    ;
    boss_dungeon(X2,Y2), Temp =:= Y2, Next =:= X2 ->
        write('Boss boi'),
        retract(koord_P_X(_)),
        asserta(koord_P_X(Next)),!,
        write('['),write(Temp),write(','),write(Next),write(']')
    ;
	retract(koord_P_X(_)),
	asserta(koord_P_X(Next)),!,
	write('['),write(Temp),write(','),write(Next),write(']')
	).

/* Gerak ke bawah */
s :-
    koord_P_X(TempX),
    koord_P_Y(Temp),
    Next is (Temp + 1),
	(
	Next =:= 19 ->
        write('Kena Batas')
	;
    shop(X1,Y1), TempX =:= X1, Next =:= Y1 ->
        write('Shop boi'),
        retract(koord_P_Y(_)),
        asserta(koord_P_Y(Next)),!,
        write('['),write(Next),write(','),write(TempX),write(']')        
    ;
    boss_dungeon(X2,Y2), TempX =:= X2, Next =:= Y2 ->
        write('Boss boi'),
        	retract(koord_P_Y(_)),
            asserta(koord_P_Y(Next)),!,
            write('['),write(Next),write(','),write(TempX),write(']')
    ;
 	retract(koord_P_Y(_)),
	asserta(koord_P_Y(Next)),!,
	write('['),write(Next),write(','),write(TempX),write(']')
	).

/* Gerak ke kanan */
d :-
    koord_P_X(TempX),
    koord_P_Y(Temp),
    Next is (TempX + 1),
	(
	Next =:= 19 ->
        write('Kena Batas')
	;
    shop(X1,Y1), Temp =:= Y1, Next =:= X1 ->
        write('Shop boi'),
        retract(koord_P_X(_)),
        asserta(koord_P_X(Next)),!,
        write('['),write(Temp),write(','),write(Next),write(']')
    ;
    boss_dungeon(X2,Y2), Temp =:= Y2, Next =:= X2 ->
        write('Boss boi'),
    	retract(koord_P_X(_)),
        asserta(koord_P_X(Next)),!,
        write('['),write(Temp),write(','),write(Next),write(']')
    ;
	retract(koord_P_X(_)),
	asserta(koord_P_X(Next)),!,
	write('['),write(Temp),write(','),write(Next),write(']')
	).

/* Print Map */
printX(X,Y) :-
    (
	Y =:= 0 ->          /* Print batas atas */
        write('X')
	),
    NextX is (X + 1),
    printX(NextX,Y).

printX(X,Y) :-
    (
	X =:= 0 ->          /* Print batas kiri */
        write('X')
	),
    NextX is (X + 1),
    printX(NextX,Y).

printX(X,Y) :-
	(
	Y =:= 19 ->         /* Print batas bawah */
        write('X')
	),
    NextX is (X + 1),
    printX(NextX,Y).

printX(X,Y) :-
    (
	X =:= 19 ->         /* Print batas kanan */
        write('X'),
        nl
	),
    NextX is 0,         /* Next: Turun 1, kembali ke ujung kiri */
    NextY is (Y + 1),   
    printX(NextX,NextY).

printX(X,Y) :-          /* Print petak isi */
	\+ X =:= 0,
	\+ X =:= 19,
	\+ Y =:= 0,
	\+ Y =:= 19,
    write('-'),
    NextX is (X + 1),
    printX(NextX,Y).

printX(X,Y) :-
    (
	X =:= 19, Y =:= 19 ->           /* --> Sudah mencapai kanan bawah */
        write('X')
	).

printX(X,Y) :-
	(
	koord_P_X(A), X =:= A, koord_P_Y(B), Y =:= B ->     /* Print simbol pemain */
        write('P')
    ),
    NextX is (X + 1),
    printX(NextX,Y).

printX(X,Y) :-
	(
	shop(X1,Y1), X =:= X1, Y =:= Y1 ->                  /* Print simbol shop */
        write('S')
    ),
    NextX is (X + 1),
    printX(NextX,Y).

printX(X,Y) :-
	(
	boss_dungeon(X1,Y1), X =:= X1, Y =:= Y1 ->          /* Print simbol boss_dungeon */
        write('D')
    ),
    NextX is (X + 1),
    printX(NextX,Y).

map :- 
    printX(0,0),!.