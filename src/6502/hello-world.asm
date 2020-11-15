!to "build/hello-world.bin"

PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

E  = %10000000
RW = %01000000
RS = %00100000

*=$8000

main:
 ldx #$ff 		; Set stack pointer to address 01ff
 txs

 lda #%11111111 ; Set all pins on port B to output
 sta DDRB

 lda #%11100000 ; Set top 3 pins on port A to output
 sta DDRA

 lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
 jsr lcd_instruction

 lda #%00000001 ; Clear display
 jsr lcd_instruction

 lda #%00000010 ; Return home
 jsr lcd_instruction

 lda #%00001111 ; Display on; cursor on; blink on
 jsr lcd_instruction

 lda #%00000110 ; Increment cursor; no display shift
 jsr lcd_instruction

 lda #"H"		; Print ASCII character
 jsr print

 lda #"e"		; Print ASCII character
 jsr print

 lda #"l"		; Print ASCII character
 jsr print

 lda #"l"		; Print ASCII character
 jsr print

 lda #"o"		; Print ASCII character
 jsr print

 lda #" "		; Print ASCII character
 jsr print

 lda #"w"		; Print ASCII character
 jsr print

 lda #"o"		; Print ASCII character
 jsr print

 lda #"r"		; Print ASCII character
 jsr print

 lda #"l"		; Print ASCII character
 jsr print

 lda #"d"		; Print ASCII character
 jsr print

 lda #" "		; Print ASCII character
 jsr print

 lda #"="		; Print ASCII character
 jsr print

 lda #")"		; Print ASCII character
 jsr print

 jmp loop

lcd_instruction:
 sta PORTB
 lda #E 		; Toggle E bit to send instruction
 sta PORTA
 lda #0	
 sta PORTA
 rts

print:
 sta PORTB
 lda #(RS | E) ; Toggle RS and E bits to write data
 sta PORTA
 lda #0
 sta PORTA
 rts

loop:
 jmp loop
 
*=$fffc

!word main 	   	; Set the program counter to the address of the main label
!word $0000   	; Some padding to fill the rest of the rom