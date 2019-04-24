(require 'ido)
(require 'ido-vertical-mode)
(require 'yasnippet)
(require 'smart-mode-line)
(require 'org-journal)

(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "\
# This buffer is for notes you don't want to save, and for Org notes.
# If you want to create a file, visit that file with C-x C-f,
# then enter the text in that file's own buffer.

")

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(ido-vertical-mode 1)

(global-set-key (kbd "M-x") 'smex)

(yas-global-mode 1)

(sml/setup)
