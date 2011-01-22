;;ruby-mode
(autoload 'ruby-mode "ruby-mode" "major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;;inf-ruby
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

;;ri
(require 'ri)


(defun rspec-spec-file-p (a-file-name)
  "Returns true if the specified file is a spec"
  (string-match "\\(_\\|-\\)spec\\.rb$" a-file-name))

;; (defun get-outline-regexp-value ()
;;   (if (rspec-spec-file-p buffer-file-name)
;;       " *\\(describe \\|it\\)"
;;     " *\\(def \\|class\\|module\\)"))

;; ;;outline mode for ruby
;; (add-hook 'ruby-mode-hook
;;               '(lambda ()
;;                  (outline-minor-mode)
;;                  (setq outline-regexp (get-outline-regexp-value))))
  


