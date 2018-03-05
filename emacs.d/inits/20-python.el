(require 'jedi-core)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(add-to-list 'company-backends 'company-jedi) ; backendに追加
