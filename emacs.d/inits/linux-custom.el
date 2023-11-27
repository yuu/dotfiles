;;; package --- Summary
;;; Commentary:
;;; Code:

(defun isWSL ()
  "Run Emacs on windows subsystem linux ?."
  (if (string= "" (shell-command-to-string "uname -r |grep Microsoft"))
    nil
    t))

(defun clipboard-copy ()
  "Copy to clipboard."
  (interactive)
  (when (region-active-p)
    (if (isWSL)
      (shell-command-on-region (region-beginning) (region-end) "clip.exe" nil nil)
      (shell-command-on-region (region-beginning) (region-end) "xsel --clipboard --input" nil nil)
      )
   )
)

(use-package rg
  :config
  (setq rg-group-result t)
)

;;; linux-custom.el ends here
