## Feature-2: Multi-file Build with Makefile

### Q1: What does the linking rule `$(TARGET): $(OBJECTS)` mean? 
This rule means that the final executable (TARGET) depends on the object files (OBJECTS).  
If any object file changes, the target is rebuilt.  
In library linking, instead of directly using object files, we link with pre-built libraries using `-l` and `-L`.

### Q2: What is a git tag? Difference between lightweight and annotated tags?
A git tag is a label that marks a specific commit.  
- A **lightweight tag** is just a simple pointer to a commit (like a bookmark).  
- An **annotated tag** is a full git object that stores a tag name, message, author, and date.  
Annotated tags are preferred for versioning.

### Q3: What is the purpose of a GitHub release?
A GitHub release is a formal snapshot of the project at a specific version (tag).  
It includes release notes and optionally pre-built binaries so users can download and run the program without compiling the source.

### Q1. Compare the Makefile from Part 2 and Part 3

**Part 2 (Object build):**  
- The Makefile only compiled `.c` files into `.o` object files.  
- Then it directly linked the `.o` files into a single executable (`bin/myprog`).  
- No library was created.

**Part 3 (Static library build):**  
- The Makefile introduced new rules to combine object files into a static library (`lib/libmyutils.a`) using the `ar` command.  
- The final executable (`bin/client_static`) was built by linking `main.o` against this library using `-Llib -lmyutils`.  
- New variables like `LIB` were added to handle library paths.

👉 **Key Difference:** Part 2 focused on building and linking objects directly, while Part 3 introduced an extra step — packaging object files into a reusable static library and then linking the executable with that library.

### Q2. What is the purpose of the `ar` command? Why is `ranlib` often used immediately after it?

- `ar` (archiver) is used to combine multiple object (`.o`) files into a single archive file (`.a`), which becomes a **static library**.  
- Example:  
  ```bash
  ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o
  
Q3. When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works?

In the object files (.o), functions like mystrlen or mystrcpy appear as defined symbols (T in nm output).

In the archive (libmyutils.a), the same symbols are listed per object file.

In the final executable (client_static), those symbols usually don’t appear, because the linker has already copied their machine code directly into the executable.

Feature 4 – Dynamic Library Build

Q1. What is Position-Independent Code (-fPIC) and why is it a fundamental requirement for creating shared libraries?

-fPIC tells the compiler to generate Position-Independent Code, which can run correctly no matter where in memory it is loaded.

Shared libraries (.so) are loaded at runtime by the OS dynamic loader, and their exact memory address is not known at compile time.

With PIC, all memory references are relative, making it safe to map the .so anywhere in memory.

This is why -fPIC is a fundamental requirement for shared libraries.

2. Explain the difference in file size between your static and dynamic clients. Why does this difference exist?

Static client (client_static) embeds a full copy of all required library functions into the executable. This usually makes the file larger.

Dynamic client (client_dynamic) only contains references to the library. The actual code stays in the .so, which is loaded by the OS at runtime. This usually makes the file smaller.

In our project, both were about 17 KB because:

The library code is very small.

ELF headers and startup code dominate the size.

in larger projects, the static client would be much bigger, while the dynamic client would stay relatively small.

Q3. What is the LD_LIBRARY_PATH environment variable? Why was it necessary to set it for your program to run?

LD_LIBRARY_PATH tells the dynamic loader where to search for shared libraries at runtime.

By default, it only searches system directories like /lib and /usr/lib.

Since our libmyutils.so is in the local ./lib/ directory, the loader could not find it until we extended the search path:export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

