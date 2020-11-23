
:- dynamic(init/1).

:- include('command.pl').
:- include('player.pl').
:- include('map_GI.pl').
:- include('item.pl').
:- include('inventory.pl').
:- include('shop.pl').
:- include('enemy.pl').
:- include('battle.pl').
:- include('quest.pl').

title :- 
    nl,
    write(' $$$$$$'),put(92),write('  $$$$$$$$'),put(92),write(' $$'),put(92),write('   $$'),put(92),write('  $$$$$$'),put(92),write('  $$'),put(92),write('   $$'),put(92),write(' $$$$$$'),put(92),write(' $$'),put(92),write('   $$'),put(92),write('        $$$$$$'),put(92),write('  $$$$$$$$'),put(92),write(' $$'),put(92),write('   $$'),put(92),write('  $$$$$$'),put(92),write('  $$$$$$'),put(92),nl,
    write('$$  __$$'),put(92),write(' $$  _____|$$$'),put(92),write('  $$ |$$  __$$'),put(92),write(' $$ |  $$ |'),put(92),write('_$$  _|$$$'),put(92),write('  $$ |      $$  __$$'),put(92),write(' $$  _____|$$ | $$  |$$  __$$'),put(92),write(' '),put(92),write('_$$  _|'),nl,
    write('$$ /  '),put(92),write('__|$$ |      $$$$'),put(92),write(' $$ |$$ /  '),put(92),write('__|$$ |  $$ |  $$ |  $$$$'),put(92),write(' $$ |      $$ /  '),put(92),write('__|$$ |      $$ |$$  / $$ /  $$ |  $$ |  '),nl,
    write('$$ |$$$$'),put(92),write(' $$$$$'),put(92),write('    $$ $$'),put(92),write('$$ |'),put(92),write('$$$$$$'),put(92),write('  $$$$$$$$ |  $$ |  $$ $$'),put(92),write('$$ |      '),put(92),write('$$$$$$'),put(92),write('  $$$$$'),put(92),write('    $$$$$  /  $$$$$$$$ |  $$ |  '),nl,
    write('$$ |'),put(92),write('_$$ |$$  __|   $$ '),put(92),write('$$$$ | '),put(92),write('____$$'),put(92),write(' $$  __$$ |  $$ |  $$ '),put(92),write('$$$$ |       '),put(92),write('____$$'),put(92),write(' $$  __|   $$  $$<   $$  __$$ |  $$ |  '),nl,
    write('$$ |  $$ |$$ |      $$ |'),put(92),write('$$$ |$$'),put(92),write('   $$ |$$ |  $$ |  $$ |  $$ |'),put(92),write('$$$ |      $$'),put(92),write('   $$ |$$ |      $$ |'),put(92),write('$$'),put(92),write('  $$ |  $$ |  $$ |  '),nl,
    put(92),write('$$$$$$  |$$$$$$$$'),put(92),write(' $$ | '),put(92),write('$$ |'),put(92),write('$$$$$$  |$$ |  $$ |$$$$$$'),put(92),write(' $$ | '),put(92),write('$$ |      '),put(92),write('$$$$$$  |$$$$$$$$'),put(92),write(' $$ | '),put(92),write('$$'),put(92),write(' $$ |  $$ |$$$$$$'),put(92),write(' '),nl,
    write(' '),put(92),write('______/ '),put(92),write('________|'),put(92),write('__|  '),put(92),write('__| '),put(92),write('______/ '),put(92),write('__|  '),put(92),write('__|'),put(92),write('______|'),put(92),write('__|  '),put(92),write('__|       '),put(92),write('______/ '),put(92),write('________|'),put(92),write('__|  '),put(92),write('__|'),put(92),write('__|  '),put(92),write('__|'),put(92),write('______|'),nl,
    nl,
    help.

help :-
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                ~Command Table~               %\n'),
    write('%                                              %\n'),
    write('%     status  : menampilkan status pemain      %\n'),
    write('%     map     : menampilkan peta               %\n'),
    write('%     w       : gerak ke utara 1 langkah       %\n'),
    write('%     a       : gerak ke barat 1 langkah       %\n'),
    write('%     s       : gerak ke selatan 1 langkah     %\n'),
    write('%     d       : gerak ke timur 1 langkah       %\n'),
    write('%     quest   : menampilkan quest berlangsung  %\n'),
    write('%     help    : menampilkan bantuan            %\n'),
    write('%     quit    : keluar permainan               %\n'),
    write('%                                              %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').

start :- 
    init(_),
    write('Game already started!'),!.

start :- 
    \+init(_),
    asserta(init(1)),
    title, 
    write('\nWelcome to Genshin Sekai!\n'),
    write('\nWhat is your name, traveler? '),
    read(Username),
    write('\nWelcome to Genshin Sekai, '),
    write(Username),
    write('!\n'),
    write('\nNow, please choose your job!\n'),
    write('1. Swordsman\n'),
    write('2. Archer\n'),
    write('3. Sorcerer\n\n'),
    read(JobID),
    generatePlayer(Username,JobID),
    player(Username,Job,_,_,_,_,_,_,_,_),
    write('\nYou choose '),
    write(Job),
    write(', lets explore the world!\n'),
    initial,
    initInventory,
    generateAllEnemy(50),!.

quit :-
    init(_),
    retract(init(_)),
    write('\nGood-bye!\n'),
    retractall(player(_,_,_,_,_,_,_,_,_,_)),
    retractall(enemy(_,_,_,_,_,_,_,_,_)),
    retractall(size(_,_)),
    retractall(playerPosition(_,_)),
    retractall(shopPosition(_,_)),
    retractall(questPosition(_,_)),
    retractall(dungeonPosition(_,_)),!.
