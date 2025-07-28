SpriteDMA = $4014

    BIT $2002
    BPL :-

    LDA #$02
    STA SpriteDMA
    NOP

    ; $3F00
    LDA #$3F
    STA $2006
    LDA #$00
    STA $2006

    LDX #$00
    
colorpalletes:
    LDA palletes, X
    STA $2007 ; $3F00, $3F01, $3F02 => $3F1F
    INX
    CPX #$20
    BNE colorpalletes    
    LDX #$00

    ; Initialize world to point to world data
    LDA #<WorldData
    STA world
    LDA #>WorldData
    STA world+1

    ; setup address in PPU for nametable data
    BIT $2002
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006

    LDX #$00
    LDY #$00
LoadWorld:
    LDA (world), Y
    STA $2007
    INY
    CPX #$03
    BNE :+
    CPY #$C0
    BEQ DoneLoadingWorld
:
    CPY #$00
    BNE LoadWorld
    INX
    INC world+1
    JMP LoadWorld

DoneLoadingWorld:
    LDX #$00

    LDA #$23
    STA $2006
    LDA #$C0
    STA $2006

    LDX #$00
SetAttributes:
    LDA #$AA ; or #$FF, #$00, or any pattern you like
    STA $2007
    INX
    CPX #$40
    BNE SetAttributes

    ; Initialize world to point to world data
    LDA #<WorldData2
    STA world
    LDA #>WorldData2
    STA world+1

    ; setup address in PPU for nametable data
    BIT $2002
    LDA #$28
    STA $2006
    LDA #$00
    STA $2006

    LDX #$00
    LDY #$00
LoadWorld2:
    LDA (world), Y
    STA $2007
    INY
    CPX #$03
    BNE :+
    CPY #$C0
    BEQ DoneLoadingWorld2
:
    CPY #$00
    BNE LoadWorld2
    INX
    INC world+1
    JMP LoadWorld2

DoneLoadingWorld2:
    LDX #$00

    LDA #$23
    STA $2006
    LDA #$C0
    STA $2006

    LDX #$00
    

shipblu_sprite:
    LDA shipblu, X
    STA $0200, X
    INX
    CPX #$18
    BNE shipblu_sprite
    LDX #$00

pizzaballsprite:
    LDA pizzaball, X
    STA $0218, X
    INX
    CPX #$04
    BNE pizzaballsprite 
    LDX #$00

lasersprite:
    LDA laser, X
    STA $021C, X
    INX
    CPX #$04
    BNE lasersprite
    LDX #$00 
    


; Enable interrupts
    CLI

    LDA #%10010000 ; enable NMI change background to use second chr set of tiles ($1000)
    STA $2000
    ; Enabling sprites and background for left-most 8 pixels
    ; Enable sprites and background
    LDA #%00011110
    STA $2001

Loop:
    JMP Loop