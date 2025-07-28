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
; laser sprite
LDA laser_y
STA $21C
LDA laser_x
STA $21F