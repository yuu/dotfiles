;; org-mode
;; These lines only if org-mode is not part of the X/Emacs distribution.
(autoload 'org-mode "org" "Org mode" t)
(autoload 'org-agenda-mode "org" "Multi-file agenda from Org mode" t)
(with-eval-after-load 'org
  (setq org-startup-with-inline-image t)
  ;; DONEの時刻を記録
  (setq org-log-done 'time)

  (setq org-directory "~/Dropbox/org")
  (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
  (setq org-mobile-inbox-for-pull (concat org-mobile-directory "/notes.org"))

  (setq org-default-notes-file (concat org-directory "notes.org"))
  ; this is don't working now...
  (setq org-agenda-files (file-expand-wildcards (concat org-directory "/*.org")))

  ; http://orgmode.org/manual/Template-elements.html#Template-elements
  ; http://orgmode.org/manual/Template-expansion.html#Template-expansion
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/Dropbox/org/task.org" "Tasks")
           "* TODO %?\n  %U")
          ("n" "Note" entry (file "~/Dropbox/org/notes.org")
           "* %?")
          ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
           "* %?")
          ("r" "Reading" entry (file+function "~/Dropbox/org/reading.org" helm-occur)
           "* %?")
          ))

  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  (setq org-plantuml-jar-path "~/.emacs.d/el-get/plantuml-mode/bin/plantuml.jar"))

(global-set-key (kbd "C-x cc") 'org-capture)
(global-set-key (kbd "C-x ca") 'org-agenda)
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
