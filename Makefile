# Compiler and flags
CC = gcc
CFLAGS = -Wall -Iinclude

# Directories
SRC = src
OBJ = obj
BIN = bin
LIB = lib

# Targets
TARGET = $(BIN)/myprog
STATIC_LIB = $(LIB)/libmyutils.a
STATIC_CLIENT = $(BIN)/client_static

# Sources and objects
SRCS = $(wildcard $(SRC)/*.c)
OBJS = $(patsubst $(SRC)/%.c,$(OBJ)/%.o,$(SRCS))

# Default rule
all: $(TARGET)

# Normal build
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

# Object compilation
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# ----------------------
# Static library build
# ----------------------

# Main target for static build
static: $(STATIC_LIB) $(STATIC_CLIENT)

# Create static library from obj files (except main.o)
$(STATIC_LIB): obj/mystrfunctions.o obj/myfilefunctions.o
	ar rcs $(STATIC_LIB) obj/mystrfunctions.o obj/myfilefunctions.o

# Build client_static linked with static lib
$(STATIC_CLIENT): obj/main.o $(STATIC_LIB)
	$(CC) obj/main.o -L$(LIB) -lmyutils -o $(STATIC_CLIENT)

# Run program
run: $(TARGET)
	./$(TARGET)

# Run static build
run-static: static
	./$(STATIC_CLIENT)

# Clean
clean:
	rm -f $(OBJ)/*.o $(TARGET) $(STATIC_CLIENT) $(STATIC_LIB)
