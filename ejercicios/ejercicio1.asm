; 1. Dado un entero N, la computadora lo muestra descompuesto en sus factores primos. 

; Ej: 132 = 2 × 2 × 3 × 11


global main              
global _start

extern printf            
extern scanf             
extern exit              
extern gets              





section .bss                     

valor:
	resd 	1

numeroPrimo:
	resd 	1

proximoValor:
	resd 	1

contadorInt:
	resd 	1

numero:
        resd    1               





section .data                    

fmtInt:
        db    "%d", 0            

fmtString:
        db    "%s", 0            

fmtLF:
        db    0xA, 0            

ingreseStr:
	db    "Ingrese un numero: ", 0	 	

xStr:
	db    " x ", 0	 	 

igualStr:
	db    " = ", 0	 	 





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

mostrarSaltoDeLinea:             
        push fmtLF
        call printf
        add esp, 4
        ret

mostrarIngreseStr:             
        push ingreseStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarXStr:             
        push xStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarIgualStr:             
        push igualStr
        push fmtString
        call printf
        add esp, 8
        ret

salirDelPrograma:                
        push 0
        call exit




_start:
main:                            				
			mov [numeroPrimo], dword 2
cargarValor:
			call mostrarIngreseStr
			call leerNumero
			mov eax, [numero]
			mov [valor], eax 
			mov [proximoValor], eax
			call mostrarSaltoDeLinea
mostrarInicio:
			call mostrarNumero
			call mostrarIgualStr
chequeoUno:
			mov edi, [valor]
			cmp edi, 1
			jne divisionPorPrimo
			mov al, 1
			mov [numero], al
			call mostrarNumero
			jmp finalizarPrograma
divisionPorPrimo:
			mov edx, 0
			mov eax, [valor] 	
			mov ecx, [numeroPrimo] 
			div ecx
			mov [proximoValor], eax 
			cmp eax, 1 
			je posibleFinal
			cmp edx, 0
			je mostrarValor
			mov [contadorInt], dword 2 
			inc dword [numeroPrimo]
			jmp bucleInterno
posibleFinal:
			cmp edx, 0
			je mostrarUltimoValor
			mov [contadorInt], dword 2 
			inc dword [numeroPrimo]
			jmp bucleInterno
mostrarValor:
			mov eax, [proximoValor]
			mov [valor], eax
			mov eax, [numeroPrimo] 
			mov [numero], eax 
			call mostrarNumero
			call mostrarXStr 
			jmp divisionPorPrimo
bucleInterno:
			mov edi, [contadorInt]
			mov esi, [numeroPrimo]
			cmp edi, esi
			je divisionPorPrimo
division:		
			mov edx, 0
			mov eax, [numeroPrimo]
			mov ecx, [contadorInt]
			div ecx
primerCheck:
			cmp edx, 0
			je noEsPrimo
			inc dword [contadorInt]
			jmp bucleInterno
noEsPrimo:
			inc dword [numeroPrimo]
			mov [contadorInt], dword 2
			jmp bucleInterno
mostrarUltimoValor:
			mov al, [numeroPrimo]
			mov [numero], al
			call mostrarNumero
finalizarPrograma:
			call salirDelPrograma
