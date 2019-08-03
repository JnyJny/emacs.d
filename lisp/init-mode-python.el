;; Python indention

(add-hook 'python-mode-hook 'python-mode-fixup)

(defun python-mode-fixup ()
  "Erik's python-mode customizations."

  (local-set-key "\C-x\C-x" 'python-blacken-and-save)
  )

(defun python-blacken-and-save ()
  "Run blacken on the current buffer and then save the buffer."
  (interactive)
  (blacken-buffer t)
  (save-buffer))

