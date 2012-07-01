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

;; use gnuwin32 diff for ediff
(setq ediff-diff-program "c:\\gnuwin32\\bin\\diff.exe")

;; set backup to .saves folder
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; remove duplicate lines from http://www.emacswiki.org/emacs/DuplicateLines
(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
	  (progn
	    (goto-char start)
	    (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
	(replace-match "\\1\n\\2")))))

(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))
