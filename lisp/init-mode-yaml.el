;; init-yaml-mode

(add-to-list 'auto-mode-alist '("\\.yaml" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml" . yaml-mode))

(add-hook 'yaml-mode-hook 'yaml-mode-fixup)

(defun yaml-mode-fixup ()
  "Erik's yaml-mode customizations."
  )
