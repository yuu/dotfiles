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

;;; cocoa-emacs-custom.el ends here
