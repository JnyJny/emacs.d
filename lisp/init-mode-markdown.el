;; init-markdown-mode

(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

(add-hook 'markdown-mode-hook 'markdown-mode-fixup)

(defun markdown-mode-fixup ()
  "Erik's markdown-mode customizations."
  (local-set-key "\M-b" 'blog-metadata-update)
  )

(defun blog-metadata-update()
  "Insert blog post metadata."
  (save-excursion
    (goto-char (point-min))
    (insert "title: \n")
    (insert "date: " (current-time-string) "\n")
    (insert "author: " (user-full-name) "\n")
    (insert "category: \n")
    (insert "tags: \n")))

(defun blog-metadata-update-modified ()
  ""
  )
