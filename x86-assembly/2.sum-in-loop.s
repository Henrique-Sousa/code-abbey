.section .data

array:
.long 10,20,30,40,5,6,7,8

size:
.long 7

.section .text

.global _start
_start:
  movl  $0, %edi
  movl  array(,%edi,4), %ebx

start_loop:
  cmpl  %edi, size
  je    loop_exit
  incl  %edi
  addl  array(,%edi,4), %ebx
  jmp   start_loop

loop_exit:
  movl  $1, %eax 
  int   $0x80
