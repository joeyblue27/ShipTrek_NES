    ; controller readings

    LDA #$02 ; copy sprite data from $0200 => PPU memory for display
    STA SpriteDMA
    JSR controller_read
    STA $80
    LDA controls
    AND #BUTTON_A
    CMP #BUTTON_A
    BNE @DONT_A
   
    LDA shipblu_y ; can do this instead of using inc twice
    SEC
    SBC #2
    STA shipblu_y
@DONT_A:
    LDA controls
    CMP #BUTTON_DOWN
    BNE @DONT_DOWN
    LDA shipblu_y 
    CLC
    ADC #2
    STA shipblu_y
    
  @DONT_DOWN:
    LDA controls
    AND #BUTTON_LEFT
    CMP #BUTTON_LEFT
    BNE @DONT_LEFT

    LDA shipblu_x 
    SEC
    SBC #2
    STA shipblu_x
  @DONT_LEFT:
    LDA controls
    AND #BUTTON_RIGHT
    CMP #BUTTON_RIGHT
    BNE @DONT_RIGHT
    LDA shipblu_x 
    CLC
    ADC #2
    STA shipblu_x
   @DONT_RIGHT:
    LDA controls 
    CMP #BUTTON_DOWN|BUTTON_LEFT
    BNE @DONT_DOWN_LEFT
    DEC shipblu_x
    INC shipblu_y
   @DONT_DOWN_LEFT:
    LDA controls 
    CMP #BUTTON_DOWN|BUTTON_RIGHT
    BNE @DONT_DOWN_RIGHT
    INC shipblu_x
    INC shipblu_y
   @DONT_DOWN_RIGHT: