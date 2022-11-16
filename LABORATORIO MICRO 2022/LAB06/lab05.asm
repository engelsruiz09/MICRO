                            ;LABORATORIO NO.05
;Deberá crear un programa en lenguaje ensamblador que reciba una cadena de 
;caracteres que contenga una expresión aritmética con sumas y restas, esta expresión cumplirá las siguientes normas:
;• Cada número será representado en 2 dígitos, es decir, 10, 01,06 45, etc. .
;• Posterior a los 2 dígitos solo podrá recibir el signo “+” o “-“ indicando suma o resta respectivamente. 
;Luego de leer la expresión deberá calcular su resultado y mostrarlo al usuario. 
;Nota: deberá incluir procedimientos para esta práctica
;JULIO ANTHONY ENGELS RUIZ COTO 1284719

.MODEL SMALL
.DATA
    MENU  DB "              BIENVENIDO AL LABORATORIO 5 MICROPROGRAMACION URL ","$"
    EXPLI DB "INGRESE DOS NUMERO DE DOS DIGITOS LUEGO PRESIONE ENTER Y LUEGO LA OPERACION","$"
    CADENA1 DW 20 DUP(24h),'$' ;$
    MSG1 DB 10,13,10,13,"INGRESA SUMA(+) O RESTA (-):  ","$"
    OPERADOR_ARITMETICO DB 0 
    ENTRAR DB 0DH, 0AH,"$" ;ODH=CR=RETorno de carro-enter
                       ;OAH=LF=salto de linea
.STACK
.CODE
PROGRAMA:
;3-CARACTER DE FINALIZACIO (ENTER)
;4-LEER CARACTER POR CARACTER 
;2-IMPRIMIR LA CADENA  
;1-VINCULAR CADENA 1 CON APUNTADOR 
  MOV AX,@DATA  
  MOV DS,AX  
  MOV DX, OFFSET MENU
  MOV AH, 09H; PETICION PARA DESPLEGAR
  INT 21H; LLAMA AL DOS
  CALL FUNCION_SALTOLINEA
  MOV DX, OFFSET EXPLI
  MOV AH, 09H; PETICION PARA DESPLEGAR
  INT 21H; LLAMA AL DOS
  CALL FUNCION_SALTOLINEA
  ;1- LLAMADAS PRINCIPALES 
  ;VINCULAR LA CADENA CON EL INDICE
  LEA SI, CADENA1
  ;2- LEER CARACTER POR CARACTER 
  ;3-VERIFICAR SI HA LLEGADO AL FINAL (ENTER)
  CALL GUARDAR_CADENA
  ;4- IMPRIMIR
  CALL IMPRIMIR_CADENA
  ;5 - JMP FINALIZAR 
  JMP FINALIZAR

;-------------------PROCEDIMIENTOS----------------------------------------------------------------
  ;2
  LEER_CARACTER PROC NEAR
  XOR AX,AX
  MOV AH, 01H 
  INT 21H
  
  CMP AL,0DH ;SI FUE UN ENTER
  JZ TERMINAR_LECTURA
    
  SUB AL,30H
  MOV AH,0
  MOV BX,10
  MUL BX
  MOV [SI],AL
  
  XOR AX,AX
  MOV AH, 01H 
  INT 21H
  SUB AL,30H
  ADD [SI],AL 
  
  MOV AH,2
  MOV DL,','
  INT 21H  
  RET 
  LEER_CARACTER ENDP 
  
  GUARDAR_CADENA PROC NEAR 
    LEERC:
     
      CALL LEER_CARACTER ;LUEGO LA LECTURA QUEDA EN AL 
      
      ADD SI,2 
      JMP LEERC
    TERMINAR_LECTURA:
      CALL OPERADOR

  RET
  GUARDAR_CADENA ENDP

  ;4
  IMPRIMIR_CADENA PROC NEAR 
  XOR AX,AX
  MOV AH,02H 
  MOV DL,0AH  ;SALTO DE LINEA 
  INT 21H 
  XOR DX,DX  
  MOV DX,OFFSET CADENA1 
  MOV AH,09H 
  INT 21H 
  RET
  IMPRIMIR_CADENA ENDP 


  OPERADOR PROC NEAR
  
  MOV DX,OFFSET MSG1
  MOV AH,9
  INT 21H
  
  MOV AH,1
  INT 21H
  MOV OPERADOR_ARITMETICO,AL
      
  XOR AX,AX
  MOV SI,0
  
  CMP OPERADOR_ARITMETICO,"+"
  JNE RESTAR
  
  SUMAR:
  ADD AX,CADENA1[SI]
  INC SI
  MOV BX,CADENA1[SI]
  CMP BH,24H
  JE IMPRIME_RESULTADO
  INC SI
  JMP SUMAR   
     
  RESTAR:
  MOV AX,CADENA1[SI]
  ADD SI,2
  RESTA:
  SUB AX,CADENA1[SI]
  INC SI
  MOV BX,CADENA1[SI]
  CMP BH,24H
  JE IMPRIME_RESULTADO
  INC SI
  JMP RESTA
  
  IMPRIME_RESULTADO:
  
  CMP AX,0
  JL AJUSTE
  CALL PRINT
  JMP FINALIZAR
  
  AJUSTE:
  NOT AX
  ADD AX,1
  CALL PRINT
   
  OPERADOR ENDP

PRINT PROC		 	
	MOV CX,0 ;INICIAR CONTEO
	MOV DX,0 
	label1: 
		CMP AX,0; SI AX ES CERO 
		JE prINT1	 	
		MOV BX,10; INICIALIZAR BX A 10 
		DIV BX; EXTRAE EL ULTIMO DIGITO				 	
		push DX;EMPUJARLO EN LA PILA 		 
		INC CX;INCREMENTAR EL CONTEO
		XOR DX,DX ;ESTABLECER DX A 0 
		JMP label1 
	prINT1: 
		CMP CX,0;VERIFICAR SI CUENTA ;ES MAYOR QUE CERO
		JE FINALIZAR
		POP DX ;POP LA PARTE SUPERIOR DE LA PILA	
		ADD DX,48 ;ADD 48 PARA QUE ;REPRESENTA EL VALOR ASCII ;DE LOS DÍGITOS
		MOV AH,02h  ;INTERRUPCIÓN PARA IMPRIMIR UN CARÁCTER
		INT 21h 
		DEC CX ;DECREMENTARR EL CONTEO
		JMP prINT1 
exit: 
RET 
PRINT ENDP 
 ;PROCEDIMIENTO PARA FUNCION_SALTOLINEA UN RENGLON EN LA PANTALLA
FUNCION_SALTOLINEA PROC NEAR
	MOV DX,OFFSET ENTRAR 
	MOV AH, 09H
	INT 21H
	RET
FUNCION_SALTOLINEA	ENDP

FINALIZAR:
 MOV AH,4CH 
 INT 21H 

END PROGRAMA 