;;; package --- Summary
;;; Commentary:
;;; Code:

(defun toggle-transparency ()
  "Toggle transparency."
  (interactive)
  (if (equal "unspecified-bg" (face-background 'default (selected-frame)))
    (set-face-background 'default "#000000" (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

;;; nw-general.el ends here
