(defun clipboard-copy ()
  (interactive)
  (when (region-active-p)
    (shell-command-on-region (region-beginning) (region-end) "xsel --clipboard --input" nil nil)))

(use-package rg
  :config
  (setq rg-group-result t)
)
