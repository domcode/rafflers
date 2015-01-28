        >>source format is free
IDENTIFICATION DIVISION.
    PROGRAM-ID. DOMCODE-RAFFLER.
    AUTHOR. Lucas van Lierop.

data division.
    working-storage section.
        01 file-name PIC x(50).
PROCEDURE DIVISION.
    DISPLAY 'Ready to raffle!'.
    PERFORM 100-INITIALIZE.
STOP RUN.

100-INITIALIZE.
    ACCEPT file-name FROM ARGUMENT-VALUE
        ON EXCEPTION
            DISPLAY
                "Attempt to read beyond end of command line"
                UPON SYSERR
            END-DISPLAY
        NOT ON EXCEPTION
            DISPLAY
                "reading " file-name
            END-display
    END-ACCEPT.
