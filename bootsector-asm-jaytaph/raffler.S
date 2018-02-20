[bits 16]
[org 0x7C00]

    jmp StartOfBoot

    ; Some constraints: fat12 numbers are hardcoded, not calculated. Thus this won't work
    ; with different data. Might be doable to fix though.

    ; BIOS Parameter Block (fat12 info)
        BPB_Name                db 'RAFFLER '
        BPB_BytesPerSector      dw 512
        BPB_SectorsPerCluster   db 1
        BPB_ReservedSectorCount dw 1
        BPB_FatTables           db 2
        BPB_MaxRootDirEntries   dw 224
        BPB_TotalSectors        dw 2880
        BPB_MediaDescriptor     db 0xF0     ; 1.44MB
        BPB_SectorsPerFAT       dw 9
        BPB_SectorsPerTrack     dw 18
        BPB_NumberOfHeads       dw 2
        BPB_HiddenSectors       dd 0
        BPB_TotalSectors32      dd 0
        BPB_DriveNumber         db 0
        BPB_Reserved1           db 0
        BPB_BootSignature       db 0x29
        BPB_VolumeID            dd 0xDEADBEEF
        BPB_VolumeLabel         db 'RAFFLER    '
        BPB_FileType            db 'FAT12   '


        ; Nice message to print
        RafflerMsg      db  'RafflerOS: ', 0

        ; FAT12 filename of the username file
        UserFileName    db  'NAMES   DAT'

        ; Size of the file (filled in later)
        UserFileSize    dw  0

        ; initial seed
        Seed            dw 0x3749

StartOfBoot:
        ; Setup data and stack segment
        cli
        xor     ax, ax
        mov     ds, ax
        mov     es, ax
        mov     ss, ax
        mov     sp, 7C00h
        sti




        ; Print welcome message
        mov     si, RafflerMsg
        call WriteMsg



        ; Load fat info
        mov     bx, 0x8000          ; Start at 0x8000
        mov     ax, 1
        mov     di, 18              ; BPB_FatTables * BPB_SectorsPerFAT
        call    ReadSectors



        ; Load root directory entries
        mov     bx, 0xA400          ; 0x8000 + (BPB_FatTables * BPB_SectorsPerFAT * BPB_BytesPerSector)
        mov     ax, 19              ; 1 + BPB_FatTables * BPB_SectorsPerFAT
        mov     di, 14              ; BPB_MaxRootDirEntries * 32 / BPB_BytesPerSector
        call    ReadSectors



        ; Locate the file in the directory entries
        cld
        mov     di, 0xA400          ; Start of directory entry
searchFile:
        mov     si, UserFileName    ; Check against filename for 11 bytes
        mov     cx, 11
        push    di
        rep     cmpsb
        pop     di
        je      fileFound
        add     di, 32              ; Check next entry
        cmp     di, 0xC000          ; BPB_MaxRootDirEntries * 32, maximum number of entries (1C00 + A400)
        jbe     searchFile
        jmp     $                   ; File not found. Hang system
fileFound:
        ; DI points to actual file directory entry



        ; Store filesize for later use
        mov     ax, [di + 0x1C]     ; Size of the file
        mov     [UserFileSize], ax



        ; Load actual file clusters
        mov     bx, 0xC000

        mov     ax, [di + 0x1A]     ; Here starts FAT clusters
loadClusters:
        push    ax
        call    ReadCluster
        pop     ax
        add     bx, 512             ; Next sector
        push    bx
        mov     bx, ax
        shr     bx, 1
        add     bx, ax
        mov     dx, [0x8000 + bx]
        pop     bx
        test    ax, 0x01
        jnz     oddCluster
evenCluster:
        and     dx, 0x0FFF
        jmp     testCluster
oddCluster:
        shr     dx, 4
testCluster:
        cmp     dx, 0xFF0
        mov     ax, dx
        jb      loadClusters



        ; Increase seed with RTC. It's a horrible way, but fits in our bootsector
        xor     ax, ax
        int     0x1A
        add     [Seed], dl



        ; Call our randomizer to find a random number
        call    Random
        and     ax, 0x00FF      ; Only randomize between 0..255
        mov     bx, ax


        ; Iterate the file, decreasing our random number on every LF we find
        mov     si, 0xC000          ; DI points to start of the file
        mov     di, si
        add     di, [UserFileSize]  ; DX points to the end of the file

        mov     ah, 0x0A            ; Add a 0x0A at the end of the file, in case there isn't one
        mov     byte [di], ah
nextName:
        dec     bl                  ; Decrease random number
        jz      nameDone            ; reached 0, end of the raffle
nextChar:
        lodsb                       ; Load char from ES:DI into AL from file
        cmp     si, di              ; Are we at the end of the file
        jl      noWrap
        mov     si, 0xC000          ; Wrap back to the start of the file
noWrap:
        cmp     al, 0x0A
        je      nextName            ; Did we find a 0x0A (LF), if so we found another name
        jmp     nextChar
nameDone:
        ; SI points to the name we need to print. Find the 0x0A at the end, change to 0x00 and print the string



        ; Locate next LF, and replace with 0, so we can print it
        push    si
findLF:
        inc     si
        mov     al, 0x0A
        cmp     al, [si]
        jne     findLF
        mov     byte [si], 0x00
        pop    si



        ; Write SI, which is the randomized user
        call    WriteMsg



        ; All done. Freeze!
        jmp     $





ReadSectors:
        push    ax
        call    ReadSector
        pop     ax
        add     bx, 512
        inc     ax
        dec     di
        jnz     ReadSectors
        ret

ReadSector:
        mov     bp, sp      ; Save room on stack (for CHS data)
        sub     sp, 8
        mov     si, 18      ; BPB_SectorsPerTrack
        xor     dx, dx      ; Calculate CHS
        div     si
        inc     dl
        mov     [bp-1], dl
        mov     si, 2
        xor     dx, dx
        div     si
        mov     [bp-2], dl
        mov     [bp-4], ax
        mov     al, 1           ; Load one sector
        mov     ch, [bp-4]      ; Cylinder
        mov     dh, [bp-2]      ; Head
        mov     cl, [bp-1]      ; Sector
        mov     dl, 0           ; First disk
        mov     ah, 2
        int     0x13            ; Load sector
        mov     sp, bp
        ret


ReadCluster:
        sub     ax, 0x02
        xor     cx, cx
        mov     cl, 1
        mul     cx
        add     ax, 33          ; Actual start sector of data
        call    ReadSector
        ret


; --------------------------------------------------------------------------------
; Not a very good randomizer, but suits our purpose, and is small enough
Random:
        mov     ax, [Seed]
        mov     dx, 0x8405
        mul     dx

        cmp     ax, [Seed]
        jnz     gotSeed
        mov     ah, dl
        inc     ax
gotSeed:
        mov     [Seed], ax
        mov     ax, dx
        ret


; ------------------------------------------------------------------------
; Writes a message on screen.
;  In: DS:SI -> Message offset
WriteMsg:
        lodsb                              ; Get char and point to the next
        cmp     al, 0                      ; 0 byte?
        jz      EndWriteMsg                ; Yes, break the loop

        mov     ah, 0x0E                   ; Print char AL on screen
        mov     bx, 0x0007
        int     0x10                       ; Using BIOS routines

        jmp     WriteMsg                   ; And loop
EndWriteMsg:
        ret




        ; Pad with nops until offset 510
        times 510-($-$$) db 0x90

        ; Boot sector must be closed with 0xAA55
        dw 0xAA55
