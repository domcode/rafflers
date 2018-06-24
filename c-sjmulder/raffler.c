#define _WITH_GETLINE

#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <err.h>

int
main(void)
{
	struct timeval tv;
	char *winner = NULL;
	char *line = NULL;
	size_t cap;
	int n = 0;

	gettimeofday(&tv, NULL);
	srand((unsigned)tv.tv_usec);

	while (getline(&line, &cap, stdin) != -1) {
		if (!n || rand() % n == 0) {
			free(winner);
			winner = line;
			line = NULL;
		}
		n += 1;
	}

	if (ferror(stdin))
		err(1, NULL);
	if (!winner)
		errx(1, "empty input");

	fputs(winner, stdout);
	return 0;
}
