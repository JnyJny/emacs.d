;; init-compilation-mode

(add-hook 'compilation-mode-hook 'compilation-mode-fixup)

(defun compilation-mode-fixup ()
  "Erik's compilation-mode customizations."
  (setq compilation-scroll-output 'first-error)
  (setq compilation-skip-threshod 2)
  )
