;;; init-mode-makefile.el --- Makefile mode customizations -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("Makefile.*\\'" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.mk" . makefile-mode))

;;; init-mode-makefile.el ends here
