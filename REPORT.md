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
