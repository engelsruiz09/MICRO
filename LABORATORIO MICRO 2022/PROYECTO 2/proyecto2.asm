 #===================================================================PROYECTO 2 LABERINTO =========================================================================================
 #JULIO ANTHONY ENGELS RUIZ COTO - 1284719
 #EDDI ALEJANDRO GIRON CARRANZA - 1307419
 .global programa
  .data
fin:   
  .string  "test.txt"
error:
  .string  "No se ha podido abrir el archivo"

buffer:
  .string "500"
  
buffer2:
  .string "500"

genera:
  .string "resul.txt"
  
errordimensiones:
.string "Se ingresaron dimensiones incorrectas"
errordimensiones2:
.string "Formato incorrecto de numeros"
errordimensiones3:
.string "Formato incorrecto de entrada o salida"
errordimensiones4:
.string "Formato incorrecto de su archivo >;v"
enter:
.string " "

letraA:
.string "A"

letraB:
.string "B"

letraC:
.string "C"

letraD:
.string "D"

letraF:
.string "F"

.text

#Leer archivo de texto
programa:
  la   s0, buffer   
  li   s1, 501      

  la   a0, fin      # param nombre de archivo
  li   a1, 0        # param 0 leer, param 1 escribir
  li   a7, 1024     # abrir archivo
  ecall

  bltz a0, errorlectura # Salto si a0 es menor a 0, es decir si no existe
  mv   s6, a0        # sguardar info del archivo

ciclolectura:
  mv   a0, s6       # descripcion del archivo 
  mv   a1, s0       # direccion de buffer
  mv   a2, s1       # cantidad de caracteres a leer
  li   a7, 63       # parametro para leer archivo
  ecall             

  bltz a0, cerrararchivo # en caso de error, cerrar el archivo es importante
  mv   t0, a0       
  add  t1, s0, a0   
  sb   zero, 0(t1)  

  # impresion de lo que se ha leido
  mv   a0, s0
  li   a7, 4
  ecall
  beq  t0, s1, ciclolectura

cerrararchivo: 
  mv   a0, s6       # informacion del archivo / descriptor
  li   a7, 57       # parametro para cerrar archivo
  ecall             # Cerrar el archivo
  j escribe

txt_a_laberinto:
	#call 	
   	xor a2,a2,a2 #xor ax, ax            
	#proceder a dimensiones
	li t3,02 #CH = t3 -> cont de digitos, dos digitos
	li t4,02 #CL = t4 -> cont de dimensiones x,y
	j while
	while:	
		blt t4,zero,endw #while (CL > 0)
		j while2
			while2:	
				blt t3,zero,endw2 #while (CH > 0)
				bge t5,zero,y # IF t5 = BL >= 0 si es numero
				j  si_no_es_numero
				y:
				  li t6,9  #MOV T6 = 9
				  ble t5,t6,es_numero  #BL =< 9 si es numero
				  j si_no_es_numero
				  es_numero:
				  	li t6,2
				  	beq t3,t6,primer_digito #if CH == 2 si es primer digito
				  	j segundo_digito
				  	primer_digito:
				  		li t6,10
				  		mul a2,t6,t5 #AL = a2 guarda mul
				  		li t6,2
				  		beq t4,t6,primera_dimension #if CL == 2 
				  		j segunda_dimension
				  		primera_dimension:
				  			mv s2,a2 #mov s2= filas,a2
				  			j decrementa_t3
				  		segunda_dimension:
				  			mv s3,a2 #mov s3 = columnas,a2
				  			j decrementa_t3
				  			
				  			
				  			
				  	segundo_digito:
				  		beq t4,t6,primera_dimension_dos #if CL == 2 
				  		j segunda_dimension_dos
				  		primera_dimension_dos:
				  			add s2,s2,t5 #add s2= filas,t5
				  			j decrementa_t3
				  		segunda_dimension_dos:
				  			add s3,s3,t5 #add s3 = columnas,t5
				  			j decrementa_t3	
				  		decrementa_t3:
				  			li t6,1
				  			sub t3,t3,t6
				  			j while2
				  si_no_es_numero:   #si no es un espacio en blanco
				  	la s8,enter
				  	bne t5,s8,imprime_error#validacion
				  	j siguiente_caracter
				  	imprime_error:
				  		la a0,errordimensiones
						li a7,4
						ecall
						j finalizar_programa 
				 siguiente_caracter:
				 	#li t6,1
				 	#add #ESI,ESI,T6
				 	#mv #T5,ESI
				 	addi s7,s7,0 #S7 = PUNTERO i + 0 
				 	add s7,t5,s7 # s7 = i + BL
				 	lb t2,0(t5) #t5 = t5[i]
				 	addi s7,s7,1 #i = i+1
				 	
				 	mv t5,t2
				 	j while2
				 	
				endw2:
				  	li t6,1 
				  	sub t4,t4,t6 #dec CL = t4
				  	li t3,2 # mov CH = t3, 02
				  	j while
endw:		
	li t6,10 #validacion si filas mayor a 10
	bgt s2,t6,error5 #s2 = filas > 10
	j valida_columnas
	valida_columnas:
		li t6,10
		bgt s3,t6,error5 #s3 = columnas > 10 
		j valida_filas_menor
	valida_filas_menor:
		li t6,1 #s2 = filas < 1
		blt s2,t6,error5
		j valida_columnas_menor
	valida_columnas_menor:
		li t6,1 #s3 = columnas < 1
		blt s3,t6,error5
		j salir_validacion
	error5:
		la a0,errordimensiones
		li a7,4
		ecall
		j finalizar_programa
		
	salir_validacion:
		#calcular tamaño
		xor a2,a2,a2 #xor ax, ax
		mul a2,s2,s3 #mul de filas * columnas 
		mv s4,a2 # s4 tamaño de laberinto
		
		#guardar y validar entrada y salida
		li t3,03 #CH = t3 -> cont de digitos y letras 
		li t4,02 #CL = t4 -> cont de dimensiones x,y
		xor a2,a2,a2 #xor ax, ax
		xor t5,t5,t5 #xor bl,bl
		#mv t5,ESI
		j elwhile
		elwhile:	
			blt t4,zero,endelw #while (CL > 0)
			j elwhile2
				elwhile2:	
					blt t3,zero,endelw2 #while (CH > 0)
					li t6,1
					bne t3,t6,siguiente # IF t3 = CH =! 1 
					j elelse
					siguiente:
						bge t5,zero,siguiente2 # IF t5 = BL >= 0 si es numero
						j next
						siguiente2:
				 	 		li t6,9  #MOV T6 = 9
				 			ble t5,t6,si_es_numero  #BL =< 9 si es numero
				 	 		j next
				 			si_es_numero:
				  				li t6,3
				  				beq t3,t6,segundo2_digito #if CH == 3 si es segundo digito
				  				j tercer_digito 
				  				segundo2_digito:
				  					li t6,10
				  					mul a2,t6,t5 #AL = a2 guarda mul
				  					li t6,02
				  					beq t4,t6,entrada #si es la entrada
				  					j si_es_salida
				  					entrada:
				  						mv s10,a2 #s10 entradanum
				  						j decrementa_t32
				  					si_es_salida:
				  						mv s11,a2 #s11 salidanum
				  						j decrementa_t32
				  				tercer_digito:
				  					li t6,2
				  					beq t4,t6,segundo2_digito2 #if CL == 2 si es la entrada
				  					j si_salida
				  					segundo2_digito2:
				  						add s10,s10,t5 # add entradanum, bl
				  						j  endelw2
				  						si_salida:
				  							add s11,s11,t5 # add salidanum, bl
				  							j endelw2
				  						decrementa_t32:
				  							li t6,1
				  							sub t3,t3,t6
				  							#INC ESI
				  							#MOV prevASCII, BL
											#MOV BL, [ESI]
				  							j elwhile2
				  						
				  		next:
				  			la s8,enter
				  			bne t5,s8,imprime_error2#validacion t5 = bl
				  			j siguiente_caracter
				  			imprime_error2:
				  				la a0,errordimensiones2
								li a7,4
								ecall
								j finalizar_programa 					
				  							
				  	     elelse:
				  	     	la s8,letraA
				  	     	beq t5,s8,paso_entrado
				  	     	j letrasigB
				  	     	letrasigB:
				  	     		la s8,letraB
				  	     		beq t5,s8,paso_entrado
				  	     		j letrasigC	
				  	     		letrasigC:
				  	     			la s8,letraC
				  	     			beq t5,s8,paso_entrado
				  	     			j letrasigD	
				  	     			letrasigD:
				  	     				la s8,letraD
				  	     				beq t5,s8,paso_entrado
				  	     				j no_espacio	
				  	     				paso_entrado:
				  	     					li t6,02
				  	     					beq t4,t6,entrada_pared#CL = t4 CL == 2
				  	     					j salida_pared
				  	     					entrada_pared:		  	     						
				  	     						mv a6,t5  #entradapared = a6 t5 = bl
				  	     						li t6,1
				  							sub t3,t3,t6
				  							j elwhile2
				  	     					salida_pared:
				  	     						mv a7,t5  #salidapared= a7 t5 = bl
				  	     						li t6,1
				  							sub t3,t3,t6
				  							j elwhile2
				  	     				no_espacio:
				  	     					la s8,enter
				  						bne t5,s8,imprime_error3#validacion t5 = bl
				  						j siguiente_caracter
				  						imprime_error3:
				  							la a0,errordimensiones3
											li a7,4
											ecall
											j finalizar_programa 	
					
						
					endelw2:
						li t6,1 
						sub t4,t4,t6 #dec CL = t4
						li t3,03
						j elwhile
		 		endelw:		
				  	li t3,03 #CH = t3 -> cont de digitos y letras
				  	#mv ESI,posinipared
				  	#mv bl,{ESI}
				  	la t6,letraF
				  	bne t5,t6,no_final #si no se encuentra el caracter final del archivo t5 = BL
				  	j final
				  	no_final:
				  		bgt t3,zero,no_final2 #si no se toman los 4 caracteres
				  		j final_2
				  		no_final2:
				  			#omitirespacios
				  			beq t5,t6,fin_cadena 
				  			j no_fincadena
				  			fin_cadena:
				  				j finalizar_programa
				  			no_fincadena:
				  				mv s10,t5 
				  				li t6,1
				  				bne t3,t6,sigue
				  				j valida_letra3
				  				sigue:
				  					bge t5,zero,yy # IF t5 = BL >= 0 si es numero
									#j else
									yy:
				  					li t6,9  #MOV T6 = 9
				 					ble t5,t6,es_num  #BL =< 9 si es numero
				  					j sinoesnum
				  					es_num:
				  						li t6,3
				  						beq t3,t6,er_digito
				  						j no1erdigito
				  						er_digito:
				  							li t6,10
				  							mul a2,t6,t5 #AL = a2 guarda mul
				  							mv s11,a2 #s11 = un num temporal
				  							j dec_ch
				  						no1erdigito:
				  							add s11,s11,t5 # si segundo digito
				  							j dec_ch
				  							
				  						sinoesnum:
				  							la s8,enter
				  							bne t5,s8,imprime_erro#validacion
				  							j valida_letra3
				  							imprime_erro:
				  								la a0,errordimensiones4
												li a7,4
												ecall
												j finalizar_programa 
								valida_letra3:
										la s8,letraA
				  	     					beq t5,s8,paso_entrado2
				  	     					j letrasigB2
				  	     					letrasigB2:
				  	     						la s8,letraB
				  	     						beq t5,s8,paso_entrado2
				  	     						j letrasigC2	
				  	     							letrasigC2:
				  	     								la s8,letraC
				  	     								beq t5,s8,paso_entrado2
				  	     								j letrasigD2	
				  	     									letrasigD2:
				  	     										la s8,letraD
				  	     										beq t5,s8,paso_entrado2
				  	     										j no_espacio2
				  	     									paso_entrado2:
				  	     										mv s6,t5 #S6 = un tempo de nuestra pared
				  	     										j dec_ch
				  	     									no_espacio2:
				  	     										la s8,enter
				  											bne t5,s8,impri_error3#validacion t5 = bl
				  											j siguiente_codigo
				  											impri_error3:
				  												la a0,errordimensiones4
																li a7,4
																ecall
																j finalizar_programa
																
																		
														siguiente_codigo:
															beq t3,zero,matriz
															#j no_matriz
															matriz:
																mv s5,s4 #s4 = tamano de nuestro laberinto
																li t6,1
																sub s5, s5, t6
																bltz s11, IndError #Si el tama�o de las dimesiones (s11) es menor a 0 = error
																j IndVerifica2
																IndError:
																	la a0,errordimensiones4
																	li a7,4
																	ecall
																	j finalizar_programa
																
																IndVerifica2:
																	bgt s11, s5, IndError #Si el tama�o de las dimesiones (S11) es mayor al tama�o de la matriz = error
																	j IndCorrecto
														
														IndCorrecto:
															li t6, 4
															mul s11, s11, t6
															la s6, buffer
															
															la t6, letraB 
															#beq t5, t6 aumetaB #Verifica si la casilla en la que se encuentra siene aberturas en la letra B
															j ComparaconC
																ComparaconC:
																	la t6, letraC
																	beq t5, t6 aumentaC #Verifica si la casilla en la que se encuentra siene aberturas en la letra B
																	j ComparaconD
																ComparaconD:
																	la t6, letraD
																	beq t4, t6 aumentaD #Verifica si la casilla en la que se encuentra siene aberturas en la letra B
																	j salCompAumenta
																aumentaB:
																	addi s11, s11, 1 
																	j salCompAumenta
																	
																aumentaC:
																	addi s11, s11, 2
																	j salCompAumenta
																
																aumentaD:
																	addi s11, s11, 3
																	j salCompAumenta
																
															salCompAumenta:
																
																
								
																
																				
																								
				  						dec_ch:
				  							li t6,1
				  							sub t3,t3,t6 #decrementamos en uno ch = t3
				  							j no_final	
				  							
				  					
				
				  		final_2:
				  		
				  	final:	
				  	
escribe:
  la   s0, buffer2   
  li   s1, 501      

  la   a0, genera      # param nombre de archivo
  li   a1, 1        # param 0 leer, param 1 escribir
  li   a7, 1024     # abrir archivo
  ecall

  bltz a0, errorlectura # Salto si a0 es menor a 0, es decir si no existe
  mv   s6, a0        # sguardar info del archivo

ciclolectura2:
  mv   a0, s6       # descripcion del archivo 
  mv   a1, s0       # direccion de buffer
  mv   a2, s1       # cantidad de caracteres a leer
  li   a7, 64       # parametro para leer archivo
  ecall             

  bltz a0, cerrararchivo2 # en caso de error, cerrar el archivo es importante
  mv   t0, a0       
  add  t1, s0, a0   
  sb   zero, 0(t1)  

  # impresion de lo que se ha leido
  mv   a0, s0
  li   a7, 4
  ecall
  #beq  t0, s1, ciclolectura2

cerrararchivo2: 
  mv   a0, s6       # informacion del archivo / descriptor
  li   a7, 57       # parametro para cerrar archivo
  ecall             # Cerrar el archivo
  j finalizar_programa
  
finalizar_programa:
  li   a7, 10
  ecall

errorlectura:
  la   a0, error
  li   a7, 4
  ecall
				  			
				  	
