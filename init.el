(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))	     
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(color-theme helm markdown-mode markdown-preview-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'helm-config)
(helm-mode 1)
(load-file "~/.emacs.d/color-theme-billw.el")

(setq inhibit-splash-screen t)
(setq visible-bell t)
(tool-bar-mode -1)

;; Helm config
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-c l") #'org-store-link)

;; Start maximized
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (markdown-mode markdown-preview-mode helm color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-directory "~/org")
(setq org-agenda-files (quote ("~/org/base.org")))


;; Other
(if (string-equal system-type "windows-nt")
    (progn
      (print "Detected windows")
      (setq explicit-shell-file-name "C:/babun/.babun/cygwin/bin/bash.exe")
      (setq shell-file-name explicit-shell-file-name)
      (add-to-list 'exec-path "C:/babun/.babun/cygwin/bin")))
      
(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)


;(setq explicit-bash.exe-args '("--noediting" "--login" "-i"))

(put 'narrow-to-region 'disabled nil)


;;c-tags
;; (require 'setup-general)
;; (if (version< emacs-version "24.4")
;;     (require 'setup-ivy-counsel)
;;   (require 'setup-helm)
;;   (require 'setup-helm-gtags))
;; ;; (require 'setup-ggtags)
;; (require 'setup-cedet)
;; (require 'setup-editing)

system-type

(print "habib")

(string-equal system-type "windows-nt")
