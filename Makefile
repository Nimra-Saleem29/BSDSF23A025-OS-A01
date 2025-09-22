# Compiler and flags
CC = gcc
CFLAGS = -Iinclude -Wall -Wextra

# Directories
SRC = src
OBJ = obj
BIN = bin

# Source files
SRCS = $(SRC)/mystrfunctions.c $(SRC)/myfilefunctions.c $(SRC)/main.c

# Object files
OBJS = $(patsubst $(SRC)/%.c,$(OBJ)/%.o,$(SRCS))

# Target executable
TARGET = $(BIN)/client

# Default rule
all: $(TARGET)

# Link object files into executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

# Compile .c -> .o
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean
clean:
	rm -f $(OBJ)/*.o $(BIN)/*
