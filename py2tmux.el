;;; py2tmux.el --- a simple package                     -*- lexical-binding: t; -*-

;; Copyright (C) 2016 Steven Troxler

;; Author: Steven Troxler <steven.troxler@gmail.com>
;; Keywords: lisp
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Purpose:
;;
;; Integration with the py2tmux command line facility, which sends text
;; to an arbitrary tmux session.
;; Usage:
;;
;; M-x py2tmux/line-to-tmux
;; M-x py2tmux/region-to-tmux
;;
;; These are the only interactive functions provided for now,
;; but py2tmux/send-to-tmux is also part of the public api
;; and you could use it from other packages.

;;; Code:


;;;###autoload
(defun py2tmux/send-to-tmux (start end session-name)
  "send the text in current-buffer between start and end
   to the tmux session with name session-name"
  (let ((command (format "py2tmux send-content --session %s" session-name)))
    (shell-command-on-region start end command))
  )

(defun py2tmux/get-end-of-line ()
  "return the int location of the end of current line"
  (save-excursion
    (end-of-line)
    (point)))

(defun py2tmux/get-beginning-of-line ()
  "return the int location of the start of current line"
  (save-excursion
    (beginning-of-line)
    (point)))

;;;###autoload
(defun py2tmux/line-to-tmux ()
  "send the current line to the tmux session named 'emacs'"
  (interactive)
  (let ((start (py2tmux/get-beginning-of-line))
        (end   (py2tmux/get-end-of-line)))
    (py2tmux/send-to-tmux start end "emacs")
    ))

;;;###autoload
(defun py2tmux/region-to-tmux (start end)
  "send the current region to the tmux session named 'emacs'"
  (interactive "r")
  (py2tmux/send-to-tmux start end "emacs")
  )


(provide 'py2tmux)
;;; py2tmux.el ends here
