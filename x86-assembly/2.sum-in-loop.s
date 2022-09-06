.data

# answer should be: 23632
array:
.long 701, 242, 1246, 506, 29, 459, 1148, 581, 752, 1282, 810, 220, 756, 19, 114, 43, 1182, 634, 61, 164, 821, 29, 1188, 829, 1063, 928, 841, 175, 12, 1069, 1091, 595, 1048, 423, 1149, 785, 637
size:
.long 37

.bss
.lcomm answer, 20 

.equ NEWLINE, 10

.text

.global _start
_start:
  movl  $0, %edi
  movl  $0, %eax

sum:
  cmpl  %edi, size
  je    itoa_prep  
  addl  array(,%edi,4), %eax
  incl  %edi
  jmp   sum
  
itoa_prep:
  xorl %esi, %esi
itoa:
  movl $0, %edx
  movl $10, %ebx
  divl %ebx
  addl $48, %edx
  movl %edx, answer(,%esi,1)
  incl %esi
  cmpl $0, %eax
  jz   print 
  jmp  itoa 

print:
  cmpl $0, %esi
  jz   print_new_line 
  decl %esi
  movl $4, %eax
  leal answer(,%esi,1), %ecx
  movl $1, %ebx
  movl $1, %edx
  int  $0x80
  jmp  print 

print_new_line:
  movl $4, %eax
  pushl $NEWLINE 
  movl %esp, %ecx 
  movl $1, %ebx
  movl $1, %edx
  int  $0x80

exit:
  movl $1, %eax
  int  $0x80

