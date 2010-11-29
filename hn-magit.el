;;magit
(autoload 'magit-status "magit" nil t)

(setq magit-process-connection-type nil) ;; temporary fix for magit hangs on commit issue (from http://github.com/philjackson/magit/issues#issue/18)
;; (setq magit-process-connection-type nil) ;; temporary fix for magit hangs on commit issue (from http://github.com/philjackson/magit/issues#issue/18)

;; fix on windows from http://www.emacswiki.org/emacs/Magit
(defun magit-escape-for-shell (str)
  (if (or (string= str "git")
	  (string-match "^--" str))
      str
    (concat "'" (replace-regexp-in-string "'" "'\\''" str) "'")))
