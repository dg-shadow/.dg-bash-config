(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-R" 'recentf-open-files)
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.xacro\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.urdf\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.srdf\\'" . xml-mode))
(when (display-graphic-p)
    (server-mode))
