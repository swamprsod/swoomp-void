(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq telega-server-libs-prefix "/usr/local")

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)


(unless (package-installed-p 'telega)
  (package-refresh-contents)
  (package-install 'telega))






(setq telega-server-libs-prefix "/usr/local")

(require 'telega)
(telega-mode-line-mode 1)

(define-key telega-chat-mode-map (kbd "<f1>") 'telega)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

