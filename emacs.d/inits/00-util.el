(global-undo-tree-mode)
(global-git-gutter-mode)
(yas-global-mode)

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
