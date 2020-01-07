;; Copyright (C) 2020, Vi Grey
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;; ARE DISCLAIMED. IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;; OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;; LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;; OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;; SUCH DAMAGE.

RESET:
  sei
  cld
  ldx #$40
  stx $4017
  ldx #$FF
  txs
  inx
  lda #%00000110
  sta PPU_MASK
  lda #$00
  sta PPU_CTRL
  stx $4010
  ldy #$00


;;;;;;;;;;
;;
;; Initial VBlank Startup Wait
;;
;;;;;;;;;;

InitialVWait:
  ldx #$02
InitialVWaitLoop:
  lda PPU_STATUS
  bpl InitialVWaitLoop
    dex
    bne InitialVWaitLoop


;;;;;;;;;;
;;
;; CPU RAM to FCEUX
;;
;;;;;;;;;;

InitializeCPULoop:
  txa
  and #%00000100
  beq InitializeCPULoopContinue
    lda #$FF
InitializeCPULoopContinue:
  sta $0000, x
  sta $0100, x
  sta $0200, x
  sta $0300, x
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inx
  bne InitializeCPULoop


;;;;;;;;;;
;;
;; PPU RAM to FCEUX
;;
;;;;;;;;;;

InitializePPU:
  ldy #$08
  lda #$20
  sta PPU_ADDR
  txa
  sta PPU_ADDR
  tax
InitializePPULoop:
  sta PPU_DATA
  inx
  bne InitializePPULoop
    dey
    bne InitializePPULoop

InitializePalette:
  lda PPU_STATUS
  lda #$3F
  sta PPU_ADDR
  txa
  sta PPU_ADDR
InitializePaletteLoop:
  sta PPU_DATA
  inx
  cpx #$20
  bne InitializePaletteLoop


;;;;;;;;;;
;;
;; Cartridge Swap Infinite Loop Start
;;
;;;;;;;;;;

  ldx #$4C
  stx $0100
  inc $0102
  jmp STACK


;;;;;;;;;;
;;
;; CALLBACK Vectors
;;
;;;;;;;;;;

  .pad CALLBACK, #$FF

  .dw  0
  .dw  RESET
  .dw  0
