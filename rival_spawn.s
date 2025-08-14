LDA pizzaball_dir
BEQ @MOVE_RIGHT

@MOVE_LEFT:
    DEC pizzaball_x
    DEC pizzaball_x
    INC pizzaball_y
    INC pizzaball_y
    LDA pizzaball_x
    CMP #$10 ; Left boundary
    BCS @AFTER_MOVE  ; If still >= $20, continue moving

    LDA pizzaball_y
    CMP #$FF
    BCS @PB_HIDE
    SEC
    LDA #$F0
    STA pizzaball_y
    @PB_HIDE:

@MOVE_RIGHT:
    LDA pizzaball_x
    CLC
    ADC #2
    STA pizzaball_x
    LDA pizzaball_x
    CMP #$D0 ; Right boundary
    BCC @AFTER_MOVE
    LDA #$01
    STA pizzaball_dir

@AFTER_MOVE:


RTI