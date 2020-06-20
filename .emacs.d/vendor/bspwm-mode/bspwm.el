(defface i3wm-action-face
  '((t :inherit font-lock-function-name-face))
  "Face for actions or verbs like 'set', 'bindsym', 'move' etc.")

(defface bspwm-modifiers-face
  '((t :inherit font-lock-type-face))
  "Face for modifiers like '--release' and '--no-startup-id'.")

(defface bspwm-numbers-face
  '((t :inherit font-lock-constant-face))
  "Face for numbers.")

(defface bspwm-value-assign-face
  '((t :inherit font-lock-variable-name-face))
  "Face value assignments - e.g. the 'y' in 'set x y'.")

(defface bspwm-bindsym-key-face
  '((t :inherit font-lock-variable-name-face))
  "Face for the keys used in bindsym assignments.")

(defface bspwm-variable-face
  '((t :inherit font-lock-constant-face))
  "Face for $variables.")

(defface bspwm-unit-face
  '((t :inherit font-lock-type-face))
  "Face for units like 'px', 'ms', 'ppt'.")

(defface bspwm-for-window-predictate-face
  '((t :inherit font-lock-builtin-face))
  "Face for the predicates in for_window assignments -
the 'x' in 'for_window [x=y]'.")

(defface bspwm-exec-face
  '((t :inherit font-lock-builtin-face))
  "Face for the text inside an exec statement.")

(defface bspwm-modifier-face
  '((t :inherit font-lock-type-face))
  "Face for action modifiers like 'floating', 'tabbed', 'sticky' or 'current'.")

(defface bspwm-keyword-face
  '((t :inherit font-lock-keyword-face))
  "Face for fixed keywords like 'workspace', 'mode', 'position' or 'fullscreen'.")

(defface bspwm-constant-face
  '((t :inherit font-lock-constant-face))
  "Face for constant values like 'top', 'invisble', 'yes' or 'no'.")

(defface bspwm-block-opener-face
  '((t :inherit font-lock-type-face))
  "Face for the names of items denoting blocks like 'bar {}' and 'colors {}'.")

(defface bspwm-string-face
  '((t :inherit font-lock-string-face))
  "Face for text enclosed in quotes.")

(defface bspwm-comment-face
  '((t :inherit font-lock-comment-face))
  "Face for comments.")

(defface bspwm-operator-face
  '((t :inherit font-lock-builtin-face))
  "Face for various operators like '&&', '+', and '|'.")

(define-derived-mode bspwm-config-mode conf-space-mode "bspwm Config")

(font-lock-add-keywords
 'bspwm-config-mode
 `(

   ;; Actions
   ( ,(rx
       (seq
        symbol-start
        (or
         "Left")
        symbol-end))
     0
     'bspwm-action-face)

   ;; --modifiers
   ( ,(rx (seq
           symbol-start
           (or "--no-startup-id" "--release")
           symbol-end))
     0
     'bspwm-modifiers-face)

   ;; numbers
   ( ,(rx (seq
           symbol-start
           (? (or "-" "+"))
           (group-n 1 (1+ num))))
     1
     'bspwm-numbers-face)

   ;; value part of `set x y'
   ( ,(rx (seq
           bol
           "set"
           (? "_from_resource")
           (1+ space)
           "$" (1+ (or "_" "-" word))
           (1+ space)
           (group-n 1 symbol-start (1+ (or "-" "_" alnum)) symbol-end)))
     1
     'bspwm-value-assign-face
     t)

   ;; Keys used in `bindsym'
   ( ,(rx (or
           (seq "bindsym" (1+ space) (? (seq "--release" (1+ space))))
           "+")
          (group-n 1 (1+ (or word "_")))
          )
     1
     'bspwm-bindsym-key-face
     t)

   ;; Variables
   ( ,(rx (seq
           symbol-start
           "$"
           (1+ (or "-" "_" word))))
     0
     'bspwm-variable-face
     t)

   ;; units of measurement
   ( ,(rx (seq
           (? (1+ num))
           (group-n 1 (or "px" "pixel" "ms" "ppt"))
           symbol-end))
     1
     'bspwm-unit-face)

   ;; `for_window' predicates
   ( ,(rx (or
           "class"
           "title"
           "instance"
           "window_role"
           "window_type"))
     0
     'bspwm-for-window-predictate-face)

   ;; Command part of an `exec' statement
   ( ,(rx (seq
           "exec"
           (? "_always")
           (1+ space)
           (? "--" (1+ (or "-" word)) (1+ space))
           (group-n 1 (1+ any))
           eol))
     1
     'bspwm-exec-face
     t)

   ;; Action modifiers
   ( ,(rx (seq
           (or
            "tiled")
           symbol-end))
     0
     'bspwm-modifier-face)

   ;; Keywords
   ( ,(rx (seq
           bow
           (or
            "super"
            "hyper"
            "meta"
            "alt"
            "control"
            "ctrl"
            "shift"
            "mode_switch"
            "lock"
            "mod1"
            "mod2"
            "mod3"
            "mod4"
            "mod5")
           eow
           ))
     0
     'bspwm-keyword-face)

   ;; single letter modifiers
   ( ,(rx (seq
           symbol-start
           (or "h" "x" "v")
           symbol-end))
     0
     'bspwm-unit-face)

   ;; Constant values
   ( ,(rx (or
           "bspc"))
     0
     'bspwm-constant-face)

   ;; Values assignments after a `:'
   ( ,(rx (seq
           (1+ nonl)
           ":"
           (group-n 1 (1+ (not (any "\n" "\""))))))
     1
     'bspwm-value-assign-face
     t)

   ;; Block openers
   ( ,(rx (seq
           symbol-start
           (group-n 1 (1+ (or "_" "-" word)))
           symbol-end
           (1+ space)
           "{"))
     1
     'bspwm-block-opener-face)

   ;; + = | : etc
   ( ,(rx (or "+" "&&" "-" "=" "|" ":" "," ";"))
     0
     'bspwm-operator-face)

   ;; commands with more or less arbitrary values
   ( ,(rx (seq
           (or "tray_output" "status_command" "i3bar_command")
           (1+ space)
           (group-n 1 (1+ any) eol)))
     1
     'bspwm-value-assign-face
     t)

   ;; i3-msg, which needs to overwrite the `exec' highlight
   ( ,(rx (seq
           symbol-start
           "i3-msg"
           symbol-end))
     0
     'bspwm-action-face
     t)

   ;; client.*color* assigments
   ( ,(rx (seq
           symbol-start
           (1+ (or "_" word))
           "."
           (1+ (or "_"  word))
           symbol-end))
     0
     'bspwm-keyword-face
     t)

   ;; enforce strings again
   ( ,(rx (seq
           "\"" (1+ (not (any "\""))) "\""))
     0
     'bspwm-string-face
     t)

   ;; enforce comments again
   ( ,(rx (seq
           "#"
           (? (1+ nonl))))
     0
     'bspwm-comment-face
     t)))

(provide 'bspwm-config-mode)
