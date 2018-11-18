CC=gcc
CFLAGS=-I.
DEPS = include/libfac.h
OBJ = libfac.o 

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: clean

clean:
	rm -f *.o
