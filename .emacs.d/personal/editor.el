(require 'multiple-cursors)
(require 'company)
(require 'flycheck)
(require 'god-mode)
(require 'key-chord)

;; Functions
;;(defun hook-update-cursor ()
;;  (cond ((or (bound-and-true-p god-mode)
;;             (bound-and-true-p god-local-mode))
;;         (setq cursor-type 'bar))
;;        (t (setq cursor-type 'box))))

;; Hooks
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Editor auxiliars
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Font size
(set-face-attribute 'default nil :height 120)

;; Key bindings
(global-set-key [C-M-tab] 'clang-format-buffer)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Word wrap
(setq-default fill-column 80)

;; Key-chords
(setq key-chord-two-keys-delay .015
      key-chord-one-key-delay .020)
