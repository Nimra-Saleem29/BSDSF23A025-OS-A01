# Compiler and flags
CC = gcc
CFLAGS = -Iinclude -Wall -Wextra

# Directories
SRC = src
OBJ = obj
BIN = bin
MAN = man/man1

# Source files
SRCS = $(SRC)/mystrfunctions.c $(SRC)/myfilefunctions.c $(SRC)/main.c

# Object files
OBJS = $(patsubst $(SRC)/%.c,$(OBJ)/%.o,$(SRCS))

# Target executables
TARGET_DYNAMIC = $(BIN)/client_dynamic
TARGET_STATIC  = $(BIN)/client_static

# Default rule
all: $(TARGET_DYNAMIC)

# Link object files into dynamic executable
$(TARGET_DYNAMIC): $(OBJS)
	@mkdir -p $(BIN)
	$(CC) $(OBJS) -o $(TARGET_DYNAMIC)

# Link object files into static executable
$(TARGET_STATIC): $(OBJS)
	@mkdir -p $(BIN)
	$(CC) -static $(OBJS) -o $(TARGET_STATIC)

# Compile .c -> .o
$(OBJ)/%.o: $(SRC)/%.c
	@mkdir -p $(OBJ)
	$(CC) $(CFLAGS) -c $< -o $@

# Run targets
run_dynamic: $(TARGET_DYNAMIC)
	./$(TARGET_DYNAMIC)

run_static: $(TARGET_STATIC)
	./$(TARGET_STATIC)

# Clean object files and binaries
clean:
	rm -f $(OBJ)/*.o $(BIN)/*

# Install executable and man page
install: $(TARGET_DYNAMIC)
	@sudo mkdir -p /usr/local/bin
	@sudo mkdir -p /usr/local/share/man/man1
	@sudo cp $(TARGET_DYNAMIC) /usr/local/bin/client
	@sudo cp $(MAN)/client.1 /usr/local/share/man/man1/
	@sudo chmod 755 /usr/local/bin/client
	@sudo chmod 644 /usr/local/share/man/man1/client.1
	@sudo mandb
