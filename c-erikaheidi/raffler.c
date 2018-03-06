#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *list;

int main(int argc, char **argv) 
{
	int ch;
	int lines = 0;
	int winnerLine = 0;
	int currentLine = 0;
	char readLine[50];
	time_t t;
	
	if (argc < 2) {
		printf("You forgot to provide a filename.\n");
		return 0;
	}
	
	printf("Reading File: %s\n", argv[1]);
	
	list = fopen(argv[1], "r");
	if (!list) {
		printf("File not Found.\n");
		return 0;
	}
	
	do {
		ch = fgetc(list);
		if (ch == '\n') {
			lines++;
		}
	} while (ch != EOF);

	printf("Total entries: %d\n", lines);
	
	srand((unsigned) time(&t));
	winnerLine = rand() % lines;

	//now get the freaking name from the file
	rewind(list);
	while(currentLine < winnerLine) {
		ch = fgetc(list);
		if (ch == '\n') {
			currentLine++;
		}
	}
	fgets(readLine, 50, list);
	printf("Winner: %s\n", readLine); 	

}
