# --- Makefile for Static & Dynamic Library Builds ---

CC = gcc
CFLAGS = -Iinclude -Wall -Wextra

OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib

OBJS = $(OBJ_DIR)/mystrfunctions.o $(OBJ_DIR)/myfilefunctions.o
MAIN_OBJ = $(OBJ_DIR)/main.o

STATIC_LIB = $(LIB_DIR)/libmyutils.a
DYNAMIC_LIB = $(LIB_DIR)/libmyutils.so

BIN_STATIC = $(BIN_DIR)/client_static
BIN_DYNAMIC = $(BIN_DIR)/client_dynamic

.PHONY: all static dynamic clean run_static run_dynamic

# Default build: static + dynamic
all: $(BIN_STATIC) $(BIN_DYNAMIC)

# --- Object file compilation ---
$(OBJ_DIR)/%.o: src/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(LIB_DIR):
	mkdir -p $(LIB_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# --- Static Library Rules ---
$(STATIC_LIB): $(OBJS) | $(LIB_DIR)
	ar rcs $@ $^

$(BIN_STATIC): $(MAIN_OBJ) $(STATIC_LIB) | $(BIN_DIR)
	$(CC) $(MAIN_OBJ) -L$(LIB_DIR) -lmyutils -o $@

static: $(BIN_STATIC)

run_static: $(BIN_STATIC)
	./$(BIN_STATIC)

# --- Dynamic Library Rules ---
$(DYNAMIC_LIB): $(OBJS) | $(LIB_DIR)
	$(CC) -shared -o $@ $^

$(BIN_DYNAMIC): $(MAIN_OBJ) $(DYNAMIC_LIB) | $(BIN_DIR)
	$(CC) $(MAIN_OBJ) -L$(LIB_DIR) -lmyutils -o $@

dynamic: $(BIN_DYNAMIC)

run_dynamic: $(BIN_DYNAMIC)
	LD_LIBRARY_PATH=$(LIB_DIR):$$LD_LIBRARY_PATH ./$(BIN_DYNAMIC)

# --- Clean ---
clean:
	rm -rf $(OBJ_DIR)/* $(BIN_DIR)/* $(LIB_DIR)/*
