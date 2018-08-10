(autoload 'company-go "company-go" nil nil)
(with-eval-after-load 'company-go
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command))) ; start autocompletion only after typing

(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda ()
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (add-hook 'go-mode-hook 'go-eldoc-setup)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)
                          (setq indent-tabs-mode t)
                          (setq c-basic-offset 8)
                          (setq tab-width 8)))
