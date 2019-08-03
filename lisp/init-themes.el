

(setq custom-safe-thems t)
(setq custom-theme-directory
      (expand-file-name "conf" user-emacs-directory))

(defun disable-all-themes ()
  "Disable all active themes."
  (interactive)
  (dolist (target custom-enabled-themes)
    (disable-theme target)))

