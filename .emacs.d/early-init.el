;;; early-init.el --- The init before init -*- lexical-binding: t -*-

(setq gc-cons-threshold most-positive-fixnum ; big gc threshold so we fast
      gc-cons-percentage 0.6 ; later we trim this down
      load-prefer-newer t
      comp-deferred-compilation t ; automatically native compile stuff
      package-enable-at-startup nil ; don't auto-initialize!
      ;; don't add that `custom-set-variables' block to my init.el!
      package--init-file-ensured t)
