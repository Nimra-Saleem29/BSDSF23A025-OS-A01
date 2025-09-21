#ifndef MYSTRFUNCTIONS_H
#define MYSTRFUNCTIONS_H

// Returns the length of a string
int mystrlen(const char* s);

// Copies src into dest
int mystrcpy(char* dest, const char* src);

// Copies at most n characters
int mystrncpy(char* dest, const char* src, int n);

// Concatenates src to the end of dest
int mystrcat(char* dest, const char* src);

#endif
