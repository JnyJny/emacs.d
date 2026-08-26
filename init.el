;;; init.el --- Erik's Emacs configuration -*- lexical-binding: t; -*-

(setq user-full-name "Erik O'Shaughnessy")
(setq user-mail-address "erik.oshaughnessy@gmail.com")



(require 'seq)
(require 'subr-x)

(defvar eriko-exec-path-dirs
  '("/Users/eriko/.local/bin"
    "/Users/eriko/.cargo/bin"
    "/opt/homebrew/sbin"
    "/opt/homebrew/bin")
  "Executable search paths to prefer inside Emacs.")

(let ((dirs (seq-filter #'file-directory-p eriko-exec-path-dirs)))
  (setq exec-path
        (append dirs (seq-remove (lambda (dir) (member dir dirs)) exec-path)))
  (setenv "PATH"
          (string-join
           (delete-dups (append dirs (parse-colon-path (getenv "PATH"))))
           path-separator)))

(add-to-list 'load-path
	     (expand-file-name "lisp" user-emacs-directory))

(load "init-elpa.el")
(load "init-global.el")
(load "init-misc.el")
(load "init-bindings.el")
(load "init-mode-c.el")
(load "init-mode-python.el")
(load "init-mode-rust.el")
(load "init-mode-json.el")
(load "init-mode-markdown.el")
(load "init-mode-java.el")
(load "init-mode-compilation.el")
(load "init-mode-makefile.el")
(load "init-mode-yaml.el")


(add-to-list 'auto-mode-alist '("Jenkinsfile" . groovy-mode))

;; Automatically makes buffers with shebangs executable
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cargo-mode csv-mode dockerfile-mode groovy-mode markdown-mode
		ruff-format rust-auto-use rust-mode toml-mode use-package
		yaml-mode))
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4)
 '(warning-suppress-log-types '((auto-save))))
 

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(mode-line ((t (:background "orange" :foreground "black" :box (:line-width -1 :style released-button))))))

;;; init.el ends here
