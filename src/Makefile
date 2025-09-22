

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Iinclude

# Directories
SRC = src
OBJ = obj
BIN = bin

# Target executable
TARGET = $(BIN)/myprog

# Source and object files
SRCS = $(wildcard $(SRC)/*.c)
OBJS = $(patsubst $(SRC)/%.c,$(OBJ)/%.o,$(SRCS))

# Default rule
all: $(TARGET)

# Link object files
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

# Compile source files
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Run program
run: $(TARGET)
	./$(TARGET)

# Clean build artifacts
clean:
	rm -f $(OBJ)/*.o $(TARGET)
install:
	mkdir -p /usr/local/bin
	mkdir -p /usr/local/share/man/man1
	mkdir -p /usr/local/lib
	cp bin/client_dynamic /usr/local/bin/client
	cp man/man1/client.1 /usr/local/share/man/man1/
	cp lib/libmyutils.so /usr/local/lib/
	chmod 755 /usr/local/bin/client
	chmod 644 /usr/local/share/man/man1/client.1
	chmod 755 /usr/local/lib/libmyutils.so
	sudo ldconfig
