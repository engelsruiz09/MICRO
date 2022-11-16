.model Small
.stack
.data
	num1 db ?  ; cuando no tenemos un valor inicial para la variable asignamos ?
	texto1 db '   El numero que se ha obtenido desde el teclado es:   $'			;parte del resultado

	
.code

programa:

	Mov AX,@Data				;Mueve la direccion de inicio del segmento de datos al Acumulador
	Mov DS, AX					;Mueve la direccion de inicio del segmento de datos al DS
	
	mov ah,01h					;comando para leer caracter desde el teclado
	int 21h						;lee primer caracter
	
	sub al, 30h					;resto 30H (48Dec) para obtener el numero real
	mov num1,al					;lo guardo en variable num1
	
	
	; lo imprimimos para confirmar
	MOV DX, offset texto1
	MOV ah, 9h
	int 21h
	
	MOV dL, num1
	add dL, 30h
	Mov ah, 02h
	int 21h
	
	; finalizar el programa
	
	MOV AH, 4ch
	INT 21h
	
end programa