#include <stdio.h>
#include <stdlib.h>

int main(int argc, char ** argv) {
	double sum = 0;
	for (int i = 0; i < argc - 1; ++i) {
		sum += atof(argv[i + 1]);
	}

	printf("%.15g\n", sum);

	return 0;
}
