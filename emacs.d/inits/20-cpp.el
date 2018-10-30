(with-eval-after-load 'company-irony
  (custom-set-variables '(irony-additional-clang-options '("-std=c++14"))))

(defun my/c-mode-hook ()
  (add-to-list 'company-backends 'company-irony)
  (add-to-list 'company-backends 'company-c-headers)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (add-to-list 'load-path "~/.emacs.d/el-get/doxymacs/lisp/")
  (flycheck-irony-setup)
  (irony-mode))
(add-hook 'c-mode-hook 'my/cmake-mode-hook)
(add-hook 'c++-mode-hook 'my/c-mode-hook)

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

(with-eval-after-load 'quickrun
  (quickrun-add-command "c++/clang 1z"
    '((:command . "clang++")
      (:exec    . ("%c -std=c++1z %o -o %e %s"
                   "%e %a"))
      (:remove  . ("%e")))
    :default "c++"))

(defvar my/company-cmake-prefix nil)
(defun my/company-completion-started (unused)
  (let ((prefix (company-grab-symbol)))
    (setq my/company-cmake-prefix (and (not (string-empty-p prefix)) (string= prefix (upcase prefix))))))

(defun my/company-completion-finished (result)
  (when my/company-cmake-prefix
    (delete-char (- (length result)))
    (insert (upcase result))))

(defun my/cmake-mode-hook ()
  (add-hook 'company-completion-started-hook #'my/company-completion-started nil t)
  (add-hook 'company-completion-finished-hook #'my/company-completion-finished nil t))
(add-hook 'cmake-mode-hook #'my/cmake-mode-hook)
