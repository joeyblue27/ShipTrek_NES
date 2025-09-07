.proc UpdatePizzaBallPalette
    ; pick frame index
    LDA pizza_color_index
    AND #$04        ; cycle 0–3
    TAX
    TXA
    ASL A           ; *2
    CLC
    ADC #3          ; A = index * 3
    TAX             ; X = offset into table

    ; point PPU to sprite palette 1 ($3F14–$3F16)
    LDA $2002       ; reset latch
    LDA #$3F
    STA $2006
    LDA #$14
    STA $2006

    LDY #0
@loop:
    LDA PizzaBallColors,X
    STA $2007
    INX
    INY
    CPY #3
    BNE @loop

    ; advance every frame
    INC pizza_color_index
    RTS
.endproc