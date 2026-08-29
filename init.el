(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq telega-server-libs-prefix "/usr/local")

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(require 'nov)

(unless (package-installed-p 'telega)
(package-refresh-contents)
(package-install 'telega))

(load-theme 'manoj-dark t)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq select-enable-clipboard t)
(setq clipboard-tool "wl-copy")

(use-package evil
:ensure t
:init
(setq evil-want-keybinding nil)
:config
(evil-mode 1))
(use-package evil-collection
:ensure t
:after evil
:config
(evil-collection-init))



(setq telega-server-libs-prefix "/usr/local")

(require 'telega)
(telega-mode-line-mode 1)

(define-key telega-chat-mode-map (kbd "<f1>") 'telega)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages '(evil evil-collection nov telega)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "black" :foreground "WhiteSmoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "PfEd" :family "Terminus")))))

