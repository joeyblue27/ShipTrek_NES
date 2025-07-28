ca65 game_main.s -o game_main.o --debug-info
ld65 game_main.o -o game_main.nes -t nes --dbgfile game_main.dbg

