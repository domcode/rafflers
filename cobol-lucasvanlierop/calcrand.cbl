identification division.
    program-id. calcrand.
    author. arnold.tremble.

data division.
    working-storage section.

       01  ws-first-time               pic 9(1) value 0.
       01  ws-rnd-seed-x               pic x(8).
       01  ws-rnd-seed-9               redefines ws-rnd-seed-x
                                       pic 9(8).
       01  ws-rnd-dbl                  comp-2.
       01  ws-rnd-int                  pic x(1) comp-x.

       linkage section.

       01  ls-max                      pic 9(3).
       01  ls-result                   pic 9(3).

procedure division using
    ls-max
    ls-result.

      *> -- Generate the random seed value.

           if ws-first-time = 0

              move 32768 to ws-rnd-seed-9

              perform until ws-rnd-seed-9 < 32768
                 accept ws-rnd-seed-x from time
                 move function reverse(ws-rnd-seed-x) to ws-rnd-seed-x
                 compute ws-rnd-seed-9 = ws-rnd-seed-9 / 3060
              end-perform

              compute ws-rnd-dbl = function random(ws-rnd-seed-9)
              move 1 to ws-first-time

           end-if.

      *> -- Generate a random number between 1 and LS-Max.

           compute ws-rnd-dbl = function random().
           compute ws-rnd-int = ws-rnd-dbl * ls-max.
           move ws-rnd-int to ls-result.
           add 1 to ls-result.

           exit program.
           stop run.
