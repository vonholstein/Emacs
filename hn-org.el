(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map [(control meta ?r)] 'remember)

(custom-set-variables
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(org-default-notes-file "~/notes.org"))
 
 
