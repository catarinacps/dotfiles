(require 'irony)
(require 'org)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(setq irony-additional-clang-options
      (append '("-I" "include") irony-additional-clang-options))

(setq org-highlight-latex-and-related '(latex script entities))
