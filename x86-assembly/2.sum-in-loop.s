.equ  STDIN,  0
.equ  STDOUT, 1

.equ  WRITE,  4

.data

line_feed:
.long 10

# answer should be: 23634
array:
.long 703, 242, 1246, 506, 29, 459, 1148, 581, 752, 1282, 810, 220, 756, 19, 114, 43, 1182, 634, 61, 164, 821, 29, 1188, 829, 1063, 928, 841, 175, 12, 1069, 1091, 595, 1048, 423, 1149, 785, 637
size:
.long 37

.equ  ANSWER_SIZE,  20
.lcomm  answer,  ANSWER_SIZE

.text

.global _start
_start:


# amount of numbers: int
  pushl size
# array: pointer
  pushl $array
  call  array_sum
  addl  $8, %esp
  
# answer: pointer
  pushl $answer
# number: int 
  pushl %eax
  call  itoa
  addl  $8, %esp

print:
  movl  $STDOUT, %ebx
  movl  $answer, %ecx
  movl  $ANSWER_SIZE, %edx
  movl  $WRITE, %eax
  int   $0x80

print_new_line:
  movl  $STDOUT, %ebx
  movl  $line_feed, %ecx
  movl  $1, %edx
  movl  $WRITE, %eax
  int   $0x80

exit:
  movl  $1, %eax
  int   $0x80


# ARGS
# array: pointer - ebx
# size: int - ecx
# OTHER 
# array index: int - edi
# RETURN
# sum: int - eax
.type array_sum, @function
array_sum:
  pushl %ebp
  movl  %esp, %ebp

  movl  $0, %edi
  movl  $0, %eax
  movl  8(%ebp), %ebx
  movl  12(%ebp), %ecx

array_sum_loop:
  cmpl  %edi, %ecx 
  je    end_array_sum
  addl  (%ebx, %edi, 4), %eax
  incl  %edi
  jmp   array_sum_loop 

end_array_sum:
  popl %ebp
  ret


# ARGS
# number: int - eax
# answer: pointer (string buffer) where the result will be stored - ecx
# OTHER 
# index: int - esi 
# TODO: verify if the answer is not bigger than the buffer
.type itoa, @function
itoa:
  pushl %ebp
  movl  %esp, %ebp
  subl  $20, %esp # space for the temporary reversed string

  movl  8(%ebp), %eax
  movl  12(%ebp), %ecx
  movl  $10, %ebx

  movl  $0, %esi

itoa_loop:
  movl  $0, %edx
  divl  %ebx     # %eax = (%eax / %ebx); %edx = remainder
  addl  $48, %edx
  movb  %dl, (%esp, %esi, 1)
  incl  %esi
  cmpl  $0, %eax
  jz    reverse 
  jmp   itoa_loop

reverse:
  movl  $0, %edi

reverse_loop:
  decl  %esi
  movb  (%esp, %esi, 1), %bl
  movb  %bl, (%ecx, %edi, 1)
  incl  %edi
  cmpl  $0, %esi
  jne   reverse_loop

end_itoa:
  movl  $0, 1(%ecx, %edi, 1)

  movl  %ebp, %esp
  popl  %ebp
  ret

