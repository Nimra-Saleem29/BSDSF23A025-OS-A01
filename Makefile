# --- Makefile for Feature 3: Static Library ---
CC = gcc
CFLAGS = -Iinclude -Wall -Wextra
AR = ar rcs

SRC = src/mystrfunctions.c src/myfilefunctions.c src/main.c
OBJ = obj/mystrfunctions.o obj/myfilefunctions.o obj/main.o

STATIC_LIB = lib/libmyutils.a
BIN_STATIC = bin/client_static

.PHONY: all static clean run

all: static

# Compile source to object
obj/%.o: src/%.c | obj
	$(CC) $(CFLAGS) -c $< -o $@

obj:
	mkdir -p obj

lib:
	mkdir -p lib

bin:
	mkdir -p bin

# Create static library
$(STATIC_LIB): obj/mystrfunctions.o obj/myfilefunctions.o | lib
	$(AR) $(STATIC_LIB) obj/mystrfunctions.o obj/myfilefunctions.o

# Build client_static
static: $(STATIC_LIB) obj/main.o | bin
	$(CC) obj/main.o -Llib -lmyutils -o $(BIN_STATIC)

# Run program
run: static
	./$(BIN_STATIC)

# Clean build artifacts
clean:
	rm -rf obj/* bin/* lib/*.a
# --- end of Makefile ---
