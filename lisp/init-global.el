;;; init-global.el --- Global editing defaults -*- lexical-binding: t; -*-

(require 'autorevert)

;; Tune the GC
;; The default settings are too conservative on modern machines making Emacs
;; spend too much time collecting garbage in alloc-heavy code.
(setq gc-cons-threshold (* 4 1024 1024))
(setq gc-cons-percentage 0.3)

;; turn stuff off
(setq inhibit-splash-screen t)
(if (fboundp 'menu-bar-mode)(menu-bar-mode 0))
(if (fboundp 'tool-bar-mode)(tool-bar-mode 0))
(blink-cursor-mode nil)
(setq mouse-yank-at-point 't)
(fset 'yes-or-no-p 'y-or-n-p)
(setenv "PAGER" "cat")			;; disable less in async buffers
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")

(setq create-lockfiles nil)
(setq make-backup-files nil)

(setopt completion-styles '(basic flex partial-completion))

(let ((auto-save-dir (file-name-as-directory
                      (expand-file-name "autosave" user-emacs-directory)))
      (backup-dir (file-name-as-directory
                   (expand-file-name "backups" user-emacs-directory))))
  (make-directory auto-save-dir t)
  (make-directory backup-dir t)
  (setq auto-save-list-file-prefix (expand-file-name ".saves-" auto-save-dir))
  (setq auto-save-file-name-transforms `((".*" ,auto-save-dir t)))
  (setq backup-directory-alist `((".*" . ,backup-dir))))

(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)

;; turn stuff on
(display-time-mode t)
(global-font-lock-mode t)
(column-number-mode t)
(setq visible-bell t)
(mapc (lambda (command) (put command 'disabled nil))
      '(erase-buffer
	downcase-region
	upcase-region
	upcase-initials-region))

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;;; init-global.el ends here
