#include "../include/mystrfunctions.h"
#include <stdio.h>

// Return length of string
int mystrlen(const char* s) {
    int len = 0;
    while (s[len] != '\0') {
        len++;
    }
    return len;
}

// Copy src into dest
int mystrcpy(char* dest, const char* src) {
    int i = 0;
    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return i; // number of characters copied
}

// Copy at most n characters
int mystrncpy(char* dest, const char* src, int n) {
    int i = 0;
    while (i < n && src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    // pad with '\0' if needed
    while (i < n) {
        dest[i++] = '\0';
    }
    return n;
}

// Concatenate src to end of dest
int mystrcat(char* dest, const char* src) {
    int dlen = mystrlen(dest);
    int i = 0;
    while (src[i] != '\0') {
        dest[dlen + i] = src[i];
        i++;
    }
    dest[dlen + i] = '\0';
    return dlen + i; // new length
}
