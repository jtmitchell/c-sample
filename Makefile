# the compiler: gcc for C program, define as g++ for C++
CC  = gcc

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS   = -g -Wall
# LIBS     = -lm
TESTLIBS = -lcgreen

all: hello reverse test_reverse.so

hello: hello.c
	$(CC) $(CFLAGS) -o $@ $<

# Compile to intermediate .o file for linking with tests
reverse: reverseStr.o reverse.o
	$(CC) $(CFLAGS) $^ -o $@

test_reverse.so: test_reverse.o reverseStr.o
	$(CC) -shared -o $@ $^ $(TESTLIBS)

%.o: %.c
	$(CC) $(CFLAGS) -fPIC -c -o $@ $^

tests: test_reverse.so
	cgreen-runner $^

clean:
	$(RM) hello reverse test_reverse *.o *.so
