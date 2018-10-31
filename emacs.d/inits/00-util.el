(require 'undo-tree)
(add-hook 'after-init-hook 'global-undo-tree-mode)
(add-hook 'after-init-hook 'global-git-gutter-mode)
(add-hook 'after-init-hook 'yas-global-mode)

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
