all: dfm_screen

dfm_screen: dfm_screen.c
	gcc dfm_screen.c -o dfm_screen -lncurses

clean:
	rm dfm_screen

install: all
	install dfm /usr/local/bin/
	install dfm_screen /usr/local/bin/

uninstall:
	rm /usr/local/bin/dfm
	rm /usr/local/bin/dfm_screen
