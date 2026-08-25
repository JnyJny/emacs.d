;;; init-mode-json.el --- JSON editing support -*- lexical-binding: t; -*-

(defun eriko-json-mode ()
  "Choose the best available JSON major mode."
  (cond
   ((fboundp 'json-mode) 'json-mode)
   ((fboundp 'js-json-mode) 'js-json-mode)
   (t 'js-mode)))

(add-to-list 'auto-mode-alist `("\\.json\\'" . ,(eriko-json-mode)))
(add-to-list 'auto-mode-alist `("\\.jsonc\\'" . ,(eriko-json-mode)))

(defun eriko-jq-format-buffer ()
  "Format the current JSON buffer with jq."
  (interactive)
  (unless (executable-find "jq")
    (user-error "jq is not on exec-path"))
  (let ((input (buffer-substring-no-properties (point-min) (point-max)))
        (errbuf (get-buffer-create "*jq errors*"))
        formatted exit-code)
    (with-temp-buffer
      (insert input)
      (setq exit-code
            (call-process-region (point-min) (point-max)
                                 "jq" t t nil "."))
      (setq formatted (buffer-string)))
    (if (zerop exit-code)
        (progn
          (erase-buffer)
          (insert formatted)
          (message "Formatted buffer with jq"))
      (with-current-buffer errbuf
        (erase-buffer)
        (insert formatted))
      (display-buffer errbuf)
      (user-error "jq failed"))))

(add-hook 'js-json-mode-hook #'eriko-json-mode-fixup)
(add-hook 'js-mode-hook #'eriko-json-mode-fixup)
(add-hook 'json-mode-hook #'eriko-json-mode-fixup)

(defun eriko-json-mode-fixup ()
  "Erik's JSON mode customizations."
  (when (and buffer-file-name
             (string-match-p "\\.jsonc?\\'" buffer-file-name))
    (local-set-key (kbd "C-c C-f") #'eriko-jq-format-buffer)))

;;; init-mode-json.el ends here
