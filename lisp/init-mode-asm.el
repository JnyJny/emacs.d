;; asm-mode init

(add-hook 'asm-mode-hook 'asm-mode-fixup)

(defun asm-mode-fixup () 
  "Erik's asm-mode customizations."
  (local-set-key "\M-m" '(lambda () 
                           (interactive) 
                           (save-buffer) 
                           (compile "make -j2")))
  )
