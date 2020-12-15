%include "../utils/printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    string_format db "%s", 10, 0
    int_format db "%d", 10, 0
    char_format db "%c", 10, 0

    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

section .text
extern printf
extern strcpy
extern strdup
global main

get_int:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp + 8]
    lea ebx, [ebx + int_x]
    mov eax, [ebx]
    
    pop ebx
    leave
    ret

get_char:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp + 8]
    lea ebx, [ebx + char_y]
    mov eax, [ebx]
    
    pop ebx
    leave
    ret

get_string:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp + 8]
    lea ebx, [ebx + string_s]
    mov eax, ebx
    
    pop ebx
    leave
    ret

set_int:
    push ebp
    mov ebp, esp
    push ebx
    push ecx

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    lea ebx, [ebx + int_x]
    mov [ebx], ecx
    
    pop ecx
    pop ebx
    leave
    ret

set_char:
    push ebp
    mov ebp, esp
    push ebx
    push ecx

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    lea ebx, [ebx + char_y]
    mov [ebx], ecx
    
    pop ecx
    pop ebx
    leave
    ret

set_string:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push eax

    mov ebx, [ebp + 8]
    push dword [ebp + 12]

    lea ecx, [ebx + string_s]
    push ecx
    call strcpy
    add esp, 8

    
    pop eax
    pop ecx
    pop ebx
    leave
    ret

main:
    push ebp
    mov ebp, esp

    mov edx, [new_int]
    push edx
    push sample_obj
    call set_int
    add esp, 8

    push sample_obj
    call get_int
    add esp, 4

    ;uncomment when get_int is ready
    push eax
    push int_format
    call printf
    add esp, 8

    movzx edx, byte [new_char]
    ; movzx is the same as
    ; xor edx, edx
    ; mov dl, byte [new_char]
    push edx
    push sample_obj
    call set_char
    add esp, 8

    push sample_obj
    call get_char
    add esp, 4

    ;uncomment when get_char is ready
    push eax
    push char_format
    call printf
    add esp, 8

    mov edx, new_string
    push edx
    push sample_obj
    call set_string
    add esp, 8

    push sample_obj
    call get_string
    add esp, 4

    ;uncomment when get_string is ready
    push eax
    push string_format
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret
