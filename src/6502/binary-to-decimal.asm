!to "build/binary-to-decimal.bin"

;;;;;;;;;;;;;;;;;;;
;;;; Constants ;;;;
;;;;;;;;;;;;;;;;;;;

PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

E  = %10000000
RW = %01000000
RS = %00100000

;;;;;;;;;;;;;;;;;;;
;;;; Variables ;;;;
;;;;;;;;;;;;;;;;;;;

value = $0200
mod_10 = value + 2

mem_cmp = mod_10 + 2
mem_start = mem_cmp + 1

;;;;;;;;;;;;;;;;
;;;; Offset ;;;;
;;;;;;;;;;;;;;;;

*=$8000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Instructions (main) ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main:
 ; Set stack pointer to address 01ff
 ldx #$ff 		
 txs

 jsr lcd_init

 lda binary_number
 sta value
 lda binary_number + 1
 sta value + 1

 lda #0
 sta mod_10
 sta mod_10 + 1

 clc
 rol value
 rol value + 1
 rol mod_10
 rol mod_10 + 1

 jmp idle

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Memory Utilities ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

fill_memory_from_x_to_y:
 sta mem_start,x
 stx mem_cmp
 cpy mem_cmp
 beq fill_complete
 inx
 jmp fill_memory_from_x_to_y

fill_complete:
 rts

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Print Utilities ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

print_memory_from_x_to_y:
 pha

print_start:
 lda mem_start,x
 jsr print
 stx mem_cmp
 cpy mem_cmp
 beq print_complete
 inx
 jmp print_start

print_complete:
 pla
 rts

print:
 jsr lcd_wait
 sta PORTB
 lda #(RS | E) ; Toggle RS and E bits to write data
 sta PORTA
 lda #0
 sta PORTA
 jsr delay
 rts

print_ascii_table_forever:
 txa
 jsr print 
 inx
 jmp print_ascii_table_forever

print_random_chars_forever:
 lda $00,x
 jsr print 
 inx
 jmp print_random_chars_forever

print_message:
 pha
 phx
 ldx #0

print_message_loop:
 lda message,x
 beq print_message_break
 jsr print
 inx
 jmp print_message_loop

print_message_break:
 plx
 pla
 rts

;;;;;;;;;;;;;;;;;;;;;;
;;;; LCD Uitities ;;;;
;;;;;;;;;;;;;;;;;;;;;;

lcd_init:
 ; Set all pins on port B to output
 lda #%11111111 
 sta DDRB

 ; Set top 3 pins on port A to output
 lda #%11100000 
 sta DDRA
 
 ; Set 8-bit mode; 2-line display; 5x8 font
 lda #%00111000 
 jsr lcd_instruction

 ; Clear display
 lda #%00000001 
 jsr lcd_instruction

 ; Return home
 lda #%00000010 
 jsr lcd_instruction

 ; Display on; cursor on; blink on
 lda #%00001111 
 jsr lcd_instruction

 ; Increment cursor; no display shift
 lda #%00000110 
 jsr lcd_instruction

lcd_instruction:
 jsr lcd_wait
 sta PORTB
 lda #E ; Toggle E bit to send instruction
 sta PORTA
 lda #0	
 sta PORTA
 rts

lcd_wait:
 pha
 lda #%00000000 ; Set all pins on port B to input
 sta DDRB

lcd_busy:
 lda #RW
 sta PORTA
 lda #(RW | E) ; Toggle RW and E bits to read data
 sta PORTA
 lda PORTB
 and #%10000000
 bne lcd_busy
 lda #%11111111 ; Set all pins on port B to output
 sta DDRB
 pla
 rts

;;;;;;;;;;;;;;;;;;;;;;;
;;;; CPU Utilities ;;;;
;;;;;;;;;;;;;;;;;;;;;;;

delay:
 phx
 phy
 ldx #127

delay_x_loop:
 ldy #0
 inx
 beq delay_break

delay_y_loop:
 iny
 beq delay_x_loop
 jmp delay_y_loop

delay_break:
 ply
 plx
 rts

idle:
 jmp idle

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Post-Instruction ROM ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

message:
!text "Hello world =)"
!byte $00

binary_number:
!word 1729

;;;;;;;;;;;;;;;;
;;;; Offset ;;;;
;;;;;;;;;;;;;;;;

*=$fffc

;;;;;;;;;;;;;;;;;
;;;; EOF ROM ;;;;
;;;;;;;;;;;;;;;;;

!word main 	   	; Set the program counter to the address of the main label
!word $0000   	; Some padding to fill the rest of the rom