;;; init-misc.el --- Small inherited editing commands -*- lexical-binding: t; -*-

;; NMSU stuff that I've grown used to.

(defun kill-current-line ()
  "Kill the current line."
  (interactive)
  (kill-region 
   (progn (beginning-of-line)
	  (point))
   (progn (end-of-line)
	  (point))))

(defun copy-line-as-kill ()
  "Save the line as if killed, but don't kill it."
  (interactive)
  (let ((line (buffer-substring-no-properties
               (line-beginning-position)
               (line-end-position))))
    (if (eq last-command 'kill-region)
        (kill-append line nil)
      (kill-new line)))
  (setq this-command 'kill-region)
  (setq kill-ring-yank-pointer kill-ring))

(defun copy-region-to-pasteboard (start end)
  "Copy the region from START to END to the macOS pasteboard."
  (interactive "r")
  (unless (executable-find "pbcopy")
    (user-error "pbcopy not found"))
  (let ((status (call-process-region start end "pbcopy" nil nil nil)))
    (unless (zerop status)
      (user-error "pbcopy failed with status %s" status)))
  (deactivate-mark)
  (message "Copied region to pasteboard"))

(defun kill-backward-character()
  "kill instead of delete character"
  (interactive)
  (delete-char -1 t))
	
(defun kill-forward-character()
  "kill instead of delete character"
  (interactive)
  (delete-char 1 t))

(defun count-region (start end)
  "Count lines, words and characters in region."
  (interactive "r")
  (let ((l (count-lines start end))
	(w (eriko-count-words start end))
	(c (- end start)))
    (message "Region has %d line%s, %d word%s and %d character%s."
	     l (if (= 1 l) "" "s")
	     w (if (= 1 w) "" "s")
	     c (if (= 1 c) "" "s"))))

(defun eriko-count-words (start end)
  "Return number of words between START and END."
  (let ((count 0))
    (save-excursion
      (save-restriction
	(narrow-to-region start end)
	(goto-char (point-min))
	(while (forward-word 1)
	  (setq count (1+ count)))))
    count))

;;; init-misc.el ends here
