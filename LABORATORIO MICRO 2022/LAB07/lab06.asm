#LABORATORIO 6
#Crear un programa en RISC V que permita teniendo un número asignado a un registro,
#calcular su factorial, e imprimirlo, deberá utilizar Macros.
#JULIO ANTHONY ENGELS RUIZ COTO 

.global programa #directiva punto de arranque del programa
.data  #segmento de datos


.text #inicio segmento de codigo
programa:

.macro factorial(%num)
	li a0 , %num #asignando a registros
	
	li a1,1 #cargo al registro a0 1 valor fijo
	li a2,1 #cargo al registro a1 1
	beqz a0,salir #if num == 0 ret salir
	beq a0,a1,salir #if num =1 y a1 =1 ret salir 
	b elloop
elloop:
	mul a3,a0,a2 # a3 = num * 1
	mv a2,a3 
	sub a4,a0,a1 # num - 1
	mv a0,a4 #la resta se carga en num
	bnez a0,elloop #if num !=0
	b exit #salto para imprimir 
	
salir:
	li a0,1 # de ser 0 y 1 cargar 1 a a0
	li a7,1 #a7 de la 1 imprime un entero
	ecall 
	b finalizar
	
exit:
	mv a0,a3
	li a7,1 #a7 de la 1 imprime un entero
	ecall 
	b finalizar


.end_macro 

factorial(10)
li a7,93
ecall 


finalizar:
li a7,10  #parametro para finalizar programa
ecall  #int 21h 
