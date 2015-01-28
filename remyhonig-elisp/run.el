;;; run.el --- Elisp Raffler example

;;; Commentary:
;; Example output:
;;
;;   bash-3.2$ emacs --script run.el "../example_names"
;;   Miracle Max
;;
;;   bash-3.2$ emacs --script run.el "../example_namesa"
;;   Opening input file: no such file or directory, /Users/rhonig/Development/rafflers/example_namesa
;;
;;   bash-3.2$ emacs --script run.el
;;   No filename selected

;;; Code:

(let ((filename (car argv)))
  (if (null filename)
      (message "No filename selected")
    (let ((names (with-temp-buffer
                    (insert-file-contents filename)
                    (split-string (buffer-string) "\n" t))))
      (message (nth (random (length names)) names)))))
