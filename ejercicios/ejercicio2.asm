;2. Se ingresa una cadena. La computadora muestra las subcadenas formadas por las posiciones pares e impares
;de la cadena. Ej: FAISANSACRO : ASNAR FIASCO



global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
global _start

extern printf            ;
extern scanf             ; FUNCIONES DE C (IMPORTADAS)
extern exit              ;
extern gets              



 ; SECCION DE LAS VARIABLES
section .bss                     

cadena:
        resb    0x0100           ; 256 bytes

cadenaPares:
        resb    0x0100           ; 256 bytes

cadenaImpares:
        resb    0x0100           ; 256 bytes




; SECCION DE LAS CONSTANTES
section .data                    

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)


; SECCION DE LAS INSTRUCCIONES
section .text                    

leerCadena:                      ; RUTINA PARA LEER UNA CADENA USANDO GETS
        push cadena
        call gets
        add esp, 4
        ret

mostrarCadenaPares:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push cadenaPares
        push fmtString
        call printf
        add esp, 8
        ret

mostrarCadenaImpares:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push cadenaImpares
        push fmtString
        call printf
        add esp, 8
        ret

mostrarSaltoDeLinea:             ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
        push fmtLF
        call printf
        add esp, 4
        ret

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        push 0
        call exit


; PROGRAMA

_start:
main:                                   ; PUNTO DE INICIO DEL PROGRAMA
        call leerCadena                 ; Cargo la cadena.
        mov edi, 0                      ; Dejo el registro EDI con el valor 0.
        mov ebx, 1                      ; Dejo el registro EBX con el valor 1.
        mov ecx, 0                      ; Dejo el registro ECX con el valor 0.
        mov edx, 0                      ; Dejo el registro EDX con el valor 0.
seguir:
        mov al,[edi + cadena]           ; Copia en AL el valor que esta en la posicion EDI + cadena.
        cmp al, 0                       ; Compara AL con 0.
        je finPrograma                  ; Si AL y 0 eran iguales, salta a fin de programa, sino sigue.
        cmp ebx, 0                      ; Compara EBX con 0.
        je cargarPar                    ; Si EBX era igual a 0, salta a cargarPar, sino sigue en cargarImpar.
cargarImpar:
        mov[ecx + cadenaImpares], al    ; Copia a la direccion de ECX + cadenaImpares, el valor de AL.
        inc ecx                         ; Incremente ECX en 1.
        inc edi                         ; Incrementa EDI en 1.
        mov ebx, 0                      ; Copia en EBX el valor 0.
        jmp seguir                      ; Salta a seguir.
cargarPar:
        mov[edx + cadenaPares], al      ; Copia a la direccion de EDX + cadenaPares, el valor de AL.
        inc edx                         ; Incrementa EDX en 1.
        inc edi                         ; Incrementa EDI en 1.
        mov ebx, 1                      ; Copia en EBX el valor 1.
        jmp seguir                      ; Salto a seguir
finPrograma: 
        call mostrarCadenaPares         ; llamo a mostrar pares
        call mostrarSaltoDeLinea        ; llamo a mostrar saldo de linea
        call mostrarCadenaImpares       ; llamo a mostrar impares.
        jmp salirDelPrograma            ; Salta a finalizar programa.
