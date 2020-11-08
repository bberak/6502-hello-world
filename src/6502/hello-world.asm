!to "build/hello-world.bin"

PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

E  = %10000000
RW = %01000000
RS = %00100000

*=$8000

init:
 lda #%11111111 ; Set all pins on port B to output
 sta DDRB

 lda #%11100000 ; Set top 3 pins on port A to output
 sta DDRA

print:
 lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
 sta PORTB

 lda #0 		; Clear RS/RW/E bits
 sta PORTA

 lda #E 		; Set E bit to send instruction
 sta PORTA

 lda #0			; Clear RS/RW/E bits
 sta PORTA

 lda #%00001111 ; Display on; cursor on; blink on
 sta PORTB

 lda #0 		; Clear RS/RW/E bits
 sta PORTA

 lda #E 		; Set E bit to send instruction
 sta PORTA

 lda #0			; Clear RS/RW/E bits
 sta PORTA

 lda #%00000110 ; Increment cursor; no display shift
 sta PORTB

 lda #0 		; Clear RS/RW/E bits
 sta PORTA

 lda #E 		; Set E bit to send instruction
 sta PORTA

 lda #0			; Clear RS/RW/E bits
 sta PORTA

 lda #$42		; Write ASCII character represented by hex 42 to the screen
 sta PORTB

 lda #RS 		; Set RS; Clear RW/E bits
 sta PORTA

 lda #(RS | E) ; Set RS and E bits with bitwise or operation
 sta PORTA

 lda #RS 	   ; Set RS; Clear RW/E bits
 sta PORTA

loop:
 jmp loop
 
*=$fffc

!word init  ;; Set the program counter to the address of the init label
!word $0000 ;; Some padding to fill the rest of the rom