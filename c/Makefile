CFLAGS = -g --pedantic -std=c89
LDFLAGS = -g
CC = gcc

2.sum-in-loop.out: 2.sum-in-loop.o
	$(CC) $^ -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) -c $^ -o $@ $(CFLAGS)

clean:
	rm -f *.o && rm -f *.out
