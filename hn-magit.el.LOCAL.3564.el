;;magit
(autoload 'magit-status "magit" nil t)

(setq magit-process-connection-type nil) ;; temporary fix for magit hangs on commit issue (from http://github.com/philjackson/magit/issues#issue/18)
