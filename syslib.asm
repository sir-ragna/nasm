
; 
; SYSCALL
;
;  Arch/ABI    Instruction           System  Ret  Ret  Error    Notes
;                                    call #  val  val2
;  -------------------------------------------------------------------
;  i386        int $0x80             eax     eax  edx  -
;  x86-64      syscall               rax     rax  rdx  -        5
;  x32         syscall               rax     rax  rdx  -        5

; ARGUMENTS
;
; Arch/ABI      arg1  arg2  arg3  arg4  arg5  arg6  arg7  Notes         
; --------------------------------------------------------------            
; i386          ebx   ecx   edx   esi   edi   ebp   -           
; x86-64        rdi   rsi   rdx   r10   r8    r9    -           
; x32           rdi   rsi   rdx   r10   r8    r9    -           
;
; FROM man syscall(2)

; Exit with error code

; lprint - write to stdout
; rax char *str
; rdi int len
lprint:     
            push    rsi
            push    rdi
            push    rdx
            push    rcx
            push    r10

            mov     rdx, rdi        ; len
            mov     rsi, rax        ; char* str
            mov     rdi, 1          ; stdout
            mov     rax, 1          ; sys_write
            syscall

            pop     r10
            pop     rcx
            pop     rdx
            pop     rdi
            pop     rsi
            ret

; fgets
; Read data until enter
; arg1      rdi     char* target 
; arg2      rsi     int max_len
; arg3      rdx     stdin
fgets:      push    rdi             ; save registers on the stack
            push    rsi
            push    rdx
            push    r10
            push    rcx
            push    rax
            
            mov     rcx, rsi        ; maximum amount of bytes we can read
            mov     rsi, rdi        ; buffer to read to char* buffer

.nextchar:
            ; read 1 character
            mov     rax, 0          ; sys_read
            mov     rdi, 0          ; stdin
            mov     rdx, 1          ; 1 byte
            push    rcx
            syscall                 ; read one byte from stdin into char *rsi
            pop     rcx ; restore rcx from syscall clobbering

            dec     rcx             ; decrement max_bytes_counter
            
            ; If the character is a newline, exit
            ; If we read the maximum amount of characters exit
            ; else loop
            
            mov     byte al, [rsi]
            cmp     al, 0Ah       ; did we receive an enter(newline)?
            je      .exit

            cmp     rcx, 0          ; did we read 512 bytes?
            je     .exit            ; jump greater or equal than
            
            inc     rsi             ; increment buffer pointer
            jmp     .nextchar

.exit:      
            mov     [rsi], byte 0        ; zero out the last byte, should be '\n'

            pop     rax
            pop     rcx
            pop     r10             ; restore registers from the stack
            pop     rdx
            pop     rsi
            pop     rdi
            ret

