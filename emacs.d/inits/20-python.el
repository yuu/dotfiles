(with-eval-after-load 'compnay-jedi
  (defvar jedi:complete-on-dot t)
  (defvar jedi:use-shortcuts t))

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

(with-eval-after-load 'quickrun
  (quickrun-add-command "python3"
    '((:command . "python3"))
    :default "python"))
