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

.equ STDIN, 0
.equ STDOUT, 1
.equ READ, 3
.equ WRITE, 4

.equ LINE_FEED, 0x0A
.equ SPACE, 0x20

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
    movl  $READ, %eax
    movl  $STDIN, %ebx
    leal  ammount_string(%edi, 1), %ecx
    movl  $1, %edx    # one character at a time
    int   $0x80

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
    movl  $READ, %eax
    movl  $STDIN, %ebx
    leal  input_number_string(%edi, 1), %ecx
    movl  $1, %edx
    int   $0x80

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
    movl  $WRITE, %eax
    int   $0x80

    # print_new_line
    movl  $STDOUT, %ebx
    movl  $line_feed, %ecx
    movl  $1, %edx
    movl  $WRITE, %eax
    int   $0x80

exit:
    movl  $1, %eax
    int   $0x80



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
# %ecx, -4(%ebp) = magnitude: int (1, 10, 100...)
# %eax = temporary storage for current number
# %edx = temporary storage for partial sum 
#
# RETURN
# %eax, -8(%ebp) = sum: int
#
#******************************

    pushl %ebp
    movl  %esp, %ebp

    movl  8(%esp), %esi # string
    movl  12(%esp), %edi # string length
    

    movl  $1, -4(%ebp) # store magnitude on the stack 
    movl  $10, %ebx

    subl  $8, %esp
    movl  $0, -8(%ebp)

loop_atoi:
    movl  $0, %eax
    movl  $0, %edx
    decl  %edi

    movb  (%esi, %edi, 1), %al
    subb  $48, %al  # al = al - 48 (convert ascii char to number)
    movl  -4(%ebp), %ecx  # move magnitude to ecx
    mull  %ecx  # edx:eax = eax * magnitude 

    movl  -8(%ebp), %edx  # move partial sum to edx
    addl  %eax, %edx      # partial sum = partial sum + current number
    movl  %edx, -8(%ebp)  # store the partial sum on the stack

    movl  %ecx, %eax  # move magnitude to eax and multiply it by 10
    mull  %ebx
    movl  %eax, -4(%ebp) # store magnitude on the stack 
    cmp   $0, %edi
    jne   loop_atoi

end_atoi:
    movl  -8(%ebp), %eax  # move sum to eax
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
    movl  %ebp, %esp
    popl  %ebp
    ret

