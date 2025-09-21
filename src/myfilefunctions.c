#include "../include/myfilefunctions.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (file == NULL) return -1;

    *lines = *words = *chars = 0;
    int c, inWord = 0;

    rewind(file);
    while ((c = fgetc(file)) != EOF) {
        (*chars)++;
        if (c == '\n') (*lines)++;
        if (isspace(c)) {
            inWord = 0;
        } else if (!inWord) {
            inWord = 1;
            (*words)++;
        }
    }
    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (fp == NULL || search_str == NULL) return -1;

    rewind(fp);
    size_t cap = 8;
    size_t count = 0;
    char** arr = malloc(cap * sizeof(char*));
    if (!arr) return -1;

    char* line = NULL;
    size_t len = 0;
    ssize_t read;

    while ((read = getline(&line, &len, fp)) != -1) {
        if (strstr(line, search_str)) {
            if (count >= cap) {
                cap *= 2;
                arr = realloc(arr, cap * sizeof(char*));
                if (!arr) return -1;
            }
            arr[count] = strdup(line);
            count++;
        }
    }
    free(line);

    *matches = arr;
    return (int)count;
}
