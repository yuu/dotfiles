;;; package --- Summary
;;; Commentary:
;;; Code:

(straight-use-package '(hl-todo :type git :host github :repo "tarsius/hl-todo"))
(use-package hl-todo
  :defer t
  :ensure nil
  :custom
  (hl-todo-keyword-faces
    '(("TODO"   . "#FF0000")
       ("FIXME"  . "#FF0000")
       ("DEBUG"  . "#A020F0")
       ("GOTCHA" . "#FF4500")
       ("STUB"   . "#1E90FF"))))

(use-package google-translate
  :defer t
  :bind
  (("C-c t" . google-translate-enja-or-jaen))
  :config
  (setq google-translate-translation-directions-alist '(("en" . "ja") ("ja" . "en")))
  (defun google-translate-enja-or-jaen (&optional string)
    "Translate words in region or current position. Can also specify query with C-u"
    (interactive)
    (setq string
      (cond ((stringp string) string)
        (current-prefix-arg
          (read-string "Google Translate: "))
        ((use-region-p)
          (buffer-substring (region-beginning) (region-end)))
        (t
          (thing-at-point 'word))))
    (let* ((asciip (string-match
                     (format "\\`[%s]+\\'" "[:ascii:]’“”–")
                     string)))

      (run-at-time 0.1 nil 'deactivate-mark)
      (google-translate-translate
        (if asciip "en" "ja")
        (if asciip "ja" "en")
        string)))

  (defun remove-c-comment (args)
    (let ((text (nth 2 args)))
      (setf (nth 2 args) (replace-regexp-in-string "\n" " "
                           (replace-regexp-in-string "[ \t]*//[/*!]*[ \t]+" ""
                             (replace-regexp-in-string "[ \t]+\\(\\*[ \t]+\\)+" " " text))))
      args))

  (advice-add 'google-translate-request :filter-args #'remove-c-comment)

  :config/el-patch
  (el-patch-defun google-translate--search-tkk ()
    "Search TKK."
    (el-patch-swap
      (let ((start nil)
             (tkk nil)
             (nums '()))
        (setq start (search-forward ",tkk:'"))
        (search-forward "',")
        (backward-char 2)
        (setq tkk (buffer-substring start (point)))
        (setq nums (split-string tkk "\\."))
        (list (string-to-number (car nums))
          (string-to-number (car (cdr nums)))))
      (list 430675 2721866130)))
)

(use-package google-this
  :defer t
  :bind
  ("C-c / t" . google-this)
  ("C-c / w" . google-this-word)
  ("C-c / l" . google-this-line)
)

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package undo-tree
  :diminish undo-tree-mode
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.cache/emacs")))
  :config
  (global-undo-tree-mode))

(use-package undohist
  :defer t)

(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind
  ("C-c p" . 'projectile-command-map)
  :custom
  (projectile-switch-project-action 'projectile-dired)
  (projectile-completion-system 'ivy)
  :config
  (projectile-mode +1)
  (when (executable-find "ghq")
    (setq projectile-known-projects
          (mapcar
           (lambda (x) (abbreviate-file-name x))
           (split-string (shell-command-to-string "ghq list --full-path")))))
)

(use-package indent-guide
  :defer t)

(use-package rg
  :config
  (rg-enable-menu)
  (setq transient-display-buffer-action
        '(display-buffer-in-side-window
          (side . bottom)
          (window-height . fit-window-to-buffer)
          (window-width . nil)
          (dedicated . t)
          (inhibit-same-window . t)
          ))
  :custom
  (rg-align-position-numbers t)
  (rg-align-position-content-separator "|")
  (rg-custom-type-aliases '(("scss" . "*.scss"))))

(use-package yasnippet
  :diminish yas-minor-mode
  :bind
  (:map yas-minor-mode-map
    ("C-'". yas-expand)
    ([(tab)] . nil)
    ("TAB" . nil))
  :init
  (add-hook 'after-init-hook 'yas-global-mode))

;;; vsc
(defun magit-display-buffer-status-same-window (buffer)
  "Display BUFFER the way this has traditionally been done."
  (display-buffer
    buffer (if (with-current-buffer buffer
                 (derived-mode-p 'magit-status-mode))
             '(display-buffer-same-window)
             nil))) ; display in another window
(use-package magit
  :bind
  (("C-x c g" . magit-status))
  :config
  (set-face-foreground 'magit-branch-local "#AAFF00")
  (set-face-bold 'magit-branch-local t)
  (set-face-foreground 'magit-branch-remote "#EE4B2B")
  (set-face-bold 'magit-branch-remote t)
  :custom
  (magit-display-buffer-function 'magit-display-buffer-status-same-window)
  (magit-completing-read-function 'ivy-completing-read)
)

(use-package git-gutter
  :defer t
  :diminish git-gutter-mode
  :init (global-git-gutter-mode)
)

;;; org-mode
(straight-use-package 'org)
(use-package org
  :ensure nil
  :straight nil
  :bind
  (("C-c a" . 'org-agenda)
   ("C-c c" . 'org-capture))
  :custom-face
  (org-drawer ((t (:foreground "hot pink"))))
  :custom
  (org-directory (expand-file-name "~/.local/notes/"))
  (org-default-notes-file (concat org-directory "notes.org"))
  (org-agenda-files (directory-files-recursively org-directory "\\.org$"))
  (org-outline-path-complete-in-steps nil)
  (org-refile-targets
    `((,(seq-filter (lambda (file)
                      (not (string-match-p "archive" file)))
          (directory-files-recursively org-directory "\\.org$"))
        :maxlevel . 2)))
  (org-log-done 'time)
  (org-tag-alist '(("meeting" . ?m) ("office" . ?o) ("document" . ?d) ("kitting" . ?k) ("study" . ?s) ("travel" . ?t) ))
  (org-capture-templates
    '(("t" "Task" entry (file+headline "~/.local/notes/tasks.org" "Tasks") "* TODO %?")
       ("n" "Note" entry (file+headline org-default-notes-file "Notes") "* %?")
       ("c" "Note With Mark" entry (file+headline org-default-notes-file "Notes") "* %?\n %i\n %a")))
  (org-todo-keyword-faces
    '(("TODO"      :inherit (org-todo) :foreground "#D9A0A0" :weight bold)
       ("DONE"      :inherit (org-todo) :foreground "#BCE5BC" :weight bold)))
  (org-src-tab-acts-natively t)
  (org-startup-folded t)
  (org-use-speed-commands t)
  (org-fontify-todo-headline t)
  (org-hide-emphasis-markers t)
  (org-num-skip-unnumbered t)
  (org-html-validation-link nil)
  :config
  (org-babel-do-load-languages
    'org-babel-load-languages
    '(
       (shell . t)
       (emacs-lisp . emacs-lisp)
       (lisp . t)
       (dot . t)
       (makefile . makefile)
       (sql . t)
       (sqlite . t)
       ))
  (set-face-attribute 'org-headline-todo nil :foreground (face-attribute 'default :foreground))
  (set-face-attribute 'org-headline-done nil :foreground "#BCE5BC")
  (set-face-attribute 'org-level-1 nil :foreground "#ECBC9C")
  (set-face-attribute 'org-level-2 nil :foreground "#89C5C8")
  (set-face-attribute 'org-level-3 nil :foreground "#89C5C8"))

(defun org-find-file (file)
  "open file with org-directory"
  (interactive
    (list (let ((default-directory org-directory))
            (counsel-find-file))))
  (find-file file))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-appear-autoemphasis t)
  (org-appear-autolinks t))

(use-package org-roam
  :custom
  (org-roam-directory (file-truename (concat org-directory "roam"))))

(use-package org-pomodoro
  :custom
  (org-pomodoro-ask-upon-killing t)
  (org-pomodoro-format "T %s")
  (org-pomodoro-short-break-format "C %s")
  (org-pomodoro-long-break-format  "N %s")
  (org-pomodoro-start-sound-args "--volume 0.1")
  (org-pomodoro-finished-sound-args "--volume 0.1")
  (org-pomodoro-short-break-sound-args "--volume 0.1")
  (org-pomodoro-long-break-sound-args "--volume 0.1")
  :hook
  (org-pomodoro-started . (lambda () (alert
                                       "T Let's focus for 25 minutes!"
                                       :title "org-pomodoro")))
  (org-pomodoro-finished . (lambda () (alert
                                        "C Well done! Take a break."
                                        :title "org-pomodoro"))))

(use-package ob-rust
  :after org
  :config
  (org-babel-do-load-languages
    'org-babel-load-languages
    (append org-babel-load-languages
      '(
         (rust . t)
         ))))

; tramp-container
;; (use-package docker-tramp
;;   :custom
;;   (docker-tramp-use-names t))

(use-package yeetube
  :straight (:repo "https://codeberg.org/thanosapollo/emacs-yeetube.git")
  :init (define-prefix-command 'my/yeetube-map)
  :config
  (setq yeetube-mpv-disable-video t)
  :bind (("C-c y" . 'my/yeetube-map)
          :map my/yeetube-map
	  ("s" . 'yeetube-search)
	  ("b" . 'yeetube-play-saved-video)
	  ("d" . 'yeetube-download-videos)
	  ("p" . 'yeetube-mpv-toggle-pause)
	  ("v" . 'yeetube-mpv-toggle-video)
	  ("V" . 'yeetube-mpv-toggle-no-video-flag)
	  ("k" . 'yeetube-remove-saved-video)))

(use-package migemo
  :if (executable-find "cmigemo")
  :commands (migemo-init)
  :defer t
  :init
  (add-hook 'emacs-startup-hook 'migemo-init)
  :config
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/opt/homebrew/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode))
(use-package nov
  :straight (:repo "https://depp.brause.cc/nov.el.git"))

;;; 11-package.el ends here
