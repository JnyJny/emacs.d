;;; init-mode-python.el --- Python editing support -*- lexical-binding: t; -*-

(require 'eglot)
(require 'project)
(require 'treesit)

(declare-function completion-preview-mode "completion-preview" (&optional arg))
(declare-function ruff-format-on-save-mode "ruff-format" (&optional arg))

(add-to-list 'treesit-language-source-alist
             '(python "https://github.com/tree-sitter/tree-sitter-python"))

(when (boundp 'treesit-enabled-modes)
  (setopt treesit-auto-install-grammar 'ask
          treesit-enabled-modes '(python-ts-mode)))

(setq eglot-watch-files-outside-project-root nil)

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
  (when (fboundp 'completion-preview-mode)
    (completion-preview-mode 1))
  (when (and (eriko-python-eglot-server)
             (project-current nil))
    (eglot-ensure)))

;;; init-mode-python.el ends here
