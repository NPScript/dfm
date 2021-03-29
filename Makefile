all: dfm_screen add

dfm_screen: dfm_screen.c
	gcc dfm_screen.c -o dfm_screen -lncurses

add: add.c
	gcc add.c -o add

clean:
	rm dfm_screen
	rm add

install:
	install dfm /usr/local/bin/
	install dfm_screen /usr/local/bin/
	install add /usr/local/bin/

uninstall:
	rm /usr/local/bin/dfm
	rm /usr/local/bin/dfm_screen
	rm /usr/local/bin/add
