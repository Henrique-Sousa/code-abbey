.include "linux.s"

.global itoa
.type itoa, @function

.text

#******************************************************************
itoa:

#******************************
# ARGS
#
# number: int - eax
# answer: pointer (string buffer) where the result will be stored - ecx
#
# OTHER 
# index: int - esi 
#
# TODO: verify if the answer is not bigger than the buffer
#******************************

.equ NUMBER, 8
.equ ANSWER, 12

    pushl %ebp
    movl  %esp, %ebp
    subl  $20, %esp # space for the temporary reversed string

    movl  NUMBER(%ebp), %eax
    movl  ANSWER(%ebp), %ecx
    movl  $10, %ebx

    movl  $0, %esi

itoa_loop:
    movl  $0, %edx
    divl  %ebx     # %eax = (%eax / %ebx); %edx = remainder
    addl  $48, %edx
    movb  %dl, (%esp, %esi)
    incl  %esi
    cmpl  $0, %eax
    jz    reverse 
    jmp   itoa_loop

reverse:
    movl  $0, %edi

reverse_loop:
    decl  %esi
    movb  (%esp, %esi), %bl
    movb  %bl, (%ecx, %edi)
    incl  %edi
    cmpl  $0, %esi
    jne   reverse_loop

end_itoa:
    movl  %ebp, %esp
    popl  %ebp
    ret
