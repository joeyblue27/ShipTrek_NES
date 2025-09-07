.segment "HEADER"
.byte "NES"
.byte $1a
.byte $02 ; 2 * 16KB PRG ROM
.byte $01 ; 1 * 8KB CHR ROM
.byte %00000000 ; mapper and mirroring
.byte $00
.byte $00
.byte $00
.byte $00
.byte $00, $00, $00, $00, $00 ; filler bytes
.segment "ZEROPAGE" ; LSB 0 - FF
controls: .res 1
controls_d: .res 1
temp00: .res 1
temp01: .res 1
shipblu_x:  .res 1
shipblu_y:  .res 1
pizzaball_x: .res 1
pizzaball_y: .res 1
pizzaball_dir: .res 1 ; 0 = right, 1 = left
laser_x: .res 1
laser_y: .res 1
laser_active: .res 1
world: .res 2
coarse_y:   .res 1   ; 0–29 (tile rows)
fine_y:     .res 1   ; 0–7  (pixels inside a tile row)
nt_y:       .res 1   ; vertical nametable bit (0 or 1)
pizza_color_index: .res 1
pizza_timer: .res 1


.segment "STARTUP"
Reset:
    SEI ; Disables all interrupts
    CLD ; disable decimal mode

    ; Disable sound IRQ
    LDX #$40
    STX $4017

    ; Initialize the stack register
    LDX #$FF
    TXS

    INX ; #$FF + 1 => #$00
    
    :
    BIT $2002
    BPL :-

    :
    BIT $2002
    BPL :-

    ; Zero out the PPU registers
    STX $2000
    STX $2001

    STX $4010



CLEARMEM:
    STA $0000, X ; $0000 => $00FF
    STA $0100, X ; $0100 => $01FF
    STA $0300, X
    STA $0400, X
    STA $0500, X
    STA $0600, X
    STA $0700, X
    LDA #$FF
    STA $0200, X ; $0200 => $02FF
    LDA #$00
    INX
    BNE CLEARMEM    
; wait for vblank
:


.include "sprite_coordinates.s"
.include "sprite_render.s"
.include "scroll_screen.s"
.include "ship_controls.s"
.include "sprite_display.s"
.include "laser_fire.s"
.include "rival_spawn.s"
.include "controllers.s"
.include "color_flicker.s"  
.include "byte_tables.s"  

.segment "VECTORS"
    .word NMI
    .word Reset
    .word 0
    
.segment "CHARS"
    .incbin "game.chr"
    