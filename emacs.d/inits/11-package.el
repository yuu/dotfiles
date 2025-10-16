;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package hl-todo
  :defer t
  :straight (:type git :host github :repo "tarsius/hl-todo")
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
  (undo-tree-history-directory-alist '(("." . "~/.cache/emacs/undo")))
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
(use-package org
  :straight t
  :bind
  (("C-c a" . 'org-agenda)
    ("C-c c" . 'org-capture))
  :custom-face
  (org-drawer ((t (:foreground "hot pink"))))
  :custom
  (org-directory (expand-file-name "~/.local/notes/"))
  (org-default-notes-file (concat org-directory "notes.org"))
  (org-agenda-files (seq-filter (lambda (file)
                                   (not (or (string-match-p "_archive\\.org$" file)
                                            (string-match-p "/roam/" file))))
                                 (directory-files-recursively org-directory "\\.org$")))
  (org-outline-path-complete-in-steps nil)
  (org-archive-location "%s_archive.org::")
  (org-refile-targets
    `((,(seq-filter (lambda (file)
                      (not (string-match-p "archive" file)))
          (directory-files-recursively org-directory "\\.org$"))
        :maxlevel . 1)))
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
  (org-display-remote-inline-images 'cache)
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
  (set-face-attribute 'org-level-3 nil :foreground "#89C5C8")
  (dolist (pair '(
                   ("ts" . typescript-ts)
                   ("tsx" . tsx-ts)
                   ))
    (setf (alist-get (car pair) org-src-lang-modes nil nil #'string=)
      (cdr pair)))
  :mode-hydra
  (org-mode (:title "Org")
    ("Insert"
      (("l" org-insert-link "Link"))

      "Roam"
      (("i" org-roam-node-insert "Roam Node Insert")
        ("t" org-roam-buffer-toggle "Toggle Roam Buffer")
        ("a" org-roam-alias-add "Add Roam Alias"))

      "Edit"
      (("A" org-archive-subtree "Archive"))

      "View"
      (("N" org-toggle-narrow-to-subtree "Toggle Subtree")
        ;; ("D" my/org-clock-toggle-display "Toggle Display")
        ("L" org-toggle-link-display "Toggle Link Display"))
      )))

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
  (org-appear-autolinks t)
  (org-bullets-bullet-list
    '(
       "◉"
       "○"
       "◆"
       "✿"
       ;; ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
       ;; ► • ★
       )))

(use-package org-roam
  :custom
  (org-roam-directory (file-truename (concat org-directory "roam")))
  (org-roam-capture-templates
    '(("d" "default" plain "%?"
        :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                  "#+STARTUP: indent showall\n#+title: ${title}\n")
        :unnarrowed t)))
  )

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

(use-package org-ai
  :ensure t
  :after yasnippet
  :commands (org-ai-mode
              org-ai-global-mode)
  :hook ((after-init . (org-ai-global-mode))
          (org-mode-hook . org-ai-mode))
  :custom
  (org-ai-service 'anthropic)
  (org-ai-default-chat-model "claude-sonnet-4-20250514")
  (org-ai-default-max-tokens 2000)
  :config
  (org-ai-install-yasnippets))

(use-package ob-rust
  :after org
  :config
  (org-babel-do-load-languages
    'org-babel-load-languages
    (append org-babel-load-languages
      '(
         (rust . t)
         ))))

(use-package ob-mermaid
  :after org
  :config
  (org-babel-do-load-languages
    'org-babel-load-languages
    (append org-babel-load-languages
      '(
         (mermaid . t)
         ))))

(use-package ox-gfm
  :straight (:host github :repo "yuu/ox-gfm"))

; tramp-container
;; (use-package docker-tramp
;;   :custom
;;   (docker-tramp-use-names t))

(use-package yeetube
  :straight (:repo "https://codeberg.org/thanosapollo/emacs-yeetube.git")
  :init (define-prefix-command 'my/yeetube-map)
  :custom
  (yeetube-results-limit  50)
  (yeetube-mpv-additional-flags '("--no-video"))
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

(use-package feature-mode
  :custom
  (feature-default-language "ja")
  (feature-i18n-file "~/.local/share/gherkin/gherkin-languages.json"))

(use-package string-inflection
  :straight (:type git :host github :repo "akicho8/string-inflection"))

;;; 11-package.el ends here
