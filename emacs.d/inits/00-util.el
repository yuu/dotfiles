(eval-after-load 'undo-tree
  (global-undo-tree-mode t))

(defun enable-tabs-mode ()
  "Enable indent-tabs-mode"
  (interactive)
  (setq indent-tabs-mode t))
(provide 'enable-tabs-mode)

(defun disable-tabs-mode ()
  "Disable indent-tabs-mode"
  (interactive)
  (setq indent-tabs-mode nil))
(provide 'disable-tabs-mode)
