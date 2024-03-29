(load "~/.dg-bash-config/emacs/yaml-mode.el")

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(global-set-key "\C-R" 'recentf-open-files)


(setq visible-bell t)

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
      c-basic-offset 2)
(c-set-offset 'innamespace 0)

(setq-default indent-tabs-mode nil)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq column-number-mode t)

(add-hook 'c-mode-hook
          (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify ('start 'end))
	    ))

(add-hook 'c++-mode-hook
          (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify ('start 'end))
	    ))

(add-hook 'cc-mode-hook
          (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify ('start 'end))
	    ))

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 4)))

(add-hook 'python-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify ('start 'end))
	    ))
(add-hook 'xml-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify ('start 'end))
	    ))

(add-hook 'yaml-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)
	    (add-to-list 'write-file-functions 'untabify ('start 'end))
	    ))
(put 'upcase-region 'disabled nil)
