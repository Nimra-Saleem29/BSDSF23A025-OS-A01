#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char s1[100] = "Hello";
    char s2[100];
    char s3[100] = " World";

    printf("Length of '%s': %d\n", s1, mystrlen(s1));
    mystrcpy(s2, s1);
    printf("Copied string: %s\n", s2);
    mystrncpy(s2, "Data", 4);
    printf("After strncpy: %s\n", s2);
    mystrcat(s1, s3);
    printf("After strcat: %s\n", s1);

    printf("\n--- Testing File Functions ---\n");
    FILE* f = fopen("test.txt", "r");
    if (!f) {
        printf("Cannot open test.txt\n");
        return 1;
    }

    int lines, words, chars;
    if (wordCount(f, &lines, &words, &chars) == 0) {
        printf("Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);
    }

    char** matches;
    int count = mygrep(f, "data", &matches);
    printf("Lines containing 'data': %d\n", count);
    for (int i = 0; i < count; i++) {
        printf("Match %d: %s", i + 1, matches[i]);
        free(matches[i]);
    }
    free(matches);
    fclose(f);

    return 0;
}
