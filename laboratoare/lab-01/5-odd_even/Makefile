CC=gcc
CFLAGS=-Wall -Wextra -Werror

build: odd_even

odd_even: odd_even.o
	$(CC) $(CFLAGS) $^ -o $@

odd_even.o: odd_even.c
	$(CC) $(CFLAGS) -c $^ -o $@

clean:
	rm *.o odd_even
