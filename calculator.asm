section .data
    prompt db "Enter an operator (+, -, *, /): ", 0
    error db "Invalid operator!", 0
    result db "Result: ", 0

section .bss
    num1 resd 1
    num2 resd 1
    operator resb 1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 26
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, operator
    mov edx, 1
    int 0x80
    
    cmp byte [operator], '+'
    je addition
    cmp byte [operator], '-'
    je subtraction
    cmp byte [operator], '*'
    je multiplication
    cmp byte [operator], '/'
    je division
    jmp invalid_operator
    
addition:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 20
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 21
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80
    
    fld dword [num1]
    fadd dword [num2]
    jmp display_result
    
subtraction:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 20
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 21
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80
    
    fld dword [num1]
    fsub dword [num2]
    jmp display_result
    
multiplication:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 20
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 21
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80
    
    fld dword [num1]
    fmul dword [num2]
    jmp display_result
    
division:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 19
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 18
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80
    
    fld dword [num1]
    fdiv dword [num2]
    jmp display_result

display_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 8
    int 0x80
    
    fld st0
    sub esp, 12
    fstp qword [esp]
    push dword format
    push esp
    call printf
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

invalid_operator:
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, 17
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .data
    format db "%f", 10, 0
