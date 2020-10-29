;// Following tutorial from: https://codebase64.org/doku.php?id=base:machine_language_tutorial_part_2
;// We want to get $46 into A, transfer that to X, increase it, put it back into A, and then store that into $CFFF.

!to "build/memory-manipulation.prg"

;// BASIC starts at location $0801
;// The following program run the BASIC command '10 SYS 2064'
;// which starts running our code at location $0810

*=$0801
!byte $0E, $08, $0A, $00, $9E, $20, $28, $32
!byte $30, $36, $34, $29, $00, $00, $00
*=$0810

lda #$46
tax
inx
txa
sta $cfff

;// You can inspect the value in address cfff by opening
;// the monitor and running the command `m cfff`