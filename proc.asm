.model small 					
.data							
	cadena1 DB 20 DUP(24h),'$' ; $ final de la cadena nos sirve para saber si hemos llegado al final

.stack							
.code 							
programa:						
		MOV AX, @DATA      		
		MOV DS, AX
		
		;llamadas principales
		;1 vincular la cadena con el indice
		LEA SI, cadena1
		;2 Leer caracter por caracter 
		;3 Verificar si ha llegado al final (enter)
		CALL GuardarCadena
		;4 imprimir
		CALL ImprimirCadena
		;5 JMP finalizar
		JMP finalizar
		
;------------------------Procedimientos -----------------------------------------

	; 2
	LeerCaracter PROC NEAR
		XOR AX, AX
		MOV AH, 01H
		INT 21H
	RET
	LeerCaracter ENDP
	
	;3
	GuardarCadena PROC NEAR
		LeerC:
			CMP AL,0DH ; si fue enter
			JE TerminarLectura
			CALL LeerCaracter ; luego de la lectura queda en AL
			MOV [SI], AL
			INC SI
			JMP LeerC
		TerminarLectura:
			RET
	RET
	GuardarCadena ENDP
	
	;4
	ImprimirCadena PROC NEAR
		XOR DX, DX
		MOV AH, 02H
		MOV DL, 0AH
		INT 21h
		XOR DX, DX
		MOV DX, offset Cadena1
		MOV AH, 09h
		INT 21h
	RET
	ImprimirCadena ENDP
	
		
		Finalizar:

		MOV AH, 4Ch				
		INT 21h					
		
END programa					