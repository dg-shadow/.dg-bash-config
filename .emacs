(load "~/.dg-bash-config/emacs/yaml-mode.el")

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(global-set-key "\C-R" 'recentf-open-files)


(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.xacro\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.urdf\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.srdf\\'" . xml-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


(load "server")
(when (display-graphic-p)
  (unless (server-running-p)
    (server-mode)))

(setq c-default-style "bsd"
      c-basic-offset 4)

(setq-default indent-tabs-mode nil)


(add-hook 'c-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify)
	    ))
(add-hook 'python-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify)
	    ))
(add-hook 'xml-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify)
	    ))

(add-hook 'yaml-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify)
	    ))
