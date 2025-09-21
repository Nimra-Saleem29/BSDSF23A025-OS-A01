# src/Makefile - recursive, builds objects into ../obj and binary into ../bin

CC = gcc
CFLAGS = -Wall -Wextra -g -I../include
SRCS = main.c mystrfunctions.c myfilefunctions.c
OBJDIR = ../obj
BINDIR = ../bin
OBJS = $(SRCS:%.c=$(OBJDIR)/%.o)

.PHONY: all clean

all: $(BINDIR)/client

$(BINDIR)/client: $(OBJS)
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

$(OBJDIR)/%.o: %.c
	mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJDIR)/*.o $(BINDIR)/client
