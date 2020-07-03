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

(defvar current-user (getenv "USER") "The current user.")

;; (defvar prelude-dir (file-name-directory load-file-name)
;;   "The root dir of the Emacs Prelude distribution.")
;; (defvar prelude-modules-dir (expand-file-name  "modules" prelude-dir)
;;   "This directory houses all of the built-in Prelude modules.")
;; (defvar prelude-vendor-dir (expand-file-name "vendor" prelude-dir)
;;   "This directory houses packages that are not yet available in ELPA (or MELPA).")

(defun add-subfolders-to-load-path (parent-dir)
  "Add all level PARENT-DIR subdirs to the `load-path'."
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." f)))
        (add-to-list 'load-path name)))))

(defvar root-dir (file-name-directory load-file-name) "The root dir of Emacs.")
(defvar var-user-dir (expand-file-name "var" root-dir) "The temporaries directory.")
(defvar vendor-user-dir (expand-file-name "vendor" root-dir) "The random .el directory.")

(setq-default package-user-dir (expand-file-name "elpa" root-dir))
(setq-default custom-file (expand-file-name "custom.el" var-user-dir))

;; remove old-ass org-mode from load-path to make way to newer org-mode
(setq load-path
      (delete (car (file-expand-wildcards "/usr/share/emacs/*/lisp/org")) load-path))
(add-to-list
 'load-path
 (car (file-expand-wildcards (expand-file-name "org-plus-contrib*" package-user-dir))))

(org-babel-load-file "~/.emacs.d/config.org")

(message "Emacs is ready to do thy bidding, Master %s!" current-user)

;;; init.el ends here
