;;; init-mode-rust.el --- Rust editing support -*- lexical-binding: t; -*-

(require 'eglot)

(declare-function cargo-minor-mode "cargo-mode" (&optional arg))

(when (require 'rust-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (add-hook 'rust-mode-hook #'eriko-rust-mode-fixup))

(defun eriko-rust-mode-fixup ()
  "Erik's Rust mode customizations."
  (when (require 'cargo-mode nil t)
    (cargo-minor-mode 1))
  (setq-local rust-format-on-save t)
  (when (executable-find "rust-analyzer")
    (eglot-ensure)))

;;; init-mode-rust.el ends here
