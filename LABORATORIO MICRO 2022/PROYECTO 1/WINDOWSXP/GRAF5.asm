;Universidad Rafael Landivar
;Arquitectura del Computador Ciclo I 2022
;Ing. Luis Pedro Alonzo
;Este programa dibuja 2 mapas de bits, alternando estos según las teclas a y d.


.MODEL SMALL
.STACK
.DATA


MARIO 	DB	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,
		DB	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,
		DB	00,	00,	00,	00,	00,	00,	04,	04,	04,	04,	04,	00,	00,	12,	12,	12,	00,	00,
		DB	00,	00,	00,	00,	00,	04,	04,	04,	04,	04,	04,	04,	04,	04,	12,	12,	00,	00,
		DB	00,	00,	00,	00,	00,	06,	06,	06,	12,	12,	07,	12,	15,	04,	04,	04,	00,	00,
		DB	00,	00,	00,	00,	06,	12,	06,	12,	12,	12,	07,	12,	12,	12,	04,	04,	00,	00,
		DB	00,	00,	00,	00,	06,	12,	06,	06,	12,	12,	12,	07,	12,	12,	12,	04,	00,	00,
		DB	00,	00,	00,	00,	06,	06,	12,	12,	12,	12,	07,	07,	07,	07,	04,	00,	00,	00,
		DB	00,	00,	00,	00,	00,	00,	12,	12,	12,	12,	12,	12,	12,	04,	04,	00,	00,	00,
		DB	00,	12,	12,	04,	04,	04,	04,	01,	04,	04,	04,	01,	04,	04,	00,	00,	06,	00,
		DB	00,	12,	12,	04,	04,	04,	04,	04,	01,	04,	04,	04,	01,	00,	00,	06,	06,	00,
		DB	00,	00,	12,	12,	04,	04,	04,	04,	01,	01,	01,	01,		01,	01,	06,	06,	00,
		DB	00,	00,	00,	00,	00,	01,	01,	01,	01,		01,	01,	01,	01,	01,	06,	06,	00,
		DB	00,	00,	00,	06,	06,	01,	01,	01,	01,	01,	01,	01,	01,	01,	01,	06,	06,	00,
		DB	00,	00,	06,	06,	06,	01,	01,	01,	01,	01,	01,	00,	00,	00,	00,	00,	00,	00,
		DB	00,	00,	06,	06,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,
		DB	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,


MARIO2 DB	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,
DB	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,
DB	00,	00,	00,	00,	00,	00,	02,	02,	02,	02,	02,	00,	00,	12,	12,	12,	00,	00,
DB	00,	00,	00,	00,	00,	02,	02,	02,	02,	02,	02,	02,	02,	02,	12,	12,	00,	00,
DB	00,	00,	00,	00,	00,	06,	06,	06,	12,	12,	07,	12,	15,	02,	02,	02,	00,	00,
DB	00,	00,	00,	00,	06,	12,	06,	12,	12,	12,	07,	12,	12,	12,	02,	02,	00,	00,
DB	00,	00,	00,	00,	06,	12,	06,	06,	12,	12,	12,	07,	12,	12,	12,	02,	00,	00,
DB	00,	00,	00,	00,	06,	06,	12,	12,	12,	12,	07,	07,	07,	07,	02,	00,	00,	00,
DB	00,	00,	00,	00,	00,	00,	12,	12,	12,	12,	12,	12,	12,	02,	02,	00,	00,	00,
DB	00,	12,	12,	02,	02,	02,	02,	01,	02,	02,	02,	01,	02,	02,	00,	00,	06,	00,
DB	00,	12,	12,	02,	02,	02,	02,	02,	01,	02,	02,	02,	01,	00,	00,	06,	06,	00,
DB	00,	00,	12,	12,	02,	02,	02,	02,	01,	01,	01,	01,		01,	01,	06,	06,	00,
DB	00,	00,	00,	00,	00,	01,	01,	01,	01,		01,	01,	01,	01,	01,	06,	06,	00,
DB	00,	00,	00,	06,	06,	01,	01,	01,	01,	01,	01,	01,	01,	01,	01,	06,	06,	00,
DB	00,	00,	06,	06,	06,	01,	01,	01,	01,	01,	01,	00,	00,	00,	00,	00,	00,	00,
DB	00,	00,	06,	06,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,
DB	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,	00,


ASCII_A		DB  97
ASCII_S		DB  115
ASCII_D		DB  100


X2			DW		0
Y2			DW		0
VAR1		DB		0
XORIG		DW		33500

VIDEO_SEG 	SEGMENT AT 0A000H
VID_AREA	DB		1000 DUP (?)
VIDEO_SEG 	ENDS


.CODE

DIBUJAR1	PROC
		MOV		AX, XORIG
		MOV		X2, AX				
		XOR		SI, SI
		XOR		BX, BX
CICLO:		
		MOV		AH, MARIO[SI]			
		MOV		ES:BYTE PTR[DI], AH		
		INC		SI						 
		INC 	DI
		INC		BL						
		CMP		BL, 19				; No. de Columnas + 1
		JB		CICLO
		XOR		BL, BL
		ADD		X2,320
		MOV		DI, X2
		INC		BH
		CMP		BH, 16			;No. de Filas - 1
		JB		CICLO	
		RET
DIBUJAR1 ENDP

DIBUJAR2	PROC
		MOV		AX, XORIG
		MOV		X2, AX				
		XOR		SI, SI
		XOR		BX, BX
CICLO2:		
		MOV		AH, MARIO2[SI]			
		MOV		ES:BYTE PTR[DI], AH		
		INC		SI						 
		INC 	DI
		INC		BL						
		CMP		BL, 19				; No. de Columnas + 1
		JB		CICLO2
		XOR		BL, BL
		ADD		X2,320
		MOV		DI, X2
		INC		BH
		CMP		BH, 16			;No. de Filas - 1
		JB		CICLO2	
		RET
DIBUJAR2 ENDP

;PROCEDIMIENTO QUE LIMPIA LA PANTALLA
LIMPIAR	PROC NEAR
	MOV AX, 0600H	; peticion de recorrido de pantalla
	MOV BH, 00	; color 
	MOV CX, 0000	; de 00,00
	MOV DX, 184FH	; A 24, 79
	INT 10H
	RET
LIMPIAR	ENDP
;------------------------------------------------------------------------------

;PROCEDIMIENTO QUE GENERA UN DELAY 
DELAY PROC NEAR
MOV AH, 86H
	MOV CX, 1
	MOV DX, 65000
	INT 15H
RET
DELAY ENDP

; ------------------- Programa principal --------------------
MAIN PROC
	.STARTUP
	MOV     AX,@DATA		; INICIAR REGISTROS DE SEGMENTO
    MOV     DS, AX

	MOV		AX, VIDEO_SEG
	MOV 	ES, AX
	ASSUME	ES:VIDEO_SEG
	
	AND BX, 00	
	MOV SI, 00
	MOV		AX, 0013H		; Modo de video
	INT		10H	

REPETIR:
	CALL LIMPIAR
	MOV AL, VAR1
	AND AL, AL
	JZ DIBUJO2
	JMP DIBUJO1
	
	DIBUJO1:
		CALL DIBUJAR1
		JMP CONTINUAR
		
	DIBUJO2:
		CALL DIBUJAR2
		JMP CONTINUAR

CONTINUAR:
	CALL TECLA
	
	CMP AL, ASCII_A		       
	JE MOVER1
	CMP AL, ASCII_D
	JE MOVER2
	CMP AL, 27
	JE	SALIR
	JMP REPETIR

MOVER1:
	XOR AL, AL
	INC AL
	MOV VAR1, AL
	JMP SEGUIR
	
MOVER2: 
	XOR AL, AL
	MOV VAR1, AL
SEGUIR:
	XOR AL, AL
	MOV AX, XORIG
	ADD AX, 5
	MOV XORIG, AX
	JMP REPETIR
	
	
	
SALIR:
	CALL RESTAURAR_MODO_ORIGINAL
	MOV AX,4C00H					; salida a DOS
	INT 21H		    
MAIN ENDP	

; ------------------- Obtiene respuesta del teclado --------------------
TECLA PROC
	MOV AH,07H					; leer tecla sin eco
    INT 21H						
	RET
TECLA ENDP
; ------------------- Restaurar modo original de pantalla --------------------
RESTAURAR_MODO_ORIGINAL PROC
	MOV AL,03H				; modo texto 03h
	MOV AH,00H
	INT 10H
	RET
RESTAURAR_MODO_ORIGINAL ENDP

END MAIN