!to "build/noise.prg"

;// BASIC starts at location $0801
;// The following program run the BASIC command '10 SYS 2064'
;// which starts running our code at location $0810

*=$0801
!byte $0E, $08, $0A, $00, $9E, $20, $28, $32
!byte $30, $36, $34, $29, $00, $00, $00
*=$0810  

BORDER = $d020
SCREEN = $d021

start   inc SCREEN  ;// increase screen colour 
        inc BORDER  ;// increase border colour
        jmp start   ;// repeat