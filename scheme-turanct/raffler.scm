#!/usr/local/bin/guile -s
!#

(use-modules (ice-9 rdelim))

(set! *random-state* (random-state-from-platform))

(define (get-filename-from-cli)
  (car (reverse (command-line))))

(define (get-lines-from-file filename)
  (let ((file-handler (open-input-file filename)))
    (let read-loop ((lines (list)))
      (let ((line (read-line file-handler)))
        (if (eof-object? line)
          (reverse lines)
          (read-loop (cons line lines)))))))

(define (get-random-line lines)
  (list-ref lines (random (length lines))))

(display (get-random-line (get-lines-from-file (get-filename-from-cli))))
(newline)
