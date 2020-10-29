!to "build/hello-world.prg"

;// BASIC starts at location $0801
;// The following program run the BASIC command '10 SYS 2064'
;// which starts running our code at location $0810

*=$0801
!byte $0E, $08, $0A, $00, $9E, $20, $28, $32
!byte $30, $36, $34, $29, $00, $00, $00
*=$0810  

JSR $E544
loop jsr init_text      ; write line of text
jmp loop				; infinite loop

message   !scr "              hello world!              "	;// 40 cols of text

init_text  ldx #$00         ;// init X-Register with $00
loop_text  lda message,x    ;// read characters from message text...
           sta $0590,x      ;// ...and place it into screen screen memory
           inx 				;// increment to next character
           cpx #$28         ;// false if != 40
           bne loop_text    ;// loop if false
           rts