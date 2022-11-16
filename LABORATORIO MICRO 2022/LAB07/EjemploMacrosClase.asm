.global programa   #Directiva punto de arranque del programa
.data              #Inicio segmento de datos
hola:
	.string "Hola Mundo!!!"
.text              #Inicio segmento de codigo	
programa:

	.macro multiplicar(%num1 %num2)
	j multiplicacion
	impresiontexto:
		la a0, hola
		li a7,4
		ecall
	j salir
	multiplicacion:
		li a1, %num1    #Asignando a registros
		li a2, %num2    #asignando a registros
		mul a0, a1, a2  # resultado, operando1, operando2
		beq a1, a2, impresiontexto
	salir:
	.end_macro 
	
	multiplicar(2,2)
	#li a7, 93
	#ecall

finalizar:
	li a7, 10  #Parametro para finalizar programa
	ecall      #int 21h
