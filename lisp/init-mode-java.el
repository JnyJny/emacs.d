;;; init-mode-java.el --- Java mode customizations -*- lexical-binding: t; -*-

(add-hook 'java-mode-hook #'java-mode-fixup)

(defun java-mode-fixup ()
  "Erik's java-mode customizations."
  (setq-local c-basic-offset 2)
  (c-set-offset 'case-label '+)
  (local-set-key "\M-m" (lambda ()
                          (interactive)
                          (save-buffer)
                          (compile-maven))))

(defun compile-maven ()
  "Travel up the path, find a pom.xml, and compile with mvn."
  (interactive)
  (let ((root (locate-dominating-file default-directory "pom.xml")))
    (if root
        (let ((default-directory root))
          (compile "mvn"))
      (user-error "No pom.xml found above %s" default-directory))))

;;; init-mode-java.el ends here
