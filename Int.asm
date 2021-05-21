#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)
RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program



INT_VECT CODE 0x0004
BCF INTCON, GIE ;Disable all interrupts inside interrupt service routine
INCF PORTA
MOVFW PORTA
XORLW 0x0A
BTFSC STATUS,Z
CLRF PORTA
BCF INTCON,INTF ;Clear external interrupt flag bit
BSF INTCON, GIE ;Enable all interrupts on exit
RETFIE

; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
;inicio del programa:
START
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
MOVLW b'10010000'
MOVWF INTCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0
MOVLW b'00000000'
MOVWF TRISA
MOVLW b'00000001'
MOVWF TRISB
BCF STATUS, RP0 ;Regresar al banco 0
CLRF PORTA
CLRF PORTB
inicio:

bcf PORTB,7 ;poner el puerto B0 (bit 0 del puerto B) en 0
call tiempo ;llamar a la rutina de tiempo
;call tiempo
;call tiempo
;call tiempo
;call tiempo
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
nop
bsf PORTB,7 ;poner el puerto B0 (bit 0 del puerto B) en 1
call tiempo ;llamar a la rutina de tiempo
;call tiempo
;call tiempo
;call tiempo
;call tiempo
nop ;NOPs de relleno (ajuste de tiempo)
nop

goto inicio ;regresar y repetir

;rutina de tiempo
tiempo:
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
nop
movlw d'54' ;establecer valor de la variable i
movwf i
iloop:
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
nop
nop
movlw d'50' ;establecer valor de la variable j
movwf j
jloop:
nop ;NOPs de relleno (ajuste de tiempo)
movlw d'60' ;establecer valor de la variable k
movwf k
kloop:
decfsz k,f
goto kloop
decfsz j,f
goto jloop
decfsz i,f
goto iloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
END
