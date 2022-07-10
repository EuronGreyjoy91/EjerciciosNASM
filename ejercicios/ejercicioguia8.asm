; 8. Se ingresa una matriz de NxN componentes enteras. La computadora muestra la matriz transpuesta.


global main              
global _start

extern printf            
extern scanf             
extern exit              
extern gets              





section .bss                     ; SECCION DE LAS VARIABLES

numero:
        resd    1                ; 1 dword (4 bytes)

aux:
        resd    1                ; 1 dword (4 bytes)

matriz:
	resd	100		 			 ;  matriz como maximo de 10x10

contadorFila:
	resd 	1

contadorColumna:
	resd	1

contadorDesp:
	resd	1

cantidadFilas:
	resd	1		 			 ; fila

cantidadColumnas:
	resd	1		 			 ; columna

auxDos:
	resd	1		 			 ; columna







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

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        push 0
        call exit



_start:
main:                            				
				mov edi, 0
				mov esi, 0
				mov ebx, 0
				mov [contadorFila], dword 0
				mov [contadorColumna], dword 0
				mov [aux], dword 0
cargarN:
				call mostrarNStr
				call leerNumero
				mov edi, [numero]
				cmp edi, 11
				jg cargarN
				mov [cantidadFilas], edi
				mov [cantidadColumnas], edi
cargarFila:
				mov edi, [contadorFila]
				mov esi, [cantidadFilas]
				cmp edi, esi
				je mostrarTranspuesta
				mov [contadorColumna], dword 0
calculoSalto:
				mov edx, 0
				mov eax, 4
				mov ecx, [cantidadColumnas]
				mul ecx
				mov [auxDos], eax
cargarColumna:
				mov edi, [contadorColumna]
				mov esi, [cantidadColumnas]
				cmp edi, esi
				je filaCompletada
mostrarUbicacion:
				call mostrarFilaStr
				mov edi, [contadorFila]
				mov [numero], edi
				call mostrarNumero
				call mostrarColumnaStr
				mov edi, [contadorColumna]
				mov [numero], edi
				call mostrarNumero
				call mostrarValorStr
				call leerNumero
				mov al, [numero]
				mov [matriz + ebx], al
				add ebx, 4
				inc dword [contadorColumna]
				jmp cargarColumna
filaCompletada:				
				inc dword [contadorFila]
				jmp cargarFila
mostrarTranspuesta:
				mov [contadorFila], dword 0
				mov [contadorColumna], dword 0
mostrarColumna:
				mov edi, [contadorColumna]
				mov esi, [cantidadColumnas]
				cmp edi, esi
				je finalizarPrograma
				mov ebx, [aux]
				mov [contadorFila], dword 0
mostrarFila:
				mov edi, [contadorFila]
				mov esi, [cantidadFilas]
				cmp edi, esi
				je columnaCompletada
				mov al, [matriz + ebx]
				mov [numero], al
				call mostrarNumero
				inc dword [contadorFila]
				add ebx, [auxDos]
				jmp mostrarFila
columnaCompletada:				
				inc dword [contadorColumna]
				call mostrarSaltoDeLinea
				inc dword [aux]
				inc dword [aux]
				inc dword [aux]
				inc dword [aux]
				jmp mostrarColumna
finalizarPrograma:
				call salirDelPrograma
