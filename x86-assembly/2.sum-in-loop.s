.data

# answer should be: 23634
array:
.long 703, 242, 1246, 506, 29, 459, 1148, 581, 752, 1282, 810, 220, 756, 19, 114, 43, 1182, 634, 61, 164, 821, 29, 1188, 829, 1063, 928, 841, 175, 12, 1069, 1091, 595, 1048, 423, 1149, 785, 637
size:
.long 37

newline:
.long 10

.lcomm answer, 20 

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

# size: int
  pushl %eax
# output: string
  pushl $answer
  call  print
  addl  $8, %esp

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
# answer: pointer (string buffer) - ecx
# OTHER 
# index: int - esi 
# RETURN
# size of answer (string): int
# TODO: verify if the answer is not bigger than the buffer
.type itoa, @function
itoa:
  pushl %ebp
  movl  %esp, %ebp

  movl  $0, %esi
  movl  8(%ebp), %eax
  movl  12(%ebp), %ecx
  movl  $10, %ebx
itoa_loop:
  movl  $0, %edx
  divl  %ebx     # %eax = (%eax / %ebx); %edx = remainder
  addl  $48, %edx
  movl  %edx, (%ecx, %esi, 1)
  incl  %esi
  cmpl  $0, %eax
  jz    end_itoa 
  jmp   itoa_loop
end_itoa:
  movl  %esi, %eax
  popl  %ebp
  ret

# ARGS
# output: pointer (string) - esi
# size: int - edi
# RETURN - none
.type print, @function
print:
  pushl %ebp
  movl  %esp, %ebp

  movl  8(%ebp), %esi
  movl  12(%ebp), %edi
print_loop:
  cmpl  $0, %edi
  jz    print_new_line 
  decl  %edi
  movl  $4, %eax
  leal  (%esi, %edi, 1), %ecx
  movl  $1, %ebx
  movl  $1, %edx
  int   $0x80
  jmp   print_loop
print_new_line:
  movl  $4, %eax
  movl  $newline, %ecx
  movl  $1, %ebx
  movl  $1, %edx
  int   $0x80
end_print:
  popl  %ebp
  ret

