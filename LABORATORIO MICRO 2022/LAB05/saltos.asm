.MODEL small
.DATA 
	Num1 DB ?
	Num2 DB ?
	resultado1 DB 'Los numeros son iguales$'
	resultado2 DB 'El primero numero es el mayor$'
	resultado3 DB 'El segundo numero es el mayor$'
	resultado4 DB 'El resultado de la multiplicacion es $'
.STACK
.CODE
programa:


	MOV AX,@DATA  ; se obtiene la direcci'on de inicio del segmento de datos
    MOV DS, AX   ; asignamos al registro data segment la direccion de inicio de segmento
	
	; Limpiar AX
	XOR AX, AX
	;leer
	leer:
	MOV AH, 01h
	INT 21h
	SUB AL, 30h
	MOV Num1, AL
	; leer num2
	XOR AX, AX
	MOV AH, 01h
	INT 21h
	SUB AL, 30h
	MOV num2, AL
	
	; comparaciones
	; No se puede comparar memoria vs memoria
	XOR AX, AX
	MOV AL, num1
	CMP Al, num2
	JE EsIgual
	JS EsMenor
	;JMP EsMayor
	
	; Resultados
	EsMayor:
	MOV DX, offset resultado2
	MOV AH, 09h
	INT 21h
	JMP multiplicacionCiclos
	
	EsMenor:
	MOV DX, offset resultado3
	MOV ah, 09h
	INT 21h
	JMP multiplicacionCiclos
	
	EsIgual:
	MOV DX, offset resultado1
	MOV ah, 09h
	INT 21h
	
	; ----------------------------- multiplicacion con ciclos -----------------------
	multiplicacionCiclos:
	; Ciclos
	; limpiar registros
	XOR CX, CX
	XOR BX, BX
	
	;Siempre empezar por la parte baja de los registros
	; asignamos valores
	MOV CL, num1
	MOV BL, num2   ; podria eliminarse esta linea
	DEC CL         ; o decrementarse el ciclo en 1
	; operaciones dentro del ciclo
	multiplicar:
	; codigo para hacer las sumas sucesivas
    ; BL nuestro total
	ADD BL, num2
	Loop multiplicar ; loop siempre al final de la etiqueta
	
	; imprimir multiplicacion
	MOV DX, offset resultado4
	MOV AH, 09h
	INT 21h
	; imprimir el resultado
	XOR DX, DX
	MOV DL, BL
	ADD DL, 30h
	MOV AH, 02h
	INT 21h
	
	  
	Finalizar:
    mov ah, 4ch
    int 21h
           
END programa