LDA controls_d
CMP #BUTTON_B
BEQ @LASER_SHOT
JMP @LASER_STOP
@LASER_SHOT:
LDA shipblu_x
CLC
ADC #$04
STA laser_x
LDA shipblu_y
STA laser_y
@LASER_STOP:

@UPDATE_LASER:
LDA laser_y
CMP #$F0
BCS @UPDATE_SKIP
DEC laser_y
SEC 
SBC #$04
STA laser_y

@UPDATE_SKIP:



; --- Check collision between laser and pizzaball ---
LDA pizzaball_y
CMP #$F8                   ; If pizzaball is offscreen, skip
BCS @NO_COLLISION

LDA laser_y
SEC
SBC pizzaball_y
CMP #$08
BCS @NO_COLLISION_Y        ; If the laser is too far in Y, skip

LDA laser_x
SEC
SBC pizzaball_x
CMP #$08
BCS @NO_COLLISION          ; If the laser is too far in X, skip

; --- Collision Detected ---
@COLLISION:
LDA #$F1
STA pizzaball_y            ; Move pizzaball offscreen
LDA #$00
STA laser_active           ; Deactivate laser

JMP @UPDATE_PIZZABALL_OAM

@NO_COLLISION_Y:
CMP pizzaball_y
SBC laser_y
CMP #$10
BCS @NO_COLLISION
JMP @COLLISION

@NO_COLLISION:


@UPDATE_PIZZABALL_OAM:
    LDA pizza_timer
    BEQ @DRAW_PIZZABALL   ; already 0 → draw
    DEC pizza_timer       ; count down
    BNE @HIDE_PIZZABALL   ; if still > 0 → hide

@DRAW_PIZZABALL:
    LDA pizzaball_y
    STA $21C
    STA $220
    CLC
    ADC #$08
    STA $224
    STA $228
    LDA pizzaball_x
    STA $21F
    STA $227
    CLC
    ADC #$08
    STA $223
    STA $22B
    JMP @AFTER_DRAW

@HIDE_PIZZABALL:
    LDA #$F0
    STA $21C
    STA $220
    STA $224
    STA $228
    STA $21F
    STA $227
    STA $223
    STA $22B

@AFTER_DRAW:

