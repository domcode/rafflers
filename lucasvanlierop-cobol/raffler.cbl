        >>source format is free
identification division.
    program-id. domcode-raffler.
    author. Lucas van Lierop.
      *> =============================================
      *> 1) read a file and pick a name for the raffle
      *> =============================================
      *> cobc raffler.cbl -free -x -0
      *> ./raffler {filename}
      *> =============================================

environment division.
    input-output section.
       file-control.
           select names-file
               assign to names-file-name
               file status is names-file-status
               organization is line sequential.

data division.
    file section.
        fd names-file.
        01 names-record pic x(80).

    working-storage section.
        01 names-file-name pic x(50).
        01 names-file-status pic x(2).
        01 names-count pic 9(9) value zero.

       01  name-columns.
           03  name pic x(32).

       01  display-count pic z,zzz,zzz.

procedure division.
    display 'ready to raffle!'.
    perform 100-initialize.
       perform 110-read-input-file.

stop run.

100-initialize.
    accept names-file-name from argument-value
        on exception
            display
                "attempt to read beyond end of command line"
                upon syserr
            end-display
        not on exception
            display
                "reading " names-file-name
            end-display
    end-accept.

110-read-input-file.
    open input names-file

           read names-file

           perform until names-file-status = '10'
               add 1 to names-count

               unstring names-record delimited by ',' into
                   name

               read names-file
           end-perform

           close names-file

           move names-count to display-count
           display display-count space 'names'
           .
