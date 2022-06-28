;5. Se ingresan 100 caracteres. La computadora los muestra ordenados sin repeticiones


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

counter:
        resd    1

counterExterno:
        resd    1

counterInterno:
        resd    1  

limite:
        resd    1                                        

limiteFinal:
        resd    1                                        

caracteres:
        resd    100              ; Reservo espacio para 100 caracteres

caracter:
        resb    1                ; 1 byte (dato)
        resb    3                ; 3 bytes (relleno)

aux:
        resb    1                ; 1 byte (dato)
        resb    3                ; 3 bytes (relleno)



; SECCION DE LAS CONSTANTES
section .data                    

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtChar:
        db    "%c", 0            ; FORMATO PARA CARACTERES

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

ingreseCaracterStr:
        db    "Ingrese un caracter: ", 0 

; SECCION DE LAS INSTRUCCIONES
section .text                    

leerCadena:                      ; RUTINA PARA LEER UNA CADENA USANDO GETS
        push cadena
        call gets
        add esp, 4
        ret

mostrarSaltoDeLinea:             ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
        push fmtLF
        call printf
        add esp, 4
        ret

mostrarCaracter:                 ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
        push dword [caracter]
        push fmtChar
        call printf
        add esp, 8
        ret

mostrarIngreseCaracter:                   
        push ingreseCaracterStr
        push fmtString
        call printf
        add esp, 8
        ret

salirDelPrograma:                
        push 0
        call exit


; PROGRAMA

_start:
main:   
                mov [limiteFinal], dword 0  
                mov [limite], dword 100  
                mov [counterExterno], dword 0
cargarCaracteres:
                mov edi, [counterExterno]
                mov esi, [limite]
                cmp edi, esi                            
                je resetUno
                call mostrarIngreseCaracter                             
                call leerCadena                         
                mov ebx, 0
                mov [counterInterno], dword 0 
checkCaracter:  
                mov edi, [counterInterno]
                mov esi, [limiteFinal]
                cmp edi, esi
                je cargarCaracter
                mov edi, [caracteres + ebx]
                mov esi, [cadena]
                cmp edi, esi
                je cargarProximo
                inc dword [counterInterno]
                add ebx, 4
                jmp checkCaracter
cargarProximo:
                inc dword [counterExterno]
                jmp cargarCaracteres
cargarCaracter:
                mov al, [cadena]
                mov [caracteres + ebx], al                                          
                inc dword [counterExterno]
                inc dword [limiteFinal]
                jmp cargarCaracteres
resetUno:
                mov [counterExterno], dword 0           
                mov ebx, 0                              
bucleExterno:
                mov edi, [counterExterno]                      
                mov esi, [limiteFinal]
                cmp edi, esi
                je resetDos
                inc dword [counterExterno]
                mov [counterInterno], dword 1
                mov ebx, 0
bucleInterno:
                mov edi, [counterInterno]                      
                mov esi, [limiteFinal]
                cmp edi, esi
                je bucleExterno
checkChars:
                mov edi, [ebx + caracteres]
                mov esi, [ebx + caracteres + 4]
                cmp edi, esi
                jg reemplazarChar
                add ebx, 4
                inc dword [counterInterno]
                jmp bucleInterno
reemplazarChar:
                mov [aux], edi
                mov edi, esi
                mov esi, [aux]
                mov [ebx + caracteres], edi
                mov [ebx + caracteres + 4], esi
                add ebx, 4
                inc dword [counterInterno]
                jmp bucleInterno
resetDos:
                mov edi, 0
                mov esi, [limiteFinal]                              
                mov ebx, 0
mostrar:
                cmp edi, esi                            
                je finalizarPrograma
                mov al, [caracteres + ebx]
                mov [caracter], al
                call mostrarCaracter
                add ebx, 4
                inc edi
                jmp mostrar
finalizarPrograma:
                call salirDelPrograma
