;; Fixups

(defun c-mode-fixup () 
  "Erik's c-mode customizations."
  (local-set-key "\M-m" '(lambda () 
                           (interactive) 
                           (save-buffer) 
                           (compile "make")))
  (local-set-key "\C-c\C-f" 'c-comment-template-function)
  ;; make sure case labels are indented in one level from switches
  (setq c-offsets-alist (cons '(case-label . +) c-offsets-alist))
  )


;; C mode customization

(defun c-comment-template-function (funcname)
  "Insert a comment block to describe a C function."
  (interactive "sFunction Name: ") 
  (save-excursion
    (insert
     "/* NAME: " funcname "\n *\n * FUNCTION:\n *\n * RETURNS:\n */\n"))
  )

(defun c-comment-template-structure (structname structtype)
  "Insert a comment block to describe a C structure."
  (interactive "sStructure Name:\nsStructure Type: ")
  (save-excursion
    (insert 
     "/* NAME: "
     (if (> (chars-in-string structtype) 0)
	 (concat  structname ", " structtype)
       (concat structname))
     "\n *\n * METHODS:\n *\n * PURPOSE:\n *\n */\n"
     )
    (if (> (chars-in-string structtype) 0)
	(insert "typedef struct " structname "{\n\n} " structtype ";\n")
      (insert "struct " structname "{\n\n};")))
  )


(defun c-title ()
  "Places a title line of the form:
/* <filename> (<username>@<hostname>) <createdate> Modified: <changedate>*/
on the first line of a buffer invoked on.  Multiple invocations attempt to
just update the Modified time."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at (concat
		     (regexp-quote "/*") ".*"
		     (regexp-quote "Modified: " )))
	(put-title (concat (buffer-substring (point-min) (match-end 0))
			   (e-date t) " */") t)
      (put-title (concat "/* " (buffer-name) " (" (user-login-name ) "@"
			 (nth 0 
			      (split-string (system-name)
					    (regexp-quote ".")))
			 ") "
			 (e-date) " Modified: " (e-date t) " */\n") nil)
      )
    )
  )

(defun put-title (str &optional replace)
  "Put str on the first line of the current buffer."
  (save-excursion
    (goto-char (point-min))
    (insert str)
    (if replace (kill-line))
    )
  )
 
(defun e-date (&optional use-time)
  "Re-format the string returned by current-time-string to be:
DD Month YY (opt hh:mm)"
  (setq sp " ")
  (setq s (current-time-string))
  (concat (substring s 8 10) sp (substring s 4 7) sp (substring s 22 24)
	  sp (if use-time (concat sp (substring s 11 16))))
)


(defun asm-mode-fixup () 
  "Erik's asm-mode customizations."
  (local-set-key "\M-m" '(lambda () 
                           (interactive) 
                           (save-buffer) 
                           (compile "make -j2")))
  )

(defun java-mode-fixup ()
  "Erik's java-mode customizations."
  (setq c-basic-offset 2)
  (setq c-offsets-alist (cons '(case-label . +) c-offsets-alist))
  (local-set-key "\M-m" '(lambda ()
			   (interactive)
			   (save-buffer)
			   (cd (vc-find-root buffer-file-name "pom.xml"))
			   (compile-maven))))

(defun compilation-mode-fixup ()
  "Erik's compilation-mode customizations."
  (setq compilation-scroll-output 'first-error)
  (setq compilation-skip-threshod 2)
  )

(defun compile-maven ()
  "Traveling up the path, find a pom.xml and 'compile mvn'."
  (interactive)
  (when (locate-dominating-file default-directory "pom.xml")
    (with-temp-buffer
      (cd (locate-dominating-file default-directory "pom.xml"))
          (compile "mvn"))))

;; Markdown mode customization

(defun blog-metadata-template()
  "Insert blog post metadata."
  (save-excursion
    (goto-char (point-min))
    (insert "title: \n")
    (insert "date: " (current-time-string) "\n")
    (insert "author: " (user-full-name) "\n")
    (insert "category: \n")
    (insert "tags: \n")))

