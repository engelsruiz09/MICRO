.global programa #directiva punto de arranque del programa
.data  #segmento de datos

hola:
.string "hola mundo!!!"
.text #inicio segmento de codigo
programa:

la a0, hola
li a7,4 #parametro para imprimir cadena de caracteres
ecall

finalizar:
li a7,10  #parametro para finalizar programa
ecall  #int 21h 