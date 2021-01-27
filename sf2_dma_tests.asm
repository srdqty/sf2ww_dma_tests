 org  0
  incbin  "build\sf2.bin"
   
 org $8D1
  dc.b "123  "
   
 org $000A54
  jmp main

 ; Don't fade out test screen 
 org $000984
;   NOP
;   NOP
 
 ; Free space
 org $0E0000
main:
; Fix palette brightness
  movea.l	#$900000, A0
  move.l	#$F000F000, D0
  moveq		#0, D1
  move.b	#$80, D1
palette_brightness_loop:
  or.l		D0, (A0)+
  or.l		D0, (A0)+
  or.l		D0, (A0)+
  or.l		D0, (A0)+
  or.l		D0, (A0)+
  or.l		D0, (A0)+
  or.l		D0, (A0)+
  or.l		D0, (A0)+
  dbeq		D1, palette_brightness_loop
; end of brightness fix

  moveq #$0, D0
  move.w #$4f0, D0
  movea.l #$00910000, A0
  movea.l #sf2_objects_2, A1
  
  bsr upload_gfx

  move.w #$4f0, D0
  movea.l #$00918000, A0
  movea.l #sf2_objects, A1
  
  bsr upload_gfx
  
loop:
  
  move.w  #$9100, ($2a,A5)
  move.w  #$9180, ($2a,A5)

  bra loop
  
  
;-----------------
upload_gfx:
  move.b  (A1, D0.w), D1
  move.b  D1, (A0, D0.w)
  dbra D0, upload_gfx
  rts
;-----------------
  
  
sf2_objects:
  incbin "sf2_objects_1.bin"
 
sf2_objects_2:
  incbin "sf2_objects_2.bin"
 