
%include 'syslib.asm'
%include 'strlib.asm'

    section .data ; initialized memory

entername   db 'Please enter your name: ', 0;
hellow      db 'Hello world!', 0Ah, 0;
hello       db      'hello, ', 0

    section .bss ; uninitialized reserved memory

yourname    resb    512 ; hope you name isn't longer than 512 bytes


    section .text
    default rel
    global  _start
;    extern puts
; Arguments
; rdi   rsi   rdx   r10   r8    r9 
; Return value
; rax   
; char *

_start:
            ;push    rbp             ; create a stack frame to align to 16-bit

; https://cs50.harvard.edu/x/2022/psets/1/mario/less/
; Create a triangle
;        #
;       ##
;      ###
;     ####
;    #####
;   ######
;  #######
; ########

            ;; start of the outer loop
            mov     r10, 8          ; int height = 8
            mov     rcx, 0          ; int i = 0
.nextline:  ; for(int i = 0; i < 8; i++)

            cmp     rcx, r10        ; for (i < height)
            jge     .exitouter      ; i >= height  exit

            ;; start of the first inner loop
            mov     rbx, r10        ; int j = height - i
            sub     rbx, rcx        ; 

.nextspace: ; for(int j = height - i; j > 1; j--)
            
            cmp     rbx, 1          ; for (j > 1)
            jle     .exitspacel            

            ; print a space
            push    ' '             ; push a space on the stack
            mov     rax, rsp        ; put the address to the stack in rax
            mov     rdi, 1          ; int len = 1
            call    lprint          ; print our space character
            pop     rax             ; remove from the stack
            
            dec     rbx             ; j--
            jmp     .nextspace      ; } // endloop
            
.exitspacel:

            ;; start of second inner loop
            mov     rbx, rcx
            inc     rbx             ; int j = i + 1
.nexthash:  ; for(int j = i + 1; j > 0; j--)
;            jmp     .hashcon        ; jump to the hash condition first
            cmp     rbx, 0          ; for (j > 0)
            jle      .exithashl     

            ; print a hash
            push    '#'             ; push a hash on the stack
            mov     rax, rsp        ; put the address to the stack in rax
            mov     rdi, 1          ; int len = 1
            call    lprint          ; print our space character
            pop     rax             ; remove from the stack
            
            dec     rbx             ; j--
            jmp     .nexthash

.exithashl: ; exit hash loop

            push    byte 10         ; newline character
            mov     rax, rsp        ; addr to newline char
            mov     rdi, 1          ; int len = 1
            call    lprint          ; print our newline character
            pop     rax             ; remove from the stack

            inc     rcx             ; i++
            jmp     .nextline       ; // end outer loop

            ; mov     rdi, hellow
            ; call    puts wrt ..plt

.exitouter: 

            ; pop rbp
            ; ret
            ;-- exit --
            mov     rdi, 0          ; exit code
            mov     rax, 60         ; exit syscall
            syscall

section .note.GNU-stack
; gets rid of annoying GCC warning that the stack is executable
