
; Arguments
; rdi   rsi   rdx   r10   r8    r9 
; Return value
; rax   


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
            inc     rax             ; increment *str addr
            jmp     .loop
.exit:      
            mov     rax, rcx        ; put the counter result in return register
            pop     rcx
            ret