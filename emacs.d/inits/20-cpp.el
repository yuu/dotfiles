(eval-after-load 'company
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++14")))
     (add-hook 'c-mode-hook 'irony-mode)
     (add-hook 'c++-mode-hook 'irony-mode)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-to-list 'company-backends 'company-irony)))

(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))

(defun enable-hook-for-clang-format ()
  "Add hook clang-format-buffer"
  (interactive)
  (add-hook 'before-save-hook 'clang-format-buffer nil t))
(provide 'enable-hook-for-clang-format)

(defun disable-hook-for-clang-format ()
  "Remove hook clang-format-buffer"
  (interactive)
  (remove-hook 'before-save-hook 'clang-format-buffer t))
(provide 'disable-hook-for-clang-format)

(eval-after-load 'doxymacs
  (add-hook 'c-mode-common-hook 'doxymacs-mode))
