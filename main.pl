
:- dynamic(init/1).
:- dynamic(player/11).

:- include('character.pl').

title :- 
    write('     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('     %                ~Genshin Sekai~               %\n'),
    write('     %                                              %\n'),
    write('     %     status  : menampilkan status pemain      %\n'),
    write('     %     map     : menampilkan peta               %\n'),
    write('     %     w       : gerak ke utara 1 langkah       %\n'),
    write('     %     a       : gerak ke barat 1 langkah       %\n'),
    write('     %     s       : gerak ke selatan 1 langkah     %\n'),
    write('     %     d       : gerak ke timur 1 langkah       %\n'),
    write('     %     help    : menampilkan bantuan            %\n'),
    write('     %                                              %\n'),
    write('     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').


start :- 
    init(_),
    write('Game already started!').

start :- 
    \+init(_),
    title,
    asserta(init(1)),
    write('\nWelcome to Genshin Sekai!\n'),
    write('\nWhat is your name, traveler? '),
    read(Username),
    write('\nWelcome to Genshin Sekai, '),
    write(Username),
    write('!\n'),
    write('\nNow, please choose your job!\n'),
    write('1. Swordsman\n'),
    write('2. Archer\n'),
    write('3. Sorcerer\n'),
    read(JobNumber),
    jobOption(JobNumber,X),
    write('\nYou choose '),
    write(X),
    write(', lets explore the world!\n'),
    asserta(player(Username,X,1,1000,1000,50,50,0,100,1000,[])).


status :-
    player(Username,Job,Level,HP,MaxHP,Att,Def,EXP,MaxEXP,Gold,_),
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

