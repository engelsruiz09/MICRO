                            ;LABORATORIO NO.04
;Para los siguientes ejercicios deberá leer números con 2 dígitos pero imprimir su resultado con la cantidad de dígitos correcta, es decir hasta 4 dígitos. 
;1. Escribir un programa en lenguaje ensamblador que lea dos números desde el teclado, haga su multiplicación haciendo sumas sucesivas, utilizando ciclos.
;2. Escribir un programa en lenguaje ensamblador que lea dos números desde el teclado y realice su división por medio de restas sucesivas, utilizando saltos.
;3. Escribir un programa en lenguaje ensamblador que ingresando un número de dos dígitos imprima todos sus factores utilizando saltos. 
;4. Escribir un programa en lenguaje ensamblador que convierta un número de 2 dígitos a su equivalente en binario utilizando ciclos.
;JULIO ANTHONY ENGELS RUIZ COTO 1284719

.MODEL SMALL
.STACK     ;.STACK = DEFINIR LA PILA DE DATOS
.DATA        ;.DATA = LE INDICA AL ENSAMBLADOR QUE DEBE - 
            ;RESERVAR UN ESPACIO DE MEMORIA PARA LAS VARIABLES - 
            ;QUE NOSOTROS DEFINAMOS
;----------------DEClaracion de Variables-----------
MENU  db "              BIENVENIDO AL LABORATORIO 4 MICROPROGRAMACION URL ",13,10
      db "INGRESE LA OPCION A REALIZAR: ",13,10
      db "1. MULTIPLICACION",13,10
      db "2. DIVISION",13,10
      db "3. FACTORES",13,10
      db "4. BINARIO ",13,10
      db "5. SALIR   ",13,10,'$'

LABELERROR db "OPCION INCORRECTA. VUELVA A INTENTARLO NUEVAMENTE. "
ENTRAR DB 0DH, 0AH,"$" ;ODH=CR=RETorno de carro-enter
                       ;OAH=LF=salto de linea
VAR1 DB ?
VAR2 DB ?
VARRESTA DB ?
VARDIVI DB ?
UNIDAD DB ?
DECENA DB ?
RESTO DW 0
COCIENTE DW 0
RESIDUO  DB 8 dup (' '),'$'
FACTORES DB 100,?, 100 dup('$')
 
MSJO3 DB "SELECCIONASTE LA OPCION 1 (MULTIPLICACION):","$"
MSJO4 DB "SELECCIONASTE LA OPCION 2 (DIVISION):","$"
MSJ05 DB "SELECCIONASTE LA OPCION 3 (FACTORES):","$"
MSJ06 DB "SELECCIONASTE LA OPCION 4 (BINARIO):","$"
;-------------------------------------------------   

RES3 DB "LA RESPUESTA DE LA OPERACION MULTIPLICACION ES: ","$"
RES4 DB "LA RESPUESTA DE LA OPERACION DIVISION ES - COCIENTE: ","$"
RES41 DB "LA RESPUESTA DE LA OPERACION DIVISION ES - RESIDUO: ","$"
RES5 DB "LA RESPUESTA DE LA OPERACION FACTORES ES: ","$"
RES6 DB "LA RESPUESTA DE LA OPERACION BINARIO ES: ","$"
;---------------------------------------------------
MSGE1 DB "INGRESE SU PRIMER VALOR: ","$"
MSGE2 DB "INGRESE SU SEGUNDO VALOR: ","$"
;---------------------------------------------------
ADIOS DB "ADIOS GRACIAS POR USAR MI PROGRAMA ;)" ,"$"
ERROR DB "CARACTER INVALIDO","$"
VERIFICACION DB "DESEA CONTINUAR CON EL PROGRAMA? : PRESIONE (1) - CONTINUAR | (2) - SALIR " , "$"
.CODE
MAIN  PROC FAR
MOV AX, @data;SE OBTIENE LA DIRECCION DE INICIO DEL SEGMENTO DE DATOS
MOV DS, AX ; SE ASIGNA AL REGISTRO DATA SEGMENT LA DIRECCION DE INICIO DEL SEGMENTO DE DATOS

;CALL BORRAR_TEXPAN
;------------------INICIO-----------------------------
CALL INICIO


;--------------------FIN-----------------------------
SALIDA:
  CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET ADIOS
  MOV AH, 09H
  INT 21H

  MOV AH, 4CH
  INT 21H
MAIN ENDP
;----------------------------------------------------
INICIO PROC
  CALL BORRAR_TEXPAN     
  CALL ENSE_MENU 
  CALL SELECCION_EJERCICIO
  RET
INICIO ENDP

 ;PROCEDIMIENTO PARA FUNCION_SALTOLINEA UN RENGLON EN LA PANTALLA
FUNCION_SALTOLINEA PROC NEAR
	MOV DX,OFFSET ENTRAR 
	MOV AH, 09H
	INT 21H
	RET
FUNCION_SALTOLINEA	ENDP

;PROCEDIMIENTO DE LECTURA DE VALORES DE 2 DIGITO
VAL_UNDIGITO PROC 
  MOV DX,OFFSET MSGE1
  MOV AH,09H
  INT 21H 
    
  MOV AH,01H;LEE EL CARÁCTER DE LA ENTRADA ESTÁNDAR, CON ECO, EL RESULTADO SE ALMACENA EN AL.SI NO HAY NINGÚN CARÁCTER EN EL BÚFER DEL TECLADO, LA FUNCIÓN ESPERA HASTA QUE SE PRESIONE CUALQUIER TECLA.
	INT 21h
	SUB AL,30H
	MOV BL,10
	MUL BL
	ADD VAR1,AL
	
	MOV AH,01H
	INT 21h                     
	SUB AL,30H
	ADD VAR1,AL

	CALL FUNCION_SALTOLINEA
  RET
VAL_UNDIGITO ENDP


VAL_DOSDIGITO PROC 
	MOV DX,OFFSET MSGE1 
	MOV AH,09H;SALIDA DE UNA CADENA EN DS:DX. LA CADENA DEBE TERMINAR CON'$'.
	INT 21h

	MOV AH,01H
	INT 21h
	SUB AL,30H
	MOV BL,10
	MUL BL
	ADD VAR1,AL
	
	MOV AH,01H
	INT 21h                     
	SUB AL,30H
	ADD VAR1,AL

	CALL FUNCION_SALTOLINEA

	MOV DX,OFFSET MSGE2
	MOV AH,09H
	INT 21h

	MOV AH,01H
	INT 21h
	SUB AL,30H
	MOV BL,10
	MUL BL
	ADD VAR2,AL
	
	MOV AH,01H
	INT 21h
	SUB AL,30H
	ADD VAR2,AL

	CALL FUNCION_SALTOLINEA
	RET
VAL_DOSDIGITO ENDP

SELECCION_EJERCICIO PROC
;------ESPERA ALGUNA TECLA--------------------------- 
;01/30H LEE EL CARÁCTER DE LA ENTRADA ESTÁNDAR, CON ECO, EL RESULTADO SE ALMACENA EN AL.SI NO HAY NINGÚN CARÁCTER EN EL BÚFER DEL TECLADO, LA FUNCIÓN ESPERA HASTA QUE SE PRESIONE CUALQUIER TECLA. 
  MOV AH,07H
  INT 21H
  SUB AL,30H
  CMP AL,1
  JE EJERCICIO_UNO
  CMP AL,2
  JE EJERCICIO_DOS
  CMP AL,3
  JE OTRO_SALTO_A_EJERCICIOTRES
  CMP AL,4
  JE OTRO_SALTO_A_EJERCICIOCUATRO
  CMP AL,5
  JE ETIQUETA_DE_SALTO_HACIA_SALIDA
  JMP ETIQUETA_ERROR

ETIQUETA_ERROR:
  MOV DX,OFFSET LABELERROR 
  MOV AH,09h
  INT 21H
  JMP INICIO
  RET
SELECCION_EJERCICIO ENDP

EJERCICIO_UNO PROC
  CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET MSJO3
  MOV AH,09H    
  INT 21H
  CALL FUNCION_SALTOLINEA
  CALL VAL_DOSDIGITO
  XOR AX,AX ; HACEMOS UNA LIMPIEZA DEL REGISTRO AX
  XOR BX,BX
  XOR CX,CX
  XOR DX,DX
  
  ;-----------------A * B ------------------------------
  MOV CL,VAR2
  SUMA:
  MOV AL,VAR1 
  ADD COCIENTE,AX
  LOOP SUMA
   
  CALL FUNCION_SALTOLINEA
   
  MOV DX,OFFSET RES3
  MOV AH,09H 
  INT 21H
  
  MOV AX,COCIENTE
  CALL PRINT
  MOV VAR1,0
  MOV VAR2,0
  MOV COCIENTE,0

  CALL FUNCION_SALTOLINEA
  CALL VERIFICACION_DE_SEGUIMIENTO
  RET
EJERCICIO_UNO ENDP
OTRO_SALTO_A_EJERCICIOTRES:
JMP ETIQUETA_DE_SALTO_HACIA_EJERCICIOTRES     
OTRO_SALTO_A_EJERCICIOCUATRO:
JMP ETIQUETA_DE_SALTO_HACIA_EJERCICIOCUATRO
ETIQUETA_DE_SALTO_HACIA_SALIDA: 
  JMP SALIDA 
EJERCICIO_DOS PROC
  XOR AX,AX ; HACEMOS UNA LIMPIEZA DEL REGISTRO AX
  XOR BX,BX
  XOR CX,CX
  XOR DX,DX
  CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET MSJO4
  MOV AH,09H    
  INT 21H
  CALL FUNCION_SALTOLINEA
  CALL VAL_DOSDIGITO
  XOR AX,AX ; HACEMOS UNA LIMPIEZA DEL REGISTRO AX
  MOV CX,1
  ;-----------------A % B ------------------------------
  MOV AL,VAR1
  RESTA:
  MOV COCIENTE,AX
  SUB AL,VAR2
  CMP AL,VAR2
  JB RESUL
  INC CX
  JMP RESTA
  
  RESUL:
  MOV COCIENTE,CX
  MOV RESTO,AX
  
  CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET RES4
  MOV AH,09H 
  INT 21H 
  MOV AX,COCIENTE
  CALL PRINT
                  
  CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET RES41
  MOV AH,09H 
  INT 21H
  
  MOV AX,0
  MOV BX,0
  MOV CX,0
  MOV DX,0
  
  MOV AX,RESTO  
  CALL PRINT
  
  MOV VAR1,0
  MOV VAR2,0
  MOV COCIENTE,0
  MOV RESTO,0
  
  CALL FUNCION_SALTOLINEA
  CALL VERIFICACION_DE_SEGUIMIENTO
  RET
EJERCICIO_DOS ENDP
ETIQUETA_DE_SALTO_HACIA_EJERCICIOTRES: 
  JMP EJERCICIO_TRES  
    
EJERCICIO_TRES PROC
CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET MSJ05
  MOV AH,09H    
  INT 21H
  CALL FUNCION_SALTOLINEA
  
  CALL VAL_UNDIGITO
  XOR AX,AX ; HACEMOS UNA LIMPIEZA DEL REGISTRO AX
  XOR DX,DX
  MOV BX,1
  MOV CX,99
  MOV SI,0
  
CALCULA_FACTORES:
  MOV AL,VAR1
  DIV BL
  CMP AH,0
  JNE SALTA
 
  MOV FACTORES[SI],BL
  
  INC BL
  INC SI
  MOV AH,0
  LOOP CALCULA_FACTORES
  JMP SALIR_CICLO
  
  SALTA:
  INC BL
  MOV AH,0
  LOOP CALCULA_FACTORES
  
  SALIR_CICLO:
  CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET RES5
  MOV AH,09H 
  INT 21H
  
  ;CALL FUNCION_SALTOLINEA
 
  MOV SI,0
  MOV AX,0
  IMPRIME_FACTORES:
  MOV AL,FACTORES[SI]
  CMP AL,09H
  JA AJUSTAR
  MOV DL,AL
  ADD DL,30H
  MOV AH,2
  INT 21H
  MOV DL,"-"
  INT 21H
  INC SI
  CMP FACTORES[SI],"$"
  JE SALIR_FACTORES
  MOV AX,0
  JMP IMPRIME_FACTORES
  
  AJUSTAR:
  MOV AH,0
  AAM
  MOV BX,AX
  ADD BH,30H
  ADD BL,30H
  MOV AH,2
  MOV DL,BH
  INT 21H
  MOV DL,BL
  INT 21H
  MOV DL,"-"
  INT 21H
  INC SI
  CMP FACTORES[SI],"$"
  JNE IMPRIME_FACTORES
  
  
  SALIR_FACTORES:
  
  MOV VAR1,0
  MOV VAR2,0
  MOV COCIENTE,0
  CALL FUNCION_SALTOLINEA
  CALL VERIFICACION_DE_SEGUIMIENTO
  
  RET
EJERCICIO_TRES ENDP
ETIQUETA_DE_SALTO_HACIA_EJERCICIOCUATRO: 
  JMP EJERCICIO_CUATRO  

EJERCICIO_CUATRO PROC
 CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET MSJ06
  MOV AH,09H    
  INT 21H
  CALL FUNCION_SALTOLINEA
  CALL VAL_UNDIGITO
  XOR AX,AX ; HACEMOS UNA LIMPIEZA DEL REGISTRO AX
  XOR BX,BX
  XOR CX,CX
  XOR DX,DX
  
  MOV Al,VAR1
  MOV COCIENTE,AX
  MOV CX,8
  MOV DI,7
  
  Convertir_A_Binario:        
     MOV AX,0
     MOV AX,COCIENTE
     MOV BX,2
     MOV DX,0
     DIV BX
     ADD dl,30h
     MOV RESIDUO[di],dl
     MOV COCIENTE,AX
     DEC di
    LOOP Convertir_A_Binario
  CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET RES6
  MOV AH,09H
  INT 21H
  ;CALL FUNCION_SALTOLINEA
  MOV DX,OFFSET RESIDUO
  MOV AH,09H
  INT 21H
  MOV VAR1,0
  MOV VAR2,0
  MOV COCIENTE,0
  CALL FUNCION_SALTOLINEA
  CALL VERIFICACION_DE_SEGUIMIENTO

  RET
EJERCICIO_CUATRO ENDP

ETIQUETA_DE_SALTO_HACIA_INICIO: 
  JMP INICIO
ETIQUETA_DE_SALTO_HACIA_INICIO1:
  JMP ETIQUETA_DE_SALTO_HACIA_INICIO
ETIQUETA_DE_SALTO_HACIA_SALIDA1:
  JMP ETIQUETA_DE_SALTO_HACIA_SALIDA

ENSE_MENU PROC
  MOV DX, OFFSET MENU
  MOV AH, 09H; PETICION PARA DESPLEGAR
  INT 21H; LLAMA AL DOS
  RET
ENSE_MENU ENDP

BORRAR_TEXPAN PROC
;INT 10H / AH = 0 - COLOCA EL MODO DE VIDEO.
;INPUT:
;AL = MODO DE VIDEO DESEADO.
;ESTOS MODOS DE VIDEO SON COMPATIBLES:
;00H - MODO TEXTO. 40X25. 16 COLORES. 8 PÁGINAS.
  MOV AH, 00H
  MOV AL, 3
  INT 10H
  RET
BORRAR_TEXPAN ENDP

VERIFICACION_DE_SEGUIMIENTO PROC
  MOV DX, OFFSET VERIFICACION
  MOV AH,09H 
  INT 21H 
  CALL FUNCION_SALTOLINEA
  ;------ESPERA ALGUNA TECLA--------------------------- 
;01/30H LEE EL CARÁCTER DE LA ENTRADA ESTÁNDAR, CON ECO, EL RESULTADO SE ALMACENA EN AL.SI NO HAY NINGÚN CARÁCTER EN EL BÚFER DEL TECLADO, LA FUNCIÓN ESPERA HASTA QUE SE PRESIONE CUALQUIER TECLA. 
  MOV AH,01H
  INT 21H
  SUB AL,30H
  CMP AL,1
  JE ETIQUETA_DE_SALTO_HACIA_INICIO1
  CMP AL,2
  JE ETIQUETA_DE_SALTO_HACIA_SALIDA1
  JMP ETIQUETA_ERROR
  RET
VERIFICACION_DE_SEGUIMIENTO ENDP

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
		JE exit
		POP DX ;POP LA PARTE SUPERIOR DE LA PILA	
		ADD DX,48 ;ADD 48 PARA QUE ;REPRESENTA EL VALOR ASCII ;DE LOS DÍGITOS
		MOV AH,02h  ;INTERRUPCIÓN PARA IMPRIMIR UN CARÁCTER
		INT 21h 
		DEC CX ;DECREMENTARR EL CONTEO
		JMP prINT1 
exit: 
RET 
PRINT ENDP 
END MAIN