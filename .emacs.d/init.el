;;; init.el --- Configuration entry point -*- lexical-binding: t -*-

(let* ((file-name-handler-alist nil)
       (config-file (expand-file-name "config" user-emacs-directory))
       (org-config (concat config-file ".org"))
       (compiled-config (concat config-file ".elc")))
  (setq safe-local-variable-values
        '((eval add-hook 'after-save-hook #'hcps/byte-compile-org-config nil t)))

  (if (file-exists-p compiled-config)
      (load config-file)
    (require 'org)
    (let ((tangled-config (car (org-babel-tangle-file org-config))))
      (load-file tangled-config)
      (byte-compile-file tangled-config)
      (delete-file tangled-config))))

;; set a sane gc-threshold again
(setq gc-cons-threshold 16777216 ; 16MB
      gc-cons-percentage 0.1)

(message "Emacs is ready to do thy bidding, %s!" current-user)

;;; init.el ends here
