LDA pizzaball_dir
BEQ @MOVE_RIGHT

@MOVE_LEFT:
    DEC pizzaball_x
    LDA pizzaball_x
    CMP #$08 ; Left boundary
    BCS @SKIP_LEFT_BOUNCE
    LDA #$00
    STA pizzaball_dir
@SKIP_LEFT_BOUNCE:
    JMP @AFTER_MOVE

@MOVE_RIGHT:
    INC pizzaball_x
    LDA pizzaball_x
    CMP #$E0 ; Right boundary
    BCC @AFTER_MOVE
    LDA #$01
    STA pizzaball_dir
@AFTER_MOVE:

; ---- SINE WAVE MOTION FOR PIZZABALL ----
; Slow down sine wave increment
LDA flicker_timer
AND #%00000011    ; only increment every 4 frames (change to 00000111 for 8, etc.)
BNE @NO_SINE_INC
INC sine_index
@NO_SINE_INC:

; Now update Y position based on sine_index
LDA sine_index
AND #%00011111      ; Wrap to 0–31
TAX
LDA sine_table, X
CLC
ADC #$60            ; vertical center
STA pizzaball_y


LDA pizzaball_y
STA $21C
STA $220
STA $224
STA $228

LDA pizzaball_x
STA $21F
STA $222
STA $226
STA $22A


; increment flicker timer
INC flicker_timer
AND #%00000110     ; Use only bits 1 and 2 => gives values 0,2,4,6 (effectively 4 states)
LSR                ; Divide by 2 to use as index (0–3)
TAX
LDA pizzaball_colors, X
STA $21A ; laser color rotation 
STA $21E ; pizzaball color rotation
STA $222
STA $226
STA $22A


sine_table:
 .byte $80, $83, $86, $89, $8c, $8f, $92, $95, $98, $9b, $9e, $a2, $a5, $a7, $aa, $ad
 .byte $b0, $b3, $b6, $b9, $bc, $be, $c1, $c4, $c6, $c9, $cb, $ce, $d0, $d3, $d5, $d7
 .byte $da, $dc, $de, $e0, $e2, $e4, $e6, $e8, $ea, $eb, $ed, $ee, $f0, $f1, $f3, $f4
 .byte $f5, $f6, $f8, $f9, $fa, $fa, $fb, $fc, $fd, $fd, $fe, $fe, $fe, $ff, $ff, $ff
 .byte $ff, $ff, $ff, $ff, $fe, $fe, $fe, $fd, $fd, $fc, $fb, $fa, $fa, $f9, $f8, $f6
 .byte $f5, $f4, $f3, $f1, $f0, $ee, $ed, $eb, $ea, $e8, $e6, $e4, $e2, $e0, $de, $dc
 .byte $da, $d7, $d5, $d3, $d0, $ce, $cb, $c9, $c6, $c4, $c1, $be, $bc, $b9, $b6, $b3
 .byte $b0, $ad, $aa, $a7, $a5, $a2, $9e, $9b, $98, $95, $92, $8f, $8c, $89, $86, $83
 .byte $7f, $7c, $79, $76, $73, $70, $6d, $6a, $67, $64, $61, $5d, $5a, $58, $55, $52
 .byte $4f, $4c, $49, $46, $43, $41, $3e, $3b, $39, $36, $34, $31, $2f, $2c, $2a, $28
 .byte $25, $23, $21, $1f, $1d, $1b, $19, $17, $15, $14, $12, $11, $0f, $0e, $0c, $0b
 .byte $0a, $09, $07, $06, $05, $05, $04, $03, $02, $02, $01, $01, $01, $00, $00, $00
 .byte $00, $00, $00, $00, $01, $01, $01, $02, $02, $03, $04, $05, $05, $06, $07, $09
 .byte $0a, $0b, $0c, $0e, $0f, $11, $12, $14, $15, $17, $19, $1b, $1d, $1f, $21, $23
 .byte $25, $28, $2a, $2c, $2f, $31, $34, $36, $39, $3b, $3e, $41, $43, $46, $49, $4c
 .byte $4f, $52, $55, $58, $5a, $5d, $61, $64, $67, $6a, $6d, $70, $73, $76, $79, $7c
