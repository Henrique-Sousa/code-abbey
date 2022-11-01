CFLAGS = -g -Wall
LDFLAGS = -g
CC = gcc

.PHONY: all

all: 2.sum-in-loop.out 3.sums-in-loop.out 4.minimum-of-two.out \
	5.minimum-of-three.out

5.minimum-of-three.out: 5.minimum-of-three.o
	$(CC) $^ -o $@ $(LDFLAGS)

4.minimum-of-two.out: 4.minimum-of-two.o
	$(CC) $^ -o $@ $(LDFLAGS)

3.sums-in-loop.out: 3.sums-in-loop.o
	$(CC) $^ -o $@ $(LDFLAGS)

2.sum-in-loop.out: 2.sum-in-loop.o
	$(CC) $^ -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) -c $^ -o $@ $(CFLAGS)

clean:
	rm -f *.o && rm -f *.out
