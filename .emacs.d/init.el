;;; init.el --- Prelude's configuration entry point.
;;
;; Copyright (c) 2011-2018 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: http://batsov.com/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up the default load path and requires
;; the various modules defined within Emacs Prelude.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(defun add-subfolders-to-load-path (parent-dir)
  "Add all first level PARENT-DIR subdirs to the `load-path'."
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." f)))
        (add-to-list 'load-path name)))))

(defvar current-user (getenv "USER") "The current user.")

(defvar root-dir (file-name-directory load-file-name) "The root dir of Emacs.")
(defvar var-user-dir (expand-file-name "var" root-dir) "The temporaries directory.")
(defvar vendor-user-dir (expand-file-name "vendor" root-dir) "The random .el directory.")

(defvar config-file (expand-file-name "config" root-dir) "The literate config path.")

(setq-default package-user-dir (expand-file-name "elpa" root-dir))
(setq-default custom-file (expand-file-name "custom.el" var-user-dir))

(defvar org-original-package-path
  (car (file-expand-wildcards "/usr/share/emacs/*/lisp/org")))
(defvar org-plus-contrib-package-path
  (car (file-expand-wildcards (expand-file-name "org-plus-contrib*" package-user-dir))))

;; remove old-ass org-mode from load-path to make way to newer org-mode
(setq load-path (delete org-original-package-path load-path))

;; let's first load custom.el (keep in mind this is problematic when using use-package)
(load-file custom-file)

;; if we have a new .el, just load it
(if (file-newer-than-file-p (concat config-file ".el") (concat config-file ".org"))
    (ignore)
  ;; else, we gotta load at least *one* org-mode package
  (add-to-list 'load-path (if org-plus-contrib-package-path org-plus-contrib-package-path
                            org-original-package-path))
  (org-babel-tangle-file (concat config-file ".org")))

(load config-file)

(message "Emacs is ready to do thy bidding, %s!" current-user)

;;; init.el ends here
