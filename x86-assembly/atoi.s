.include "linux.s"

.global atoi
.type atoi, @function

.text

#******************************************************************
atoi:

#******************************
# ARGS
#
# %esi = string: str
# %edi = length: int
#
# OTHER 
# %ebx = base: int (= 10)
# %ecx = magnitude: int (1, 10, 100...)
# %eax = temporary storage for current number
# %edx = temporary storage for partial sum 
#
# RETURN
# %eax = sum: int
#
#******************************

.equ STRING, 8
.equ STR_LEN, 12

.equ MAGNITUDE, -4
.equ SUM, -8

    pushl %ebp
    movl  %esp, %ebp

    movl  STRING(%esp), %esi
    movl  STR_LEN(%esp), %edi
    
    subl  $8, %esp  # 4 bytes for magnitude and 4 bytes for sum

    movl  $0, SUM(%ebp)
    movl  $1, MAGNITUDE(%ebp)
    movl  $10, %ebx

loop_atoi:
    movl  $0, %eax
    movl  $0, %edx
    decl  %edi

    movb  (%esi, %edi, 1), %al
    subb  $48, %al  # al = al - 48 (convert ascii char to number)
    movl  MAGNITUDE(%ebp), %ecx
    mull  %ecx  # edx:eax = eax * magnitude 

    movl  SUM(%ebp), %edx
    addl  %eax, %edx      # partial sum = partial sum + current number
    movl  %edx, SUM(%ebp)  # store the partial sum on the stack

    movl  %ecx, %eax  # move magnitude to eax and multiply it by 10
    mull  %ebx
    movl  %eax, MAGNITUDE(%ebp) # store magnitude on the stack 
    cmp   $0, %edi
    jne   loop_atoi

end_atoi:
    movl  SUM(%ebp), %eax
    movl  %ebp, %esp
    popl  %ebp
    ret
