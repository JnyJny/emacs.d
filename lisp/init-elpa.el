;;; init-elpa.el --- Package archive setup -*- lexical-binding: t; -*-

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(setq package-archive-priorities
      '(("gnu" . 20)
        ("nongnu" . 10)
        ("melpa" . 0)))
(setq package-enable-at-startup nil)
(package-initialize)

;;; init-elpa.el ends here
