#include "p16F630.inc" ;se incluyen todos los parámetros del Micro
 __CONFIG _FOSC_INTRCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_OFF & _CP_OFF & _CPD_OFF

org 0x0000 ;org setea el vector de inicio. PC en 0000. Debajo comienza el programa

;Defino los contadores en la zona de registro
contador0 equ 0x22
contador1 equ 0x24
contador2 equ 0x26
contador3 equ 0x28

#DEFINE led PORTA,4
#DEFINE pulsador PORTA,2
#DEFINE TIZQ PORTA,5
#DEFINE TDER PORTA,1
#DEFINE cero b'110111'
#DEFINE uno b'000110'
#DEFINE dos b'011011'
#DEFINE tres b'001111'
#DEFINE cuatro b'101110'
#DEFINE cinco b'101101'
#DEFINE seis b'111101'
#DEFINE siete b'100110'
#DEFINE ocho b'111111'
#DEFINE nueve b'101111'

    bsf STATUS,RP0 ;Pasamos al banco 1
    clrf TRISC ;Seteamos al Port C como SALIDA (todos los RC ahora son salidas).
    bsf pulsador ;Pulsador para cambiar de número como ENTRADA.
    bcf TIZQ ;Transistor del display izquierdo como SALIDA.
    bcf TDER ;Transistor del display derecho como SALIDA.
    bcf led ;Led de señalizacion como SALIDA.
    bcf STATUS,RP0 ;Pasamos al banco 0
    ;En el puerto C uso todos los pines (los 6) para el display.

INICIO
    BSF TIZQ
    BSF TDER
    BCF led  ;Apago el led
    call CERO
    goto INICIO

;Rutinas:
CERO       ;Tengo que prender todos menos la G para mostrar el 0:
;EL D ES EL QUE ESTA PUENTEADO CON A, de esta manera o se muestran los dos o ninguno.
BSF TIZQ
BSF TDER
movlw cero   ;En 1 estan prendidos, estos bits representan: F E G C B AYDjuntos (del display)
movwf PORTC
btfsc pulsador ;Si el pulsador está presiondo, pulsador=0 (está conectado a masa). Si está 
;presionado salta (ya que el bit es 0) a retardo. Y sino está presionado siguien con goto CERO,
;mostrando el cero hasta que aprete el pulsador.
;btfsc registro,bit -> comprueba un determinado bit de un registro (f) y salta si el bit vale 0 (clear) 
;btfss r,bit--> comprueba el bit de f y salta si vale 1(set).
goto CERO
call RETARDO  ;Esto es para evitar el rebote.
call UNO

UNO
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto UNO
call RETARDO  ;Esto es para evitar el rebote.
call DOS

DOS
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw dos;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto DOS
call RETARDO  ;esto es psra evitar el rebote.
call TRES

TRES
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw tres;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto TRES
call RETARDO  ;esto es psra evitar el rebote.
call CUATRO

CUATRO
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw cuatro;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto CUATRO
call RETARDO  ;esto es psra evitar el rebote.
call CINCO

CINCO
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw cinco;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto CINCO
call RETARDO  ;esto es psra evitar el rebote.
call SEIS

SEIS
BSF led ;prendo el led
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw seis;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto SEIS
call RETARDO  ;esto es psra evitar el rebote.
call SIETE

SIETE
BCF led ;apago el led
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw siete;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto SIETE
call RETARDO  ;esto es psra evitar el rebote.
call OCHO

OCHO
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw ocho;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto OCHO
call RETARDO  ;esto es psra evitar el rebote.
call NUEVE

NUEVE
BSF TIZQ
BCF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw nueve;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto NUEVE
call RETARDO  ;esto es psra evitar el rebote.
call DIEZ

DIEZ
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto DIEZ
call RETARDO  ;esto es psra evitar el rebote.
call ONCE

ONCE
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto ONCE
call RETARDO  ;esto es psra evitar el rebote.
call DOCE

DOCE
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw dos;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto DOCE
call RETARDO  ;esto es psra evitar el rebote.
call TRECE

TRECE
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw tres;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto TRECE
call RETARDO  ;esto es psra evitar el rebote.
call CATORCE

CATORCE
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw cuatro;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto CATORCE
call RETARDO  ;esto es psra evitar el rebote.
call QUINCE

QUINCE
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw cinco;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto QUINCE
call RETARDO  ;esto es psra evitar el rebote.
call DIECI6

DIECI6
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw seis;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto DIECI6
call RETARDO  ;esto es psra evitar el rebote.
call DIECI7

DIECI7
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw siete;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto DIECI7
call RETARDO  ;esto es psra evitar el rebote.
call DIECI8

DIECI8
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw ocho;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto DIECI8
call RETARDO  ;esto es psra evitar el rebote.
call DIECI9

DIECI9
BSF TIZQ
BCF TDER
movlw uno;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw nueve;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto DIECI9
call RETARDO  ;esto es psra evitar el rebote.
call VEINTE

VEINTE
BSF TIZQ
BCF TDER
movlw dos;
movwf PORTC
CALL RETARDITO
BCF TIZQ
BSF TDER
movlw cero;
movwf PORTC
CALL RETARDITO
btfsc pulsador ; ¿pulsador presionado? (pulsador == 0). Si lo presione salta a retardo.
goto VEINTE
call RETARDO  ;Esto es para evitar el rebote.
call CERO

RETARDO
    ;780ms
    movlw d'1'
    movwf contador0
    dec0
	movlw d'63'
	movwf contador1
	dec1
	    movlw d'63'
	    movwf contador2
	    dec2
		movlw d'63'
		movwf contador3
		dec3
		    decfsz contador3
		goto dec3
		decfsz contador2
	    goto dec2
	    decfsz contador1
	goto dec1
	decfsz contador0
    goto dec0
return

RETARDITO
    ;37ms
    movlw d'1'
    movwf contador0
    dec4
	movlw d'1'
	movwf contador1
	dec5
	    movlw d'63'
	    movwf contador2
	    dec6
		movlw d'63'
		movwf contador3
		dec7
		    decfsz contador3
		goto dec7
		decfsz contador2
	    goto dec6
	    decfsz contador1
	goto dec5
	decfsz contador0
    goto dec4
return

end



