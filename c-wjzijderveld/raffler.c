#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Didn't you forget something?\n");
        exit(EXIT_FAILURE);
    }

    FILE *file = fopen(argv[1], "r");
    if (0 == file) {
        printf("Your input file is broken!\n");
        exit(EXIT_FAILURE);
    }

    int nameCounter = 0; 
    char *line = NULL;
    size_t len = 0;
    ssize_t read;
    while ((read = getline(&line, &len, file)) != -1) {
       nameCounter++;
    }

    printf("I counted %d names to choose from!\n", nameCounter);

    struct timeval t1;
    gettimeofday(&t1, NULL);
    srand(t1.tv_usec * t1.tv_sec);
    int luckyWinner = rand() % nameCounter;

    printf("Lucky number %d\n", luckyWinner);

    rewind(file);

    int i;
    for (i = 0; i < luckyWinner; i++) {
        read = getline(&line, &len, file);
    }

    printf("Lucky winner is.... %s", line);

    fclose(file);
    if (line) {
        free(line);
    }

    exit(EXIT_SUCCESS);
}
