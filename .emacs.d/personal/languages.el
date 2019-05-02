(require 'irony)
(require 'org)
(require 'ess-r-mode)

(defun insert-date-heading ()
  (interactive)
  (and (org-insert-heading-respect-content)
       (insert (concat (format-time-string "%F") "\n"))))

(setq-default org-display-custom-times t)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(setq irony-additional-clang-options
      (append '("-I" "include") irony-additional-clang-options))

(setq org-highlight-latex-and-related '(latex script entities))
(setq org-time-stamp-custom-formats '("<%F>" . "<%F %H:%M>"))

(define-key org-mode-map (kbd "C-c x") 'insert-date-heading)
