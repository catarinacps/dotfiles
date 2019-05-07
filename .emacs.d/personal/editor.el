(require 'multiple-cursors)
(require 'company)
(require 'flycheck)
(require 'evil-collection)

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
;; (set-face-attribute 'default nil :font "Hack" :height 110)
(setq default-frame-alist '((font . "Source Code Pro-12")))
(setq-default line-spacing 0)

;; Key bindings
(global-set-key [C-M-tab] 'clang-format-buffer)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Word wrap
(setq-default fill-column 80)

(setq evil-want-keybinding nil)
(evil-collection-init)
