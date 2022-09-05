
; Arguments
; rax   rdi   rsi   rdx   r10   r8    r9 


;------------------------------------------
; int slen(string)
; string length calculation function
; arg1(rax) str_addr
; return(rax) length
strlen:         
            push    rcx             ; use as counter   

            mov     rcx, 0          ; set our counter to zero
.loop:
            cmp     byte [rax], 0   ; If we have a null byte, exit
            je      .exit           ;
            inc     rcx             ; increment our counter
            inc     rax
            jmp     .loop
.exit:      
            mov     rax, rcx
            pop     rcx
            ret