LDA shipblu_y
; top row first
STA $200
STA $204
; add 8 for the next row of y
CLC
ADC #$08
STA $208
STA $20c
; add 8 more for the finalrow
CLC
ADC #$08
STA $210
STA $214

LDA shipblu_x
; left column of sprites first
STA $203
STA $20b
STA $213
; add 8 to the x position for the second column
CLC
ADC #$08
STA $207
STA $20f
STA $217

LDA laser_y
STA $218
LDA laser_x
STA $21B

LDA pizzaball_y
STA $21C
STA $220
CLC
ADC #$08
STA $224
STA $228
LDA pizzaball_x
STA $21F
CLC
ADC #$08
STA $223
SEC
SBC #$08
STA $227
CLC
ADC #$08
STA $22B




