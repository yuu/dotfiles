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
(global-set-key (kbd "C-x c") 'org-capture)

(add-hook 'org-mode-hook 'howm-mode)
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))

(setq org-startup-with-inline-image t)
;; DONEの時刻を記録
(setq org-log-done 'time)

(setq org-directory "~/Dropbox/org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-inbox-for-pull (concat org-mobile-directory "/notes.org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(require 'find-lisp)
(setq org-agenda-files
    (find-lisp-find-files org-directory "\.org$"))

(setq org-agenda-files
      (mapcar (lambda (basename)
                (concat org-directory (symbol-name basename) ".org"))
              '(f3 f1 f2)))
