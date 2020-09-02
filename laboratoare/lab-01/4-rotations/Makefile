CC=gcc
CFLAGS=-Wall -Wextra -Werror

build: rotations

rotations: rotations.o
	$(CC) $(CFLAGS) $^ -o $@

rotations.o: rotations.c
	$(CC) $(CFLAGS) -c $^ -o $@

clean:
	rm *.o rotations
