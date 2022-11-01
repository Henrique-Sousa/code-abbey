CFLAGS = -g
LDFLAGS = -g
CC = gcc

all: 3.sums-in-loop.out 2.sum-in-loop.out

3.sums-in-loop.out: 3.sums-in-loop.o
	$(CC) $^ -o $@ $(LDFLAGS)

2.sum-in-loop.out: 2.sum-in-loop.o
	$(CC) $^ -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) -c $^ -o $@ $(CFLAGS)

clean:
	rm -f *.o && rm -f *.out
