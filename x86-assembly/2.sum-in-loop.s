.include "linux.s"

# example:
#
# 703 242 1246 506 29 459 1148 581 752 1282 810 220 756 19 114
# 43 1182 634 61 164 821 29 1188 829 1063 928 841 175 12 1069
# 1091 595 1048 423 1149 785 637
#
# the answer must be: 23634

.global _start
.type itoa, @function
.type atoi, @function


.equ AMMOUNT_LENGTH, 20
.equ INPUT_NUMBER_LENGTH, 20
.equ ANSWER_LENGTH, 20


# BSS

.lcomm ammount_string, AMMOUNT_LENGTH 
.lcomm ammount, 20 
.lcomm input_number_string, INPUT_NUMBER_LENGTH
.lcomm answer_string, ANSWER_LENGTH
.lcomm answer, 20


.data

line_feed: .long 10


.text

_start:

    # read ammount of numbers
    movl  $0, %edi
loop_read_ammount:
    movl  $SYS_READ, %eax
    movl  $STDIN, %ebx
    leal  ammount_string(%edi, 1), %ecx
    movl  $1, %edx    # one character at a time
    int   $LINUX_SYSCALL

    cmpb  $LINE_FEED, ammount_string(%edi, 1)
    je    call_atoi 

    cmpl  $AMMOUNT_LENGTH, %edi
    je    exit

    incl  %edi
    jmp   loop_read_ammount 

call_atoi:
    pushl %edi                  # input_number_string length
    pushl $ammount_string       # pointer to string
    call  atoi
    addl  $8, %esp
    movl  %eax, ammount   # move result of atoi to ammount address

    movl  $0, %esi  # index of numbers

    # initialize the total sum with zero
    movl  $0, answer 

read_numbers:
    movl  $-1, %edi  # index of digits

loop_read_numbers:
    incl  %edi
    movl  $SYS_READ, %eax
    movl  $STDIN, %ebx
    leal  input_number_string(%edi, 1), %ecx
    movl  $1, %edx
    int   $LINUX_SYSCALL

    cmpb  $LINE_FEED, input_number_string(%edi, 1)
    je    call_atoi_2

    cmpb  $SPACE, input_number_string(%edi, 1)
    jne   loop_read_numbers 

call_atoi_2:
    movb  $0, input_number_string(%edi, 1)

    pushl %esi                  # store %esi on the stack before call
    pushl %edi                  # input_number_string length
    pushl $input_number_string  # pointer to string
    call  atoi
    addl  $8, %esp
    popl  %esi                  # retrieve esi from the stack

    # accumulate the result
    movl  answer, %ebx
    addl  %ebx, %eax 
    movl  %eax, answer 

    incl  %esi
    cmpl  %esi, ammount
    jne   read_numbers

    movl  answer, %eax
    pushl $answer_string # answer: pointer
    pushl %eax    # number: int 
    call  itoa
    addl  $8, %esp

    # print
    movl  $STDOUT, %ebx
    movl  $answer_string, %ecx
    movl  $ANSWER_LENGTH, %edx
    movl  $SYS_WRITE, %eax
    int   $LINUX_SYSCALL

    # print_new_line
    movl  $STDOUT, %ebx
    movl  $line_feed, %ecx
    movl  $1, %edx
    movl  $SYS_WRITE, %eax
    int   $LINUX_SYSCALL

exit:
    movl  $1, %eax
    int   $LINUX_SYSCALL



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

.equ ST_NUMBER, 8
.equ ST_ANSWER, 12

    pushl %ebp
    movl  %esp, %ebp
    subl  $20, %esp # space for the temporary reversed string

    movl  ST_NUMBER(%ebp), %eax
    movl  ST_ANSWER(%ebp), %ecx
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
    movl  %ebp, %esp
    popl  %ebp
    ret

