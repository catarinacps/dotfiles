;;; init.el --- Configuration entry point

(let ((file-name-handler-alist nil)
      (config-file (expand-file-name "config" user-emacs-directory)))
  (setq safe-local-variable-values
        '((eval add-hook 'after-save-hook #'hcps/byte-compile-org-config nil t)))

  (if (file-exists-p (concat config-file ".elc"))
      (load config-file)
    (org-babel-load-file (concat config-file ".org") t)))

(message "Emacs is ready to do thy bidding, %s!" current-user)

;;; init.el ends here
