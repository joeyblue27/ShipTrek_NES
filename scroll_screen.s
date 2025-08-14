NMI:    
    
    LDA #$00         ; First write = horizontal scroll
    STA $2005

    LDA scroll_y     ; Second write = vertical scroll
    STA $2005

    LDA scroll_y
    CLC
    SBC #0     ; or #2 or #4 for faster scroll
    STA scroll_y

        ; Check for vertical wrap (after 240 pixels)
    LDA scroll_y
    LDA #%10010010
    STA $2000
    CMP #$F0            ; If vertical scroll reaches 240, wrap around
    BNE @DoneVerticalScroll

        ; Reset vertical scroll after wrapping
    LDA #$00
    STA scroll_y

@DoneVerticalScroll:


