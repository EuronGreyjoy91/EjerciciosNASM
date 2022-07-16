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
        call leerCadena                 
        mov edi, 0                      
        mov ebx, 1                      
        mov ecx, 0                      
        mov edx, 0                      
seguir:
        mov al,[edi + cadena]          
        cmp al, 0                       
        je finPrograma                  
        cmp ebx, 0                      
        je cargarPar                    
cargarImpar:
        mov[ecx + cadenaImpares], al    
        inc ecx                         
        inc edi                         
        mov ebx, 0                      
        jmp seguir                      
cargarPar:
        mov[edx + cadenaPares], al      
        inc edx                         
        inc edi                         
        mov ebx, 1                      
        jmp seguir                      
finPrograma: 
        call mostrarCadenaPares         
        call mostrarSaltoDeLinea        
        call mostrarCadenaImpares       
        jmp salirDelPrograma            
