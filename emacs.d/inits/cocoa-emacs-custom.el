;;; package --- Summary
;;; Commentary:
;;; Code:

(defun clipboard-copy ()
  "Copy to clipboard."
  (interactive)
  (when (region-active-p)
    (shell-command-on-region (region-beginning) (region-end) "pbcopy" nil nil)))

(set-face-attribute 'default nil
                    :family "Source Han Code JP"
                    :height 140
                    :weight 'normal
                    :width 'normal)

(set-scroll-bar-mode nil)
(set-fringe-mode 0)

(setq default-frame-alist '((width . 140) (height . 50)))

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs 'exec-path and PATH to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (getenv "PATH")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;;; cocoa-emacs-custom.el ends here
