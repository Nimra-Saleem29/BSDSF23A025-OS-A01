#ifndef MYFILEFUNCTIONS_H
#define MYFILEFUNCTIONS_H

#include <stdio.h>

// Counts number of lines, words, and characters in a file
int wordCount(FILE* file, int* lines, int* words, int* chars);

// Searches for a string in a file, returns matching lines
int mygrep(FILE* fp, const char* search_str, char*** matches);

#endif
