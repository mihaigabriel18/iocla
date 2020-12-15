%include "../utils/printf32.asm"

section .bss
    haystack_len: resd 1
    needle_len: resd 1
    index_needle: resd 1
    index_haystack: resd 1


section .data
string_format db "%s", 10, 0
int_format db "%d", 10, 0
char_format db "%c", 10, 0
haystack: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
needle: db "BABC", 0

print_format: db "needle found at index: ", 0

section .text
extern printf
extern strlen
global main

main:
    push ebp
    mov ebp, esp
    pusha

    push DWORD haystack
    call strlen
    add esp, 0x4
    mov [haystack_len], eax

    push DWORD needle
    call strlen
    add esp, 0x4
    mov [needle_len], eax

    xor edx, edx
    mov ecx, 1

haystack_loop:
    cmp ecx, [haystack_len]
    jg end_no_match             ; reached end of hayware, no matches found
    mov [index_haystack], ecx
    mov [index_needle], DWORD 1         ; initialize index in needle with 1 (searching from the start)

needle_loop:
    mov edx, [index_needle]

    cmp edx, [needle_len]
    jg match                            ; reached end of needle, found a match
    mov dl, [needle + edx - 1]             ; copy the char from needle

    cmp ecx, [haystack_len]
    jg end_no_match                     ; we reach the end of haystack but not of needle, so we cannot find any matches further
    mov al, [haystack + ecx - 1]             ; copy the char from haystack

    cmp al, dl
    jz character_matching       ; this character (at least) is matching
    jmp no_match_increase       ; no match yet, increase [index_haystack] to find from next index in heyware

character_matching:     ; increase both indexes to see if they still match next time
    add [index_needle], DWORD 1
    inc ecx
    jmp needle_loop

no_match_increase:                  ; we didn't find a match on this index of big string, so we increase the index
    mov ecx, [index_haystack]
    inc ecx
    jmp haystack_loop

match:
    push ecx
    sub ecx, edx                    ; difference between endpos of matched word from start of hayware - start of needle
    mov edi, ecx

    push print_format
    push string_format
    call printf
    add esp, 8

    push edi
    push int_format
    call printf
    add esp, 8
    
    pop ecx
    jmp haystack_loop

end_no_match:
    mov eax, [haystack_len]
    inc eax
    mov edi, eax

end:

    popa
    leave
    ret
