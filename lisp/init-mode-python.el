;;; init-mode-python.el --- Python editing support -*- lexical-binding: t; -*-

(require 'eglot)

(declare-function ruff-format-on-save-mode "ruff-format" (&optional arg))

(defun eriko-python-eglot-server ()
  "Return the preferred Python language-server command for this host."
  (cond
   ((executable-find "basedpyright-langserver")
    '("basedpyright-langserver" "--stdio"))
   ((executable-find "pyright-langserver")
    '("pyright-langserver" "--stdio"))
   ((executable-find "ruff")
    '("ruff" "server"))))

(let ((server (eriko-python-eglot-server)))
  (when server
    (add-to-list 'eglot-server-programs
                 `((python-mode python-ts-mode) . ,server))))

(add-hook 'python-mode-hook #'python-mode-fixup)
(add-hook 'python-ts-mode-hook #'python-mode-fixup)

(defun python-mode-fixup ()
  "Erik's Python mode customizations."
  (setq-local python-indent-guess-indent-offset nil)
  (setq-local python-indent-offset 4)
  (when (and (executable-find "ruff")
             (require 'ruff-format nil t))
    (ruff-format-on-save-mode 1))
  (when (eriko-python-eglot-server)
    (eglot-ensure)))

;;; init-mode-python.el ends here
