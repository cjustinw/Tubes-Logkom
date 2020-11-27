
:- dynamic(enemy/9).

/* enemy(ID,Name,Level,HP,MaxHP,ATT,DEF,PosY,PosX) */

print_boss :-
	% ASCII Art from: https://ascii.co.uk/art/dragon
	nl,
	write('                                 _'),nl,
	write('                              ==(W{==========-      /===-'),nl,
	write('                                ||  (.--.)         /===-_---~~~~~~~----__'),nl,
	write('                                | '),put(92),write('_,|**|,__      |===-~___            _,-'),put(39),write('`'),nl,
	write('                   -=='),put(92),put(92),write('        `'),put(92),write(' '),put(39),write(' `--'),put(39),write('   ),    `//~'),put(92),put(92),write('   ~~~~`--._.-~'),nl,
	write('               ______-==|        /`'),put(92),write('_. .__/'),put(92),write(' '),put(92),write('    | |  '),put(92),put(92),write('          _-~`'),nl,
	write('         __--~~~  ,-/-=='),put(92),put(92),write('      (   | .  |~~~~|   | |   `'),put(92),write('       ,'),put(39),nl,
	write('      _-~       /'),put(39),write('    |  '),put(92),put(92),write('     )__/==0==-'),put(92),write('<>/   / /      '),put(92),write('     /'),nl,
	write('    .'),put(39),write('        /       |   '),put(92),put(92),write('      /~'),put(92),write('___/~~'),put(92),write('/  /'),put(39),write(' /        '),put(92),write('   /'),nl,
	write('   /  ____  /         |    '),put(92),write('`'),put(92),write('.__/-~~   '),put(92),write('  |_/'),put(39),write('  /          '),put(92),write('/'),put(39),nl,
	write('  /-'),put(39),write('~    ~~~~~---__  |     ~-/~         ( )   /'),put(39),write('       _--~`'),nl,
	write('                    '),put(92),write('_|      /        _) | ;  ),   __--~~'),nl,
	write('                      '),put(39),write('~~--_/      _-~/- |/ '),put(92),write('   '),put(39),write('-~ '),put(92),nl,
	write('                     {'),put(92),write('__--_/}    / '),put(92),put(92),write('_>-|)<__'),put(92),write('      '),put(92),nl,
	write('                     /'),put(39),write('   (_/  _-~  | |__>--<__|      |'),nl,
	write('                    |   _/) )-~     | |__>--<__|      |'),nl,
	write('                    / /~ ,_/       / /__>---<__/      |'),nl,
	write('                   o-o _//        /-~_>---<__-~      /'),nl,
	write('                   (^(~          /~_>---<__-      _-~'),nl,
	write('                  ,/|           /__>--<__/     _-~'),nl,
	write('               ,//('),put(39),write('(          |__>--<__|     /                  .--_'),nl,
	write('              ( ( '),put(39),write('))          |__>--<__|    |                 /'),put(39),write(' _-_~'),put(92),nl,
	write('           `-)) )) (           |__>--<__|    |               /'),put(39),write(' /   ~'),put(92),write('`'),put(92),nl,
	write('          ,/,'),put(39),write('//( (             '),put(92),write('__>--<__'),put(92),write('    '),put(92),write('            /'),put(39),write(' //      ||'),nl,
	write('        ,( ( ((, ))              ~-__>--<_~-_  ~--__---~'),put(39),write('/'),put(39),write('/  /'),put(39),write('      VV'),nl,
	write('      `~/  )` ) ,/|                 ~-_~>--<_/-__      __-~_/'),nl,
	write('    ._-~//( )/ )) `                    ~~-'),put(39),write('_/_/ /~~~~~__--~'),nl,
	write('     ;'),put(39),write('( '),put(39),write('))/ ,)(                              ~~~~~~~~'),nl,
	write('    '),put(39),write(' '),put(39),write(') '),put(39),write('( (/').

print_you_drowned :-
	% ASCII Art from: https://manytools.org/hacker-tools/ascii-banner/
	write(':::   :::  ::::::::  :::    :::      :::::::::  :::::::::   ::::::::  :::       ::: ::::    ::: :::::::::: :::::::::  '),nl,
	write(':+:   :+: :+:    :+: :+:    :+:      :+:    :+: :+:    :+: :+:    :+: :+:       :+: :+:+:   :+: :+:        :+:    :+: '),nl,
	write(' +:+ +:+  +:+    +:+ +:+    +:+      +:+    +:+ +:+    +:+ +:+    +:+ +:+       +:+ :+:+:+  +:+ +:+        +:+    +:+ '),nl,
	write('  +#++:   +#+    +:+ +#+    +:+      +#+    +:+ +#++:++#:  +#+    +:+ +#+  +:+  +#+ +#+ +:+ +#+ +#++:++#   +#+    +:+ '),nl,
	write('   +#+    +#+    +#+ +#+    +#+      +#+    +#+ +#+    +#+ +#+    +#+ +#+ +#+#+ +#+ +#+  +#+#+# +#+        +#+    +#+ '),nl,
	write('   #+#    #+#    #+# #+#    #+#      #+#    #+# #+#    #+# #+#    #+#  #+#+# #+#+#  #+#   #+#+# #+#        #+#    #+# '),nl,
	write('   ###     ########   ########       #########  ###    ###  ########    ###   ###   ###    #### ########## #########  '),nl.

print_wolf :-
	% ASCII Art from: https://www.asciiart.eu/animals/wolves
	write('                              __'),nl,
	write('                            .d$$b'),nl,
	write('                          .'),put(39),write(' TO$;'),put(92),nl,
	write('                         /  : TP._;'),nl,
	write('                        / _.;  :Tb|'),nl,
	write('                       /   /   ;j$j'),nl,
	write('                   _.-"       d$$$$'),nl,
	write('                 .'),put(39),write(' ..       d$$$$;'),nl,
	write('                /  /P'),put(39),write('      d$$$$P. |'),put(92),nl,
	write('               /   "      .d$$$P'),put(92),write(' |'),put(92),write('^"l'),nl,
	write('             .'),put(39),write('           `T$P^"""""  :'),nl,
	write('         ._.'),put(39),write('      _.'),put(39),write('                ;'),nl,
	write('      `-.-".-'),put(39),write('-'),put(39),write(' ._.       _.-"    .-"'),nl,
	write('    `.-" _____  ._              .-"'),nl,
	write('   -(.g$$$$$$$b.              .'),put(39),nl,
	write('     ""^^T$$$P^)            .(:'),nl,
	write('       _/  -"  /.'),put(39),write('         /:/;'),nl,
	write('    ._.'),put(39),write('-'),put(39),write('`-'),put(39),write('  ")/         /;/;'),nl,
	write(' `-.-"..--""   " /         /  ;'),nl,
	write('.-" ..--""        -'),put(39),write('          :'),nl,
	write('..--""--.-"         ('),put(92),write('      .-('),put(92),nl,
	write('  ..--""              `-'),put(92),write('('),put(92),write('/;`'),nl,
	write('    _.                      :'),nl,
	write('                            ;`-'),nl,
	write('                           :'),put(92),nl,
	write('                           ;'),nl,nl,
	write('There is a Wild Wolf ahead, Traveler! Prepare for bloodbath!').

print_slime :-
	% ASCII Art from: https://textart.sh/topic/slime
	write('                @@@@@@@@@@@@@@@@/                '),nl,
	write('          @@@@@@.  *//.   .***. #@@@@@@          '),nl,
	write('       @@@.............................@@@       '),nl,
	write('       @@@.............................@@@       '),nl,
	write('   %@@@...................................@@@    '),nl,
	write('   %@@@......@@@.................@@@......@@@    '),nl,
	write('   %@@@......@@@.................@@@......@@@    '),nl,
	write('@@@..........@@@.................@@@.........@@@@'),nl,
	write('@@@..........@@@.................@@@.........&@@@'),nl,
	write('@@@*.........@@@,...............(@@@.........&@@@'),nl,
	write('@@@*.........................................&@@@'),nl,
	write('@@@/*........./*@@@&.........@@@(*........./*@@@@'),nl,
	write('@@@&%%%**.........,*@@@@@@@@@*,............%&@@@@'),nl,
	write('@@@%/*/.............@@@@@@@@@............./*(&@@@'),nl,
	write('   %@@@%%%%%%%%%%%%%%%%%&%%%%%%%%%%%%%%%%%@@@    '),nl,
	write('       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       '),nl,nl,
	write('There is a Slime ahead, Traveler! Prepare for bloodbath!').

print_goblin :-
	% ASCII Art from: https://www.oocities.org/spunk1111/people.htm
	write('         ,      ,         '),write('         ,      ,         '),write('         ,      ,         '),nl,
	write('        /(.-""-.)'),put(92),write('        '),write('        /(.-""-.)'),put(92),write('        '),write('        /(.-""-.)'),put(92),write('        '),nl,
	write('    |'),put(92),write('  '),put(92),write('/      '),put(92),write('/  /|    '),write('    |'),put(92),write('  '),put(92),write('/      '),put(92),write('/  /|    '),write('    |'),put(92),write('  '),put(92),write('/      '),put(92),write('/  /|    '),nl,
	write('    | '),put(92),write(' / =.  .= '),put(92),write(' / |    '),write('    | '),put(92),write(' / =.  .= '),put(92),write(' / |    '),write('    | '),put(92),write(' / =.  .= '),put(92),write(' / |    '),nl,
	write('    '),put(92),write('( '),put(92),write('   o'),put(92),write('/o   / )/    '),write('    '),put(92),write('( '),put(92),write('   o'),put(92),write('/o   / )/    '),write('    '),put(92),write('( '),put(92),write('   o'),put(92),write('/o   / )/    '),nl,
	write('     '),put(92),write('_, '),put(39),write('-/  '),put(92),write('-'),put(39),write(' ,_/     '),write('     '),put(92),write('_, '),put(39),write('-/  '),put(92),write('-'),put(39),write(' ,_/     '),write('     '),put(92),write('_, '),put(39),write('-/  '),put(92),write('-'),put(39),write(' ,_/     '),nl,
	write('       /   '),put(92),write('__/   '),put(92),write('       '),write('       /   '),put(92),write('__/   '),put(92),write('       '),write('       /   '),put(92),write('__/   '),put(92),write('       '),nl,
	write('       '),put(92),write(' '),put(92),write('__/'),put(92),write('__/ /       '),write('       '),put(92),write(' '),put(92),write('__/'),put(92),write('__/ /       '),write('       '),put(92),write(' '),put(92),write('__/'),put(92),write('__/ /       '),nl,
	write('     ___'),put(92),write(' '),put(92),write('|--|/ /___     '),write('     ___'),put(92),write(' '),put(92),write('|--|/ /___     '),write('     ___'),put(92),write(' '),put(92),write('|--|/ /___     '),nl,
	write('   /`    '),put(92),write('      /    `'),put(92),write('   '),write('   /`    '),put(92),write('      /    `'),put(92),write('   '),write('   /`    '),put(92),write('      /    `'),put(92),write('   '),nl,
	write('  /       '),put(39),write('----'),put(39),write('       '),put(92),write('  '),write('  /       '),put(39),write('----'),put(39),write('       '),put(92),write('  '),write('  /       '),put(39),write('----'),put(39),write('       '),put(92),write('  '),nl,nl,
	write('There is a Group of Goblins ahead, Traveler! Prepare for bloodbath!').
    
createEnemy(ID,PosY,PosX) :-
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
    asserta(enemy(ID,slime,Level,HP,MaxHP,ATT,DEF,PosY,PosX)),!.

createEnemy(ID,PosY,PosX) :-
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
    asserta(enemy(ID,goblin,Level,HP,MaxHP,ATT,DEF,PosY,PosX)),!.

createEnemy(ID,PosY,PosX) :-
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
    asserta(enemy(ID,wolf,Level,HP,MaxHP,ATT,DEF,PosY,PosX)),!.

createBoss :-
    asserta(enemy(4,dragon,5,3000,3000,600,500,6,14)).

generateEnemy(Condition) :-
    random(1,34,PosX),
    random(1,34,PosY),
    (
        (
            player_X(TempX), player_Y(TempY), PosY =:= TempY, PosX =:= TempX ->
                Condition = fail
        );
        (
            shop(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            quest(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            monstadt(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            liyue_harbor(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            qingyun_peak(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            boss_dungeon(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            enemy(_,_,_,_,_,_,_,Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            water(Y,X), PosY =:= Y, PosX =:= X ->
                Condition = fail
        );
        (
            Condition = success,
            (
                slime_Z(Y,X), PosY =:= Y, PosX =:= X ->
                    createEnemy(1,PosY,PosX)
                ;
                goblin_Z(Y,X), PosY =:= Y, PosX =:= X ->
                    createEnemy(2,PosY,PosX)
                ;
                wolf_Z(Y,X), PosY =:= Y, PosX =:= X ->
                    createEnemy(3,PosY,PosX)
                ;
                random(1,4,ID),
                createEnemy(ID,PosY,PosX)
            )
            
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
    generateAllEnemy(50),
    createBoss.


