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

(setq browse-url-generic-program (executable-find "conkeror")
      browse-url-browser-function 'browse-url-generic)

;;enable paren mode
(show-paren-mode 1)

;; set uniquify
(setq uniquify-buffer-name-style 'post-forward)
;(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; enable hippie-expand
(global-set-key (kbd "M-/") 'hippie-expand)