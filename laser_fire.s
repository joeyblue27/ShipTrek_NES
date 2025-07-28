; laser shot
LDA controls_d

CMP #BUTTON_B
BNE @LASER_STOP            ; Only fire laser if BUTTON_B is pressed and laser is not active

LDA laser_active
BNE @LASER_STOP            ; Prevent firing if laser is already active
; Fire laser
@LASER_SHOT:
LDA #$01
STA laser_active           ; Mark laser as active
LDA shipblu_x
CLC
ADC #$04
STA laser_x
LDA shipblu_y
STA laser_y

@LASER_STOP:

; --- Update laser position ---
@UPDATE_LASER:
LDA laser_active
BEQ @UPDATE_SKIP           ; Skip if no active laser

; If laser is still on screen, move it
LDA laser_y
CMP #$F0
BCS @UPDATE_SKIP           ; If offscreen, skip

DEC laser_y
SEC
SBC #$04
STA laser_y                ; Move laser up by 4 units (change speed if needed)

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
LDA #$F8
STA pizzaball_y            ; Move pizzaball offscreen
STA laser_y
LDA #$00
STA laser_active           ; Deactivate laser

JMP @UPDATE_PIZZABALL_OAM

@NO_COLLISION_Y:
CMP pizzaball_y
SBC laser_y
CMP #$08
BCS @NO_COLLISION
JMP @COLLISION

@NO_COLLISION:


@UPDATE_PIZZABALL_OAM:
LDA pizzaball_y
STA $218                   ; Y position in OAM
LDA pizzaball_x
STA $21B                   ; X position in OAM



