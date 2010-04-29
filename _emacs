(menu-bar-mode 0)
(tool-bar-mode 0)
(global-font-lock-mode t)
;;(setq load-path (cons "~/lib" load-path))
(setq visible-bell t) ;;disable system beep
(setq inhibit-startup-message t) ;;disable emacs start screen

;;;load libraries
;;(add-to-list 'load-path "~/lib/color-theme" "g:/home/lib/bookmark")
(setq load-path (cons "~/lib/color-theme" load-path))
(setq load-path (cons "~/lib/bookmark" load-path))
(setq load-path (cons "~/lib/icicles" load-path))
(setq load-path (cons "~/lib" load-path))

(require 'bookmark+)

;;;color-theme settings
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))


;;ido-mode settings
;;do not confirm a new file or buffer
;; (setq confirm-nonexistent-file-or-buffer nil)
;; (require 'ido)
;; (ido-mode 1)
;; (ido-everywhere 1)
;; (setq ido-enable-flex-matching t)
;; (setq ido-create-new-buffer 'always)
;; (setq ido-enable-tramp-completion nil)
;; (setq ido-enable-last-directory-history nil)
;; (setq ido-confirm-unique-completion nil) ;; wait for RET, even for unique?
;; (setq ido-show-dot-for-dired t) ;; put . as the first item
;; (setq ido-use-filename-at-point t) ;; prefer file names near point


;;;dired settings
(put 'dired-find-alternate-file 'disabled nil)
;;Disable creating new buffer on dired goto parent(^)
     (eval-after-load "dired"
       ;; don't remove `other-window', the caller expects it to be there
       '(defun dired-up-directory (&optional other-window)
          "Run Dired on parent directory of current directory."
          (interactive "P")
          (let* ((dir (dired-current-directory))
     	    (orig (current-buffer))
     	    (up (file-name-directory (directory-file-name dir))))
            (or (dired-goto-file (directory-file-name dir))
     	   ;; Only try dired-goto-subdir if buffer has more than one dir.
     	   (and (cdr dired-subdir-alist)
     		(dired-goto-subdir up))
     	   (progn
     	     (kill-buffer orig)
     	     (dired up)
     	     (dired-goto-file dir))))))
(put 'narrow-to-region 'disabled nil)

;;set HOME variable
 (cond ((string= system-name "PBECKER-PC") (setq HOME "e:/home"))
       ((string= system-name "VALVE64") (setq HOME "c:/home")))

;;;cygwin settings

 (cond ((string= system-name "PBECKER-PC") (setq cygwin-path "e:/cygwin"))
       ((string= system-name "VALVE64") (setq cygwin-path "c:/cygwin")))


;; For subprocesses invoked via the shell
;; (e.g., "shell -c command")

;; Add cygwin directories to the emacs search path
;; (when (file-exists-p (concat cygwin-path "/bin"))
;; (setq exec-path (cons "C:/Program Files (x86)/Git/bin" exec-path))
;; (setq exec-path (cons (concat cygwin-path "/bin") exec-path))
;; (setq exec-path (cons (concat cygwin-path "/bin") exec-path))
;; (setenv "PATH" (concat "e:\\cygwin\\bin;" (getenv "PATH")))
;; (setenv "PATH" (concat "e:\\cygwin\\usr\\local\\bin;" (getenv "PATH"))))



;;ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)




;;desktop.el for session management
;; Customization follows below
(require 'desktop)
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)


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

;(global-set-key (kbd "M-]") 'select-next-window)
;(global-set-key (kbd "M-[")  'select-previous-window)

;;Define a minor mode for global key maps(from Stack overflow)
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "M-]") 'select-next-window)
(define-key my-keys-minor-mode-map (kbd "M-[") 'select-previous-window)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

;;VB mode
(require 'visual-basic-mode)
(add-to-list 'auto-mode-alist '("\\.mts" . visual-basic-mode))

;;Org mode
(add-to-list 'auto-mode-alist '("\\.org" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(setq org-log-done t)
(setq org-agenda-files (list "~/OrgModeNotes/MasterIndex.org" "~/OrgModeNotes/work.org" "~/OrgModeNotes/pers.org"))
(setq org-todo-keywords '((sequence "TODO(t)" "MAYBE(m)" "WAITING(w@/!)" "NEXT(n@)" "|" "DONE(d)")))
(setq org-enforce-todo-dependencies t)
(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
	("MAYBE" . shadow)
	("WAITING" . (:foreground "yellow" :weight bold))
	("NEXT" . (:foreground "blue" :weight bold))
       )
)
	

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/OrgModeNotes/MasterIndex.org" "~/OrgModeNotes/work.org"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)



;;Uniquify settings
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;;log-4j
(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))

;;icicles
(require 'icicles)