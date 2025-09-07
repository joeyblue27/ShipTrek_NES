LDA pizza_timer
BNE @SKIP_MOVE     ; if timer > 0, skip

LDA pizzaball_dir
BEQ @MOVE_RIGHT

@MOVE_LEFT:
    LDA pizzaball_x
    SEC 
    SBC #1
    STA pizzaball_x
    LDA pizzaball_y
    CLC 
    ADC #2
    STA pizzaball_y
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
    ADC #1
    STA pizzaball_x
    LDA pizzaball_x
    CMP #$D0 ; Right boundary
    BCC @AFTER_MOVE
    LDA #$01
    STA pizzaball_dir

@AFTER_MOVE:
@SKIP_MOVE:

RTI