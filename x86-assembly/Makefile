2.sum-in-loop.out: 2.sum-in-loop.o
	ld -g -m elf_i386 $^ -o $@

%.o: %.s
	as -g --32 $^ -o $@

clean:
	rm -f *.o && rm -f *.out

