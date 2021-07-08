       PROGRAM MAIN
            CHARACTER(40) :: Filename
            CHARACTER(100) :: Winner
            REAL, DIMENSION(:), ALLOCATABLE :: filecontents
            REAl :: random
            INTEGER :: ITER, NUMLINES, WinnerLine, eof, n, un, istat
            integer, allocatable :: seed(:)
            INTEGER, PARAMETER :: maxlines = 10000
            CHARACTER(LEN=1) :: junk

            !get filename from input arg
            call get_command_argument(1, Filename)

            !Determine total number of lines in file
            NUMLINES = 0
            OPEN(UNIT=1,FILE=Filename)
            DO ITER=1,maxlines
              READ(1,*,IOSTAT=eof) junk
              IF (eof /= 0) EXIT
              IF (ITER == maxlines) THEN
                PRINT*, "Error: Max number of lines (10,000)exceeded."
                PRINT*, "Exiting program now :( ..."
                STOP
              ENDIF
              NUMLINES = NUMLINES + 1
            ENDDO

            ! Rewind file so we can read it again...
            REWIND(1)

            ! Set up the random_seed to be something random
            ! There is a reason I don't write FORTRAN :O
            call random_seed(size = n)
            allocate(seed(n))
      open ( newunit=un, file='/dev/urandom', action='read',
     $       form='unformatted', access='stream', status='old' )
            read(un) seed
            close(un)

            call random_seed(put=seed)
            call random_number(random)

            ! We read the next line so no need for offset, helps with
            ! 0 vs 1 based indexes ughhh
            WinnerLine = FLOOR(NUMLINES*random)

            ! Read the amount of lines up to the line containing the
            ! winner
            DO ITER=1,WinnerLine
              READ(1,'(A)')
            ENDDO

            ! Read the line containing the winner
            READ(1,'(A)') Winner

            ! **PARTY**
            PRINT*, "Ladies and Gentlemen, the winner is: " // Winner
       END PROGRAM MAIN
