; 1. Dado un entero N, la computadora lo muestra descompuesto en sus factores primos. 

; Ej: 132 = 2 × 2 × 3 × 11


global main              
global _start

extern printf            
extern scanf             
extern exit              
extern gets              





section .bss                     ; SECCION DE LAS VARIABLES

contadorExt:
	resd 	1

contadorInt:
	resd 	1

numero:
        resd    1                ; 1 dword (4 bytes)

aux:
        resd    1                ; 1 dword (4 bytes)

matriz:
	resd	100		 ;  matriz como maximo de 10x10

contadorFila:
	resd 	1

contadorColumna:
	resd	1

contadorDesp:
	resd	1

cantidadFilas:
	resd	1		; fila

cantidadColumnas:
	resd	1		; columna

auxDos:
	resd	1		; columna

caracter:
        resb    1                ; 1 byte (dato)
        resb    3                ; 3 bytes (relleno)





section .data                    ; SECCION DE LAS CONSTANTES

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

nStr:
	db    "N: ", 0		 		 ; Cadena "N: "

valorStr:
	db    " - Valor: ", 0		 		 

mStr:
	db    "M: ", 0		 		 ; Cadena "N: "

filaStr:
	db    "Fila:", 0	 		 ;  Cadena "Fila:"

columnaStr:
	db    " Columna:", 0	 	 ;  Cadena "Columna:"

fmtChar:
        db    "%c", 0            ; FORMATO PARA CARACTERES



section .text                    ; SECCION DE LAS INSTRUCCIONES

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

mostrarSaltoDeLinea:             
        push fmtLF
        call printf
        add esp, 4
        ret

mostrarFilaStr:             
        push filaStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarColumnaStr:             
        push columnaStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarValorStr:             
        push valorStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarNStr:             
        push nStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarMStr:             
        push mStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarCaracter:                 ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
        push dword [caracter]
        push fmtChar
        call printf
        add esp, 8
        ret

mostrarEspacio:
        mov eax, 32              ; Copia en EAX el valor 32 (El espacio en ASCII).
        mov [caracter], eax      ; Copia en la direccion de [caracter] el valor de EAX.
        call mostrarCaracter     ; Muestra un Espacio.
        ret

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        push 0
        call exit



_start:
main:                            				
			mov [contadorExt], dword 2
bucleExterno:
			mov edi, [contadorExt]
			mov esi, 100
			cmp edi, esi
			je finalizarPrograma
			mov [contadorInt], dword 2
bucleInterno:
			mov edi, [contadorInt]
			mov esi, [contadorExt]
			cmp edi, esi
			je mostrarPrimo
division:		
			mov edx, 0
			mov eax, [contadorExt]
			mov ecx, [contadorInt]
			div ecx
primerCheck:
			cmp edx, 0
			je noEsPrimo
			inc dword [contadorInt]
			jmp bucleInterno
noEsPrimo:
			inc dword [contadorExt]
			jmp bucleExterno
mostrarPrimo:
			mov al, [contadorExt]
			mov [numero], al
			call mostrarNumero
			call mostrarCaracter
			inc dword [contadorExt]
			jmp bucleExterno
finalizarPrograma:
			call salirDelPrograma
