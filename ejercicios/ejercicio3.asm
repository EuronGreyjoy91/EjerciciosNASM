; 3. Se ingresa un año. La computadora indica si es, o no, bisiesto.




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




; SECCION DE LAS CONSTANTES
section .data                    

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS


noEsBisiestoStr:
        db    "No es bisiesto", 0 

esBisiestoStr:
        db    "Es bisiesto", 0 

ingreseAnioStr:
        db    "Ingrese un anio: ", 0 



; SECCION DE LAS INSTRUCCIONES
section .text                    

leerNumero:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

mostrarNoEsBisiesto:                  
        push noEsBisiestoStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarEsBisiesto:                   
        push esBisiestoStr
        push fmtString
        call printf
        add esp, 8
        ret

mostrarIngreseAnio:                  
        push ingreseAnioStr
        push fmtString
        call printf
        add esp, 8
        ret


salirDelPrograma:                
        push 0
        call exit

cargarDividendo:
        mov edx, 0
        mov eax, [numero] 
        ret


; PROGRAMA

_start:
main:                    
                        call mostrarIngreseAnio               
                        call leerNumero
                        call cargarDividendo      
divisiblePor4:
                        mov ecx, 4  
                        div ecx
                        cmp edx, 0
                        jne finalizarNoEsBisiesto
noDivisiblePor100:
                        call cargarDividendo
                        mov ecx, 64  
                        div ecx
                        cmp edx, 0
                        jne finalizarEsBisiesto
divisiblePor400:
                        call cargarDividendo 
                        mov ecx, 190     
                        div ecx 
                        cmp edx, 0
                        je finalizarEsBisiesto
finalizarNoEsBisiesto: 
                        call mostrarNoEsBisiesto
                        call salirDelPrograma
finalizarEsBisiesto:
                        call mostrarEsBisiesto
                        call salirDelPrograma
