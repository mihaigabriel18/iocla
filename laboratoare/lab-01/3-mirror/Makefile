CC=gcc
CFLAGS=-Wall -Wextra -Werror

build: mirror

mirror: mirror.o
	$(CC) $(CFLAGS) $^ -o $@

mirror.o: mirror.c
	$(CC) $(CFLAGS) -c $^ -o $@

clean:
	rm *.o mirror
