2.sum-in-loop.out: 2.sum-in-loop.o
	ld $^ -o $@

%.o: %.s
	as $^ -o $@

clean:
	rm -f *.o && rm -f *.out

