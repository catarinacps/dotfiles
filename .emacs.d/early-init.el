;;; early-init.el --- The init before init -*- lexical-binding: t -*-

(setq gc-cons-threshold most-positive-fixnum ; big gc threshold so we fast
      gc-cons-percentage 0.6 ; later we trim this down
      load-prefer-newer t
      inhibit-x-resources t
      comp-deferred-compilation t ; automatically native compile stuff
      package-enable-at-startup nil ; don't auto-initialize!
      ;; don't add that `custom-set-variables' block to my init.el!
      package--init-file-ensured t)

;; setup some frame configurations early so we don't waste time later
(setq default-frame-alist '((font . "Iosevka Light 14")
                            (menu-bar-lines . 0)
                            (tool-bar-lines . 0)
                            (tab-bar-lines . 1)
                            (vertical-scroll-bars . nil)
                            (horizontal-scroll-bars . nil)
                            (internal-border-width . 1)
                            (right-divider-width . 1)
                            (bottom-divider-width . 1)))

(setq inhibit-startup-screen t
      blink-cursor-mode nil
      tab-bar-tab-hints t
      tab-bar-separator " "
      tab-bar-border 1)
