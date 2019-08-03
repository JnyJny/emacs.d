;; init-elpa

(require 'package)

(setq package-archives '(
                        ("elpa" . "http://tromey.com/elpa/")
                        ("gnu" . "http://elpa.gnu.org/packages/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
			("melpa" . "http://melpa.org/packages/")
                        ("melpa-stable" . "http://stable.melpa.org/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)
