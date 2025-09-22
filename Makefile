# --- dynamic library / client_dynamic rules ---
.PHONY: clean
DYNAMIC_LIB = lib/libmyutils.so
DYNAMIC_CLIENT = bin/client_dynamic

# Create dynamic library from object files (exclude main.o)
$(DYNAMIC_LIB): obj/mystrfunctions.o obj/myfilefunctions.o
	$(CC) -shared -o $(DYNAMIC_LIB) obj/mystrfunctions.o obj/myfilefunctions.o

# Build dynamic client
$(DYNAMIC_CLIENT): obj/main.o $(DYNAMIC_LIB)
	$(CC) obj/main.o -Llib -lmyutils -o $(DYNAMIC_CLIENT)

# Top-level dynamic target
dynamic: $(DYNAMIC_LIB) $(DYNAMIC_CLIENT)

# Run dynamic client
run-dynamic: dynamic
	LD_LIBRARY_PATH=lib ./$(DYNAMIC_CLIENT)
install:
	mkdir -p /usr/local/bin
	mkdir -p /usr/local/share/man/man1
	cp bin/client_dynamic /usr/local/bin/client
	cp man/man1/client.1 /usr/local/share/man/man1/
	chmod 755 /usr/local/bin/client
	chmod 644 /usr/local/share/man/man1/client.1
clean:
	rm -f obj/*.o bin/* lib/*.a lib/*.so
