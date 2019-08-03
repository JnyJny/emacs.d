;; init-csa-mode

;; Create a variant of Assember mode for editing csa assembler
(define-derived-mode csa-asm-mode asm-mode "csa-asm" ()
  "Asm mode for editing CSA assembly using '#' comment delimiter."
  (set (make-local-variable 'comment-start) "#") ; Comment character = #
  (set (make-local-variable 'comment-style) 'plain)
  (local-set-key ";" 'self-insert-command) ; Kill special meaning for ;
  (modify-syntax-entry 59 ".")  ; Font-lock ;  = normal punctuation
  (modify-syntax-entry 35 "<")  ; Font-lock #  = start of comment
  (modify-syntax-entry 10 ">")  ; Font-lock \n = end of comment
  )

(add-to-list 'auto-mode-alist '("/csa.*/.*\\.s$" . csa-asm-mode))
