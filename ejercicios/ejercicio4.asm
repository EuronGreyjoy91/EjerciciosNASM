; 4. Se ingresan un entero N y, a continuación, N números enteros. La computadora muestra el promedio de los
; números impares ingresados y la suma de los pares.




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

valores:
        resd    100              ; 100 lugares de 4 bytes                                

cantImpares:
        resd    1                 

sumaImpares:
        resd    1  

sumaPares:
        resd    1                                        

; SECCION DE LAS CONSTANTES
section .data                    

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)


ingreseTotalStr:
        db    "Total de numeros: ", 0 

ingreseNumeroStr:
        db    "Ingrese un numero: ", 0 

sumaParesStr:
        db    "Suma pares: ", 0 

promedioImparesStr:
        db    "Promedio impares: ", 0 

esImparStr:
        db    "Es impar", 0

esParStr:
        db    "Es par", 0


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

mostrarIngreseTotal:                   
        push ingreseTotalStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarIngreseNumero:                   
        push ingreseNumeroStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarSumaPares:                   
        push sumaParesStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarPromedioImpares:                   
        push promedioImparesStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarSaltoDeLinea:             
        push fmtLF
        call printf
        add esp, 4
        ret


salirDelPrograma:                
        push 0
        call exit


; PROGRAMA

_start:
main:                     
                        mov edi, 0
                        mov [cantImpares], dword 0
                        mov [sumaImpares], dword 0
                        mov [sumaPares], dword 0
cargarLimite:              
                        call mostrarIngreseTotal
                        call leerNumero
                        mov esi, [numero]
cargarNumeros:  
                        cmp edi, esi
                        je finalizarPrograma
                        call mostrarIngreseNumero
                        call leerNumero
                        mov al, [numero]
                        test al, 1
                        jnz esImpar
esPar:
                        mov ebx, [sumaPares]
                        add ebx, [numero]
                        mov [sumaPares], ebx 
                        inc edi
                        jmp cargarNumeros
esImpar:
                        mov ebx, [sumaImpares]
                        add ebx, [numero]
                        mov [sumaImpares], ebx 
                        inc edi
                        inc dword [cantImpares]
                        jmp cargarNumeros    
finalizarPrograma:
finalPares:
                        call mostrarSumaPares
                        mov al, [sumaPares]
                        mov [numero], al
                        call mostrarNumero
                        call mostrarSaltoDeLinea
finalImpares:
                        call mostrarPromedioImpares
                        mov edx, 0
                        mov eax, [sumaImpares]
                        mov ecx, [cantImpares]
                        cmp ecx, 0
                        jne dividir
                        mov ecx, 1  
dividir:
                        div ecx 
                        mov [numero], eax
                        call mostrarNumero
                        call mostrarSaltoDeLinea
                        call salirDelPrograma
