#include <curses.h>
#include <stdio.h>
#include <locale.h>

char outchar;
int width;
int height;
int sel_x;
int sel_y;
WINDOW * windows[3];
SCREEN * screen;

int main(int argc, char ** argv) {
	if (argc != 5) {
		fprintf(stderr, "%s [title] [col 1] [col 2] [col 3]\n", argv[0]);
		return -1;
	}

	setlocale(LC_ALL, "");
	screen = newterm(NULL, stderr, stdin);
	refresh();
	printw(argv[1]);

	noecho();

	getmaxyx(stdscr, height, width);
	width /= 3;

	for (int i = 0; i < 4; ++i) {
		windows[i] = newwin(0, width, 1, i * width);
		wprintw(windows[i], argv[i + 2]);
		wrefresh(windows[i]);
	}

	char c = getch();

	for (int i = 0; i < 3; ++i)
		delwin(windows[i]);

	delscreen(screen);

	putc(c, stdout);

	return 0;
}
