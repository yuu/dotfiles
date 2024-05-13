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
  :config
  (editorconfig-mode))

(use-package projectile
  :bind
  ("C-c p" . 'projectile-command-map))

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
  :init (global-git-gutter-mode))

; tramp-container
;; (use-package docker-tramp
;;   :custom
;;   (docker-tramp-use-names t))

;;; 11-package.el ends here
