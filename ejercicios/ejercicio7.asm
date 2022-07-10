; 7. Se ingresa una matriz de NxM componentes. La computadora la muestra girada 90° en sentido antihorario.


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
				mov [auxDos], dword 0
cargarN:
				call mostrarNStr
				call leerNumero
				mov edi, [numero]
				cmp edi, 11
				jg cargarN
				mov [cantidadFilas], edi
cargarM:
				call mostrarMStr
				call leerNumero
				mov edi, [numero]
				cmp edi, 11
				jg cargarM
				mov [cantidadColumnas], edi
				add edi, -1
				mov [aux], edi
calculoSalto:
				mov edx, 0
				mov eax, 4
				mov ecx, [cantidadColumnas]
				mul ecx
				mov [auxDos], eax
cargarFila:
				mov edi, [contadorFila]
				mov esi, [cantidadFilas]
				cmp edi, esi
				je mostrarGirada
				mov [contadorColumna], dword 0
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
mostrarGirada:
				mov [contadorFila], dword 0
				mov [contadorColumna], dword 0
mostrarColumna:
				mov edi, [contadorColumna]
				mov esi, [cantidadColumnas]
				cmp edi, esi
				je finalizarPrograma
				mov ebx, 0
				mov [contadorDesp], dword 0
				mov [contadorFila], dword 0
calcularDesp:
				mov edi, [contadorDesp]
				mov esi, [aux]
				cmp edi, esi
				je mostrarFila
				inc dword [contadorDesp]
				add ebx, 4
				jmp calcularDesp
mostrarFila:
				mov edi, [contadorFila]
				mov esi, [cantidadFilas]
				cmp edi, esi
				je columnaCompletada
				mov al, [matriz + ebx]
				mov [numero], al
				call mostrarNumero
				inc dword [contadorFila]
				mov esi, [auxDos]
				add ebx, esi
				jmp mostrarFila
columnaCompletada:				
				inc dword [contadorColumna]
				mov edi, [aux]
				add edi, -1
				mov [aux], edi
				call mostrarSaltoDeLinea
				jmp mostrarColumna
finalizarPrograma:
				call salirDelPrograma
