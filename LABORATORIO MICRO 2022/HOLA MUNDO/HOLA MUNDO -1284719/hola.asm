;PROGRAMA DE HOLA MUNDO MICROPROGRAMACION 2022
;JULIO ANTHONY ENGELS RUIZ COTO - 1284719
;==================================================================================
.model small;Declaración de modelo.
.data ;Inicia segmento de datos.

  print db 'JULIO ANTHONY ENGELS RUIZ COTO!$'	;Variable de tipo byte, es cadena y termina con $.

.stack
.code
programa:
	;Inicialización del programa.

	MOV AX, @data ;Obtenemos la dirección del inicio del segmento de datos.
	MOV DS,AX	;Inicializa el segmento de datos.
	;Imprimir cadena.
  MOV DX,OFFSET print ;Llenar dx con todo lo que hay desde el inicio de la cadena.
	MOV AH,09H ;INT 21h / AH=9 - salida de una cadena en DS:DX. La cadena debe terminar con '$'.
	INT 21H
	;Finalización del programa.
	MOV AH,4CH ;INT 21h / AH=4Ch devolver el control al sistema operativo (stop program).
	INT 21H

end programa