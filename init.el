;; .emacs

(setq user-full-name "Erik O'Shaughnessy")
(setq user-mail-address "erik.oshaughnessy@gmail.com")



(setq exec-path (append (list "/usr/local/bin") exec-path))

(add-to-list 'load-path
	     (expand-file-name "lisp" user-emacs-directory))

(load "init-elpa.el")
(load "init-global.el")
(load "init-misc.el")
(load "init-bindings.el")
(load "init-mode-c.el")
(load "init-mode-asm.el")
(load "init-mode-python.el")
(load "init-mode-markdown.el")
(load "init-mode-html.el")
(load "init-mode-csa.el")
(load "init-mode-java.el")
(load "init-mode-compilation.el")
(load "init-mode-makefile.el")
(load "init-mode-yaml.el")
(load "init-themes.el")


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
   (quote
    (python-mode elpy blacken toml-mode csv-mode dockerfile-mode markdown-mode yaml-mode groovy-mode use-package)))
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4))
 

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(mode-line ((t (:background "red" :foreground "yellow" :box (:line-width -1 :style released-button))))))
