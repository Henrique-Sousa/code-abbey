.include "linux.s"

.global _start


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
    leal  ammount_string(%edi), %ecx
    movl  $1, %edx    # one character at a time
    int   $LINUX_SYSCALL

    cmpb  $LINE_FEED, ammount_string(%edi)
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
    leal  input_number_string(%edi), %ecx
    movl  $1, %edx
    int   $LINUX_SYSCALL

    cmpb  $LINE_FEED, input_number_string(%edi)
    je    call_atoi_2

    cmpb  $SPACE, input_number_string(%edi)
    jne   loop_read_numbers 

call_atoi_2:
    movb  $0, input_number_string(%edi)

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
