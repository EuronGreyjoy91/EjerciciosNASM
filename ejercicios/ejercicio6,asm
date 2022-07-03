;6. Se ingresa N. La computadora muestra los primeros N términos de la Secuencia de Connell.
; 1 Impar, 2 Pares, 3 Impares, 4 Pares, 5 Impares, etc.


global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
global _start

extern printf            ;
extern scanf             ; FUNCIONES DE C (IMPORTADAS)
extern exit              ;
extern gets              



 ; SECCION DE LAS VARIABLES
section .bss                     

numero:
        resd    1                ; 1 dword (4 bytes)   

counter:
        resd    1

cantCiclos:
        resd    1

auxCantCiclos:
        resd    1

numerosMostrados:
        resd    1

limite:
        resd    1       

caracter:
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

ingreseCantidadStr:
        db    "Ingrese cantidad de numeros: ", 0 

; SECCION DE LAS INSTRUCCIONES
section .text                    

leerNumero:                      
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

mostrarNumero:                   
        push dword [numero]
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarCaracter:                 ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
        push dword [caracter]
        push fmtChar
        call printf
        add esp, 8
        ret

mostrarIngreseCantidad:                   
        push ingreseCantidadStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarEspacio:
        mov eax, 32              ; Copia en EAX el valor 32 (El espacio en ASCII).
        mov [caracter], eax      ; Copia en la direccion de [caracter] el valor de EAX.
        call mostrarCaracter     ; Muestra un Espacio.
        ret

salirDelPrograma:                
        push 0
        call exit


; PROGRAMA

_start:
main:   
                        mov [counter], dword 1
                        mov [cantCiclos], dword 1
                        mov [numerosMostrados], dword 1
cargarCantNumeros:
                        call mostrarIngreseCantidad
                        call leerNumero
                        mov esi, [numero]
                        mov [limite], esi
mostrarUno:
                        mov esi, 1
                        mov [numero], esi
                        call mostrarNumero
                        call mostrarEspacio
checkUno:
                        mov edi, [limite]
                        mov esi, 1
                        cmp edi, esi
                        je finalizarPrograma
prepararCicloPares:
                        inc dword [counter]
                        inc dword [cantCiclos]
                        mov [auxCantCiclos], dword 0
mostrarPares:
                        mov esi, [counter]
                        mov [numero], esi
                        call mostrarNumero
                        call mostrarEspacio
                        inc dword [numerosMostrados]
checkPar:
                        mov edi, [limite]
                        mov esi, [numerosMostrados]
                        cmp edi, esi
                        je finalizarPrograma
                        inc dword [auxCantCiclos]
                        mov edi, [auxCantCiclos]
                        mov esi, [cantCiclos]
                        cmp edi, esi
                        je prepararCicloImpares
                        inc dword [counter]
                        inc dword [counter]
                        jmp mostrarPares
prepararCicloImpares:
                        inc dword [counter]
                        inc dword [cantCiclos]
                        mov [auxCantCiclos], dword 0
mostrarImpares:
                        mov esi, [counter]
                        mov [numero], esi
                        call mostrarNumero
                        call mostrarEspacio
                        inc dword [numerosMostrados]
checkImpar:
                        mov edi, [limite]
                        mov esi, [numerosMostrados]
                        cmp edi, esi
                        je finalizarPrograma
                        inc dword [auxCantCiclos]
                        mov edi, [auxCantCiclos]
                        mov esi, [cantCiclos]
                        cmp edi, esi
                        je prepararCicloPares
                        inc dword [counter]
                        inc dword [counter]
                        jmp mostrarImpares
finalizarPrograma:
                        call salirDelPrograma
