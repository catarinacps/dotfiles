;;; compile-config.el --- My configuration compile script-ish thingy -*- lexical-binding: t -*-

(setq load-path
      (delete (car (file-expand-wildcards "/usr/share/emacs/*/lisp/org")) load-path))

(setq straight-check-for-modifications '(watch-files find-when-checking))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-user-dir (expand-file-name "straight" user-emacs-directory)
      load-prefer-newer t
      straight-use-package-by-default t)

(unless (file-directory-p package-user-dir)
  (make-directory package-user-dir t))

(straight-use-package 'org)
(straight-use-package 'general)
(straight-use-package 'use-package)
(require 'org)
(require 'general)
(require 'use-package)

(let* ((config-file (expand-file-name "config" user-emacs-directory))
       (org-config (concat config-file ".org"))
       (tangled-config (concat config-file ".el"))
       (compiled-config (concat config-file ".elc")))
  (unless (and (file-exists-p tangled-config)
               (file-newer-than-file-p tangled-config org-config))
    (org-babel-tangle-file org-config))

  (load config-file)

  (unless (and (file-exists-p compiled-config)
               (file-newer-than-file-p compiled-config tangled-config))
    (byte-compile-file tangled-config)
    (native-compile tangled-config)))

;; compile-config.el ends here
