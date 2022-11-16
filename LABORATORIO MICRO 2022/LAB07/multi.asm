.global programa #directiva punto de arranque del programa
.data  #segmento de datos

hola:
.string "hola mundo!!!"

.text #inicio segmento de codigo
programa:

.macro multiplicar(%num1 %num2)
	j multiplicacion
	impresiontexto:
	la a0,hola
	li a7,4
	ecall 

j salir
multiplicacion:
	li a1, %num1  #asignando a registros
	li a2, %num2  #asignando a registros
	mul a0, a1,a2  #resultado,operando 1 , operando2
	beq a1, a2, impresiontexto #si dos valores son iguales

salir:
.end_macro

multiplicar(3,1)
li a7,93
ecall 


finalizar:
li a7,10  #parametro para finalizar programa
ecall  #int 21h 
