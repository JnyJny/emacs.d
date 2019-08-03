
;; NMSU stuff that I've grown used to.. 

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
  (setq line (buffer-substring
              (save-excursion (beginning-of-line) (point))
              (save-excursion (end-of-line) (point))))
  (if (eq last-command 'kill-region)
      (kill-append line)
    (setq kill-ring (cons line kill-ring))
    (if (> (length kill-ring) kill-ring-max)
    (setcdr (nthcdr (1- kill-ring-max) kill-ring) nil))
  )
  (setq this-command 'kill-region)
  (setq kill-ring-yank-pointer kill-ring)
)

(defun kill-backward-character()
  "kill instead of delete character"
  (interactive)
  (delete-backward-char 1 t))
	
(defun kill-forward-character()
  "kill instead of delete character"
  (interactive)
  (delete-backward-char -1 t))

(defun count-region (start end)
  "Count lines, words and characters in region."
  (interactive "r")
  (let ((l (count-lines start end))
	(w (count-words start end))
	(c (- end start)))
    (message "Region has %d line%s, %d word%s and %d character%s."
	     l (if (= 1 l) "" "s")
	     w (if (= 1 w) "" "s")
	     c (if (= 1 c) "" "s"))))

(defun count-words (start end)
  "Return number of words between START and END."
  (let ((count 0))
    (save-excursion
      (save-restriction
	(narrow-to-region start end)
	(goto-char (point-min))
	(while (forward-word 1)
	  (setq count (1+ count)))))
    count))


