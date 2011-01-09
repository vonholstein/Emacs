(menu-bar-mode 1)
(tool-bar-mode 0)
(global-font-lock-mode t)
(setq visible-bell t) ;;disable system beep
(setq inhibit-startup-message t) ;;disable emacs start screen

;; escape funny characters in emacs shell
;; from http://stackoverflow.com/questions/704616/something-wrong-with-emacs-shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Redefine C-x C-b to ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Use gnu find for find-file
(setq find-program "c:\\gnuwin32\\bin\\find.exe")

;; enable epa
(epa-file-enable)


