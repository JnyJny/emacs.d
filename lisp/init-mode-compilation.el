;;; init-mode-compilation.el --- Compilation buffer behavior -*- lexical-binding: t; -*-

(add-hook 'compilation-mode-hook #'compilation-mode-fixup)

(defun compilation-mode-fixup ()
  "Erik's compilation-mode customizations."
  (setq compilation-scroll-output 'first-error)
  (setq compilation-skip-threshold 2))

;;; init-mode-compilation.el ends here
