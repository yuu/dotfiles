;; howm
(global-set-key (kbd "C-x ,") 'howm-menu)
(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)

(setq howm-menu-lang 'ja)
(setq howm-use-color nil)
(setq howm-file-name-format "%Y/%m/%Y-%m-%dT%H%M%S.txt")
(setq howm-directory "~/Dropbox/howm/")
(setq howm-keyword-file (concat howm-directory ".howm-keys"))
(setq howm-menu-file (concat howm-directory "menu.txt"))
(setq howm-history-file (concat howm-directory ".howm-history"))


;; org-mode
;; These lines only if org-mode is not part of the X/Emacs distribution.
(autoload 'org-mode "org" "Org mode" t)
(autoload 'org-diary "org" "Diary entries from Org mode")
(autoload 'org-agenda "org" "Multi-file agenda from Org mode" t)

(global-set-key (kbd "C-x cc") 'org-capture)
(global-set-key (kbd "C-x ca") 'org-agenda)

(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

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
