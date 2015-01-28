#include <stdio.h>
#include <stdlib.h>

int lineLength(FILE *file) {
    char c;
    int count = 0;
    fpos_t pos;

    fgetpos(file, &pos);

    while (!feof(file)) {
        c = fgetc(file);
        if (c == '\n') {
            fsetpos(file, &pos);
            return count;
        }
        count++;
    }
}

int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Didn't you forget something?\n");
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (0 == file) {
        printf("Your input file is broken!\n");
        return 2;
    }

    int nameCounter = 0; 
    char c;
    while (!feof(file)) {
       c = fgetc(file);
       if (c == '\n') {
           nameCounter++;
       }
    }

    printf("I counted %d names to choose from!\n", nameCounter);

    rewind(file);

    int counter;
    int nameLength;
    for (counter = 0; counter < nameCounter; counter++) {

        nameLength = lineLength(file);
        char name[nameLength];

        int i;
        for (i = 0; i < nameLength; i++) {
            name[i] = fgetc(file);
        }
        c = fgetc(file); // newline

        printf("Found name %s\n", name);
    }

    fclose(file);
}
