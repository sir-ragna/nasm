
%include 'syslib.asm'
%include 'strlib.asm'

    section .data ; initialized memory

entername   db 'Please enter your name: ', 0;
;hellow      db 'Hello world!', 0Ah, 0;
hello       db      'hello, ', 0

    section .bss ; uninitialized reserved memory

yourname    resb    512 ; hope you name isn't longer than 512 bytes


    section .text ; code
    global  _start
;    extern  fgets ; glibc
            ; rdi   char* target 
            ; rsi   int max_len
            ; rdx   stdin

_start:
            
            mov     rax, entername
            call    strlen
            mov     rdi, rax
            mov     rax, entername
            call    lprint

            mov     rdi, yourname      ; arg1 char* target 
            mov     rsi, 512           ; arg2 int max_len
            mov     rdx, 0             ; arg3 stdin
            call    fgets

            mov     rax, hello
            call    strlen
            mov     rdi, rax
            mov     rax, hello
            call    lprint

            mov     rax, yourname
            call    strlen
            mov     rdi, rax
            mov     rax, yourname
            call    lprint

            push    0Ah             ; put byte on stack (decreases rbp by 1)
            mov     rax, rsp        ; put pointer to rax in rbp
            mov     rdi, 1          ; print one byte
            call    lprint
            pop     rax             ; remove byte from stack

            ; -- exit --
            mov     rdi, 0          ; exit code
            mov     rax, 60         ; exit syscall
            syscall
                