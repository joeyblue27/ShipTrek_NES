palletes:
  .byte $0F,$1b,$2b,$37,$0F,$05,$16,$27,$0F,$22,$01,$10,$0F,$2D,$11,$22  ;background palette data
  .byte $0F,$1b,$2b,$37,$0F,$06,$16,$26,$0F,$0C,$31,$32,$0F,$1c,$36,$27  ;sprite palette data

WorldData:
  .incbin "maps/ntable1a.map"  
  
WorldData2:
  .incbin "maps/ntable1b.map" 

shipblu:
  .byte $08, $10, $00, $08
  .byte $08, $11, $00, $10
  .byte $10, $20, $00, $08
  .byte $10, $21, $00, $10
  .byte $18, $30, $00, $08
  .byte $18, $31, $00, $10

pizzaball:
  .byte $08, $60, $01, $08
  .byte $08, $61, $01, $10
  .byte $10, $70, $01, $08
  .byte $10, $71, $01, $10

laser:
  .byte $08, $23, $02, $08
  
