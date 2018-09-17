(with-eval-after-load 'company-go
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command))) ; start autocompletion only after typing

(defun my/go-mode-hook ()
  (flycheck-mode)
  (company-mode)
  (go-eldoc-setup)
  (add-to-list 'company-backends 'company-go)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8)
  (setq tab-width 8)
  (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'go-mode-hook 'my/go-mode-hook)
