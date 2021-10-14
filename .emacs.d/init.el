;;; init.el --- Configuration entry point -*- lexical-binding: t -*-

(let* ((temp-handler file-name-handler-alist)
       (config-file (expand-file-name "config" user-emacs-directory))
       (org-config (concat config-file ".org"))
       (tangled-config (concat config-file ".el"))
       (compiled-config (concat config-file ".elc")))
  ;; the org config recompiles after saves, set this behavior as safe
  (add-to-list 'safe-local-eval-forms
               '(add-hook 'after-save-hook #'hcps/async-byte-compile-org-config nil t))

  ;; unset handler-alist to speed-up startup
  (setq file-name-handler-alist nil)

  ;; if there is no tangled config, tangle it
  (unless (file-exists-p tangled-config)
    (require 'org)
    (org-babel-tangle-file org-config)
    (unload-feature 'org))

  ;; to ensure ELPA's org-plus-contrib is prioritized above the built-in org
  (setq load-path
        (delete (car (file-expand-wildcards "/usr/share/emacs/*/lisp/org")) load-path))

  ;; try to load our config
  (load config-file)

  ;; if we ended up loading the .el directly, byte-compile and also native compile
  (unless (file-exists-p compiled-config)
    (async-byte-compile-file tangled-config)
    (native-compile-async tangled-config))

  ;; restore handler-alist
  (setq file-name-handler-alist temp-handler))

;; set a sane gc-threshold again
(setq gc-cons-threshold 16777216 ; 16MB
      gc-cons-percentage 0.1)

(message "Emacs is ready to do thy bidding, %s!" current-user)

;;; init.el ends here
