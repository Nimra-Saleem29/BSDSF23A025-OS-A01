# --- dynamic library / client_dynamic rules ---
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
