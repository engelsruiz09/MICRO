.global programa   #Directiva punto de arranque del programa
.data              #Inicio segmento de datos
hola:
	.string "Hola Mundo!!!"
.text              #Inicio segmento de codigo	
programa:

	la a0, hola
	li a7, 4    #Parametro para imprimir cadena de caracteres
	ecall
	j finalizar

finalizar:
	li a7, 10  #Parametro para finalizar programa
	ecall      #int 21h