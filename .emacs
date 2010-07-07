(menu-bar-mode 1)
(tool-bar-mode 0)
(global-font-lock-mode t)
;;(setq load-path (cons "~/lib" load-path))
(setq visible-bell t) ;;disable system beep
(setq inhibit-startup-message t) ;;disable emacs start screen

;;set shell to git
;;(setq explicit-shell-file-name "C:/Git/bin/sh.exe")

;;;load libraries
(setq load-path (cons "~/lib-emacs/color-theme" load-path))
(setq load-path (cons "~/lib-emacs/icicles" load-path))
(setq load-path (cons "~/lib-emacs/ruby" load-path))
(setq load-path (cons "~/lib-emacs/ecb" load-path))
(setq load-path (cons "~/lib-emacs/rinari" load-path))
(setq load-path (cons "~/lib-emacs/rinari/rhtml" load-path))
(setq load-path (cons "~/lib-emacs/magit" load-path))
(setq load-path (cons "~/lib" load-path))

(load-file "~/lib-emacs/cedet/common/cedet.el")

;;icicles
(require 'icicles)
(icy-mode 1)

;;;color-theme settings
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (load-file "~/lib-emacs/color-theme/color-theme-blackboard.el")     
     (color-theme-hober)))


;;cedet

;;ecb
(require 'ecb)
; set ecb windows width
(setq ecb-windows-width 0.20)

;;rinari
(require 'rinari)


;;smart-split
(defun smart-split ()
  "Split the frame into 80-column sub-windows, and make sure no window has fewer than 80 columns." 
  (interactive) 
  (defun smart-split-helper (w) 
    "Helper function to split a given window into two, the first of which has 80 columns." 
    (if (> (window-width w) (* 2 81)) 
	(let ((w2 (split-window w 82 t))) 
	  (smart-split-helper w2)))) 
  (smart-split-helper nil)) 

;;switch between windows
(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

;;Define a minor mode for global key maps(from Stack overflow)
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "M-]") 'select-next-window)
(define-key my-keys-minor-mode-map (kbd "M-[") 'select-previous-window)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

;;VB mode
;;(require 'visual-basic-mode)
;;(add-to-list 'auto-mode-alist '("\\.mts" . visual-basic-mode))


;;log-4j
(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))

;;ruby-mode
(autoload 'ruby-mode "ruby-mode" "major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;inf-ruby
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("~/rails-projects"))))

(setq ecb-tip-of-the-day nil) ;;disable ecb tip of the day

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "#c0c0c0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 79 :width normal :foundry "bitstream" :family "Bitstream Vera Sans Mono")))))

(put 'narrow-to-region 'disabled nil)

(put 'dired-find-alternate-file 'disabled nil)


;;; Autoloads for magit

(autoload 'magit-status "magit" nil t)


;; escape funny characters in emacs shell
;; from http://stackoverflow.com/questions/704616/something-wrong-with-emacs-shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)