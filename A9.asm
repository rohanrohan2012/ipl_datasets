%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro read 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

section .data
rmsg db "ENTER THE NUMBER :"
rmsglen equ $-rmsg

fmsg db "THE FACTORIAL OF NUMBER IS :"
fmsglen equ $-fmsg

newline db 0xA
x db "x"

cant db 00H

section .bss
num resq 10
res resb 10

section .text
	global _start
_start:

	pop rbx
	pop rbx
	pop rbx
	mov ax,01
	mov cl,byte[rbx]
	sub cx,30h

	call FACTORIAL
	call HEXTOASC

	
	mov rax,60
	mov rdi,0
	syscall

FACTORIAL:
	cmp rcx,01h
	je jump1
	mul rcx

	dec rcx

	call FACTORIAL

jump1:
	ret

HEXTOASC:
    mov rsi,res
    mov byte[cant],16H
label1:
    rol rax,4
    mov bl,al
    and bl,0Fh
    cmp bl,09h
    jbe label2
    add bl,07h
label2:
    add bl,30h
    mov byte[rsi],bl
    inc rsi
    dec byte[cant]
    jnz label1
    print fmsg,fmsglen
    print res,16
    ret


