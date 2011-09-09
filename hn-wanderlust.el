;;; General settings needed at Amazon
;; SMTP server for mail posting.
(setq wl-smtp-posting-server "smtp.amazon.com")

;; IMAP settings
(setq elmo-imap4-default-user "hnahas")
(setq elmo-imap4-default-authenticate-type 'clear)
(setq elmo-imap4-default-server "exchange.amazon.com")
(setq elmo-imap4-default-port 993)
(setq elmo-imap4-default-stream-type 'ssl)
(setq ssl-certificate-verification-policy 3)

;; always save a copy in %Sent Items! (the standard name of the
;; ouchlook / exchange folder)
(setq wl-fcc "%Sent Items!")
(setq wl-fcc-force-as-read t)

;; set message-ID by SMTP server side
(setq wl-insert-message-id nil)

;; use black/white PostScript print filter for printing
(setq wl-ps-print-buffer-function 'ps-print-buffer)

;; appearance settings
(setq wl-folder-window-width 30)
