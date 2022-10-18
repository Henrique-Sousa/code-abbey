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

.equ ST_STRING, 8
.equ ST_STR_LEN, 12

.equ ST_MAGNITUDE, -4
.equ ST_SUM, -8

    pushl %ebp
    movl  %esp, %ebp

    movl  ST_STRING(%esp), %esi
    movl  ST_STR_LEN(%esp), %edi
    
    subl  $8, %esp  # 4 bytes for magnitude and 4 bytes for sum

    movl  $0, ST_SUM(%ebp)
    movl  $1, ST_MAGNITUDE(%ebp)
    movl  $10, %ebx

loop_atoi:
    movl  $0, %eax
    movl  $0, %edx
    decl  %edi

    movb  (%esi, %edi, 1), %al
    subb  $48, %al  # al = al - 48 (convert ascii char to number)
    movl  ST_MAGNITUDE(%ebp), %ecx
    mull  %ecx  # edx:eax = eax * magnitude 

    movl  ST_SUM(%ebp), %edx
    addl  %eax, %edx      # partial sum = partial sum + current number
    movl  %edx, ST_SUM(%ebp)  # store the partial sum on the stack

    movl  %ecx, %eax  # move magnitude to eax and multiply it by 10
    mull  %ebx
    movl  %eax, ST_MAGNITUDE(%ebp) # store magnitude on the stack 
    cmp   $0, %edi
    jne   loop_atoi

end_atoi:
    movl  ST_SUM(%ebp), %eax
    movl  %ebp, %esp
    popl  %ebp
    ret

