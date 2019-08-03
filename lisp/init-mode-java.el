;; init-java-mode

(add-hook 'java-mode-hook 'java-mode-fixup)

(defun java-mode-fixup ()
  "Erik's java-mode customizations."
  (setq c-basic-offset 2)
  (setq c-offsets-alist (cons '(case-label . +) c-offsets-alist))
  (local-set-key "\M-m" '(lambda ()
			   (interactive)
			   (save-buffer)
			   (cd (vc-find-root buffer-file-name "pom.xml"))
			   (compile-maven))))

(defun compile-maven ()
  "Traveling up the path, find a pom.xml and 'compile mvn'."
  (interactive)
  (when (locate-dominating-file default-directory "pom.xml")
    (with-temp-buffer
      (cd (locate-dominating-file default-directory "pom.xml"))
          (compile "mvn"))))
