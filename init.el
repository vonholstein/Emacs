;; ELPA configuration
;; https://github.com/technomancy/emacs-starter-kit

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-ruby color-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'color-theme)
(color-theme-billw)

;; Dired configuration
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map (kbd "<return>")
	      'dired-find-alternate-file) ; was dired-advertised-find-file
	    (define-key dired-mode-map (kbd "^")
	      (lambda () (interactive) (find-alternate-file "..")))
					; was dired-up-directory
	    ))

;; Modes
(add-to-list 'auto-mode-alist '("\\.\\(?:bat\\|com\\)$" . bat-mode))

;; disable flyspell

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
(define-key my-keys-minor-mode-map (kbd "C-<") 'other-frame)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

(put 'narrow-to-region 'disabled nil)

;; enable paren mode
(show-paren-mode 1)

;; startup configuration
(menu-bar-mode 1)
(tool-bar-mode 0)
(global-font-lock-mode t)
(setq visible-bell t) ;;disable system beep

(setq-default fill-column 150)
;; set backup to .saves folder
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2)

;; generate temp buffer with prefix
;; from http://stackoverflow.com/questions/10363982/how-can-i-open-a-temporary-buffer

(defun generate-buffer ()
  (interactive)
  (switch-to-buffer (make-temp-name "scratch")))

(global-set-key (kbd "<f5>") 'generate-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-directory "~/org")
(setq org-agenda-files (quote ("~/org/work.org" "~/org/goals.org" "~/org/study.org" "~/org/books.org" "~/org/personal.org")))
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "C:\\Users\\hnahas\\Dropbox\\MobileOrg")

;; drawers
(setq org-drawers (quote ("NOTES" "LOGBOOK" "CLOCK")))

;; todo states
(setq org-todo-keywords '((sequence "TODO(t!)" "IN PROGRESS(i!)" "PAUSED(p!)" "WAITING(w@/!)" "|" "DONE(d!)" "CANCELLED(c!)")))

;; todo faces
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "blue" :weight bold))
        ("IN PROGRESS" . (:foreground "red" :weight bold))
        ("PAUSED" . (:foreground "orange" :weight bold))
        ("WAITING" . (:foreground "yellow" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("CANCELLED" . (:foregreound "violet" :weight bold))))

;; log into drawer
(setq org-log-into-drawer t)

;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f9> s") 'bh/go-to-scratch)

;; functions
(defun bh/go-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*")
  (delete-other-windows))

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; Change task state to IN PROGRESS from TODO,PAUSED,WAITING states when clocking in
(defun bh/clock-in-to-next (kw)
  "Switch task from TODO,PAUSED,WAITING states to IN PROGRESS when clocking in.
Skips remember tasks and tasks with subtasks"
  (if (and (or (string-equal kw "TODO") (string-equal kw "PAUSED") (string-equal kw "WAITING"))
           (not (string-equal (buffer-name) "*Remember*")))
      (let ((subtree-end (save-excursion (org-end-of-subtree t)))
            (has-subtask nil))
        (save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-not-done-keywords)
              (setq has-subtask t))))
        (when (not has-subtask)
          "IN PROGRESS"))))

;; Change task state to PAUSED from IN PROGRESS when clocking out
(defun bh/clock-out-to-paused (kw)
  "Switch task from IN PROGRESS to PAUSED when clocking out.
Skips remember tasks and tasks with subtasks"
  (if (and (string-equal kw "IN PROGRESS")
           (not (string-equal (buffer-name) "*Remember*")))
      (let ((subtree-end (save-excursion (org-end-of-subtree t)))
            (has-subtask nil))
        (save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-not-done-keywords)
              (setq has-subtask t))))
        (when (not has-subtask)
          "PAUSED"))))

(setq org-clock-in-switch-to-state (quote bh/clock-in-to-next))
(setq org-clock-out-switch-to-state (quote bh/clock-out-to-paused))

;; (defun hn/clock-out-on-pause (nstate)
;;   "Clock out on state change to waiting"
;;   if( (and (string-equal org-state "WAITING")
;;            (not (string-equal (buffer-name) "*Remember*")))
;;       (org-clock-clock-out)))

;; (setq org-after-todo-state-change-hook (quote hn/clock-out-on-pause))

;; Save clock data in the CLOCK drawer and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer "CLOCK")

;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END org-mode configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ecb settings
(setq ecb-options-version "2.40")
;; ecb barfs if following setting is absent
(setq stack-trace-on-error t)
;; other settings (self-evident)
(setq ecb-windows-width 0.20)
(setq ecb-tip-of-the-day nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/projects.org" "~/org/work.org" "~/org/study.org" "~/org/books.org" "~/org/personal.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'ido-exit-minibuffer 'disabled nil)
(put 'upcase-region 'disabled nil)
