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
