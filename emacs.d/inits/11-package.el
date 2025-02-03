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
(use-package org
  :ensure nil
  :straight nil
  :bind
  (("C-c a" . 'org-agenda)
   ("C-c c" . 'org-capture))
  :custom
  (org-directory (expand-file-name "~/.local/notes/"))
  (org-default-notes-file (concat org-directory "notes.org"))
  (org-default-tasks-file (concat org-directory "tasks.org"))
  (org-agenda-files (directory-files-recursively org-directory "\\.org$"))
  (org-refile-targets
    `((,(seq-filter (lambda (file)
                      (not (string-match-p "archive" file)))
          (directory-files-recursively org-directory "\\.org$"))
        :level . 2)))
  (org-log-done 'time)
  (org-time-stamp-formats '("<%Y-%m-%dT%H:%M:%S>" . "<%Y-%m-%dT%H:%M:%S>"))
  (org-tag-alist '(("meeting" . ?m) ("office" . ?o) ("document" . ?d) ("kitting" . ?k) ("study" . ?s) ("travel" . ?t) ))
  (org-capture-templates
    '(("t" "Task" entry (file+headline org-default-tasks-file "Tasks") "* TODO %?" :empty-lines 1)
       ("n" "Note" entry (file+headline org-default-notes-file "Notes") "* %?")
       ("c" "Note With Mark" entry (file+headline org-default-notes-file "Notes") "* %?\n %i\n %a")
       ))
  (org-src-tab-acts-natively t)
  (org-startup-folded t)
  :config
  (major-mode-hydra-define
    global-org-hydra
    (:separator "-"
     :quit-key "q"
     :color teal
     :foreign-key warn
     :title "Global Org commands")

     ("Navigation"
       (("H" counsel-outline "Outline"))

      "Insert"
       (("l" org-insert-link                     "Link")
        ("T" org-insert-todo-heading             "Todo")
        ("h" org-insert-heading-respect-content  "Heading")
        ("P" org-set-property                    "Property")
        ("." org-time-stamp                      "Timestamp")
        ("!" org-time-stamp-inactive             "Timestamp(inactive)")
        ("S" org-insert-structure-template       "Snippet"))

     "Edit"
     (("a" org-archive-subtree  "Archive")
      ("r" org-refile           "Refile")
      ("Q" org-set-tags-command "Tag"))

     "View"
     (("N" org-toggle-narrow-to-subtree "Toggle Subtree")
      ("C" org-columns "Columns")
      ("O" org-global-cycle "Toggle open")
      ("D" my/org-clock-toggle-display  "Toggle Display"))

     "Task"
     (("s" org-schedule         "Schedule")
      ("d" org-deadline         "Deadline")
      ("t" my/org-todo          "Change state")
      ("c" org-toggle-checkbox  "Toggle checkbox"))

     "Clock"
     (("i" org-clock-in      "In")
      ("o" org-clock-out     "Out")
      ("E" org-set-effort    "Effort")
      ("R" org-clock-report  "Report")
      ("p" org-pomodoro      "Pomodoro"))

     "Babel"
     (("e" org-babel-confirm-evaluate "Eval")
      ("x" org-babel-tangle "Export SRC"))

     "Agenda"
     (("," org-cycle-agenda-files "Cycle"))))
)

(use-package org-tempo
    :straight nil)

(defun org-find-file (file)
  "open file with org-directory"
  (interactive
    (list (let ((default-directory org-directory))
            (counsel-find-file))))
  (find-file file))

; tramp-container
;; (use-package docker-tramp
;;   :custom
;;   (docker-tramp-use-names t))

;;; 11-package.el ends here
