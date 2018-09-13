(with-eval-after-load 'jedi-core
  (setq jedi:complete-on-dot t)
  (setq jedi:use-shortcuts t))
(add-to-list 'company-backends 'company-jedi)

(with-eval-after-load 'quickrun
  (quickrun-add-command "python3"
    '((:command . "python3"))
    :default "python"))
