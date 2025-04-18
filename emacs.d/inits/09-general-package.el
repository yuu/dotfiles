;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package diminish)

(use-package el-patch
  :custom
  (el-patch-use-aggressive-defvar t))

;;;; modeline
(use-package smart-mode-line
  :init
  (setq sml/theme 'light)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

(use-package minions
  :hook (after-init. minions-mode)
  :config
  (setq minions-mode-line-lighter "[+]"))

;;;; theme
(use-package hc-zenburn-theme
  :config
  (load-theme 'hc-zenburn t)
  (set-face-background 'region "#696969"))

(use-package whitespace
  :ensure nil
  :defer t
  :commands whitespace-mode
  :config
  (setq whitespace-style '(face            ; faceで可視化
                            trailing       ; 行末
                            empty          ; 先頭/末尾の空行
                            tabs           ; タブ
                            tab-mark
                            spaces
                            space-mark     ; 表示のマッピング
                            ))

  (setq whitespace-display-mappings
    '((space-mark ?\u3000 [?\u25a1])
       (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (set-face-foreground 'whitespace-space "#7cfc00")
  (set-face-background 'whitespace-space 'nil)
  (set-face-bold 'whitespace-space t)
  (set-face-foreground 'whitespace-tab "#669125")
  (set-face-background 'whitespace-tab 'nil)
  (set-face-underline  'whitespace-tab t))

(use-package paren
  :ensure nil
  :hook
  (after-init . show-paren-mode)
  (after-init . electric-pair-mode)
  :custom
  (show-paren-delay 0)
  (show-paren-style 'parenthesis))

(use-package dired
  :ensure nil
  :straight nil
  :bind (:map dired-mode-map
          ("h" . dired-up-directory)
          ("l" . dired-find-file)
          ("J" . dired-goto-file)
          ("j" . dired-next-line)
          ("k" . dired-previous-line))
  :custom
  (dired-listing-switches "-alh"))

(use-package ansi-color
  :config
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  :hook (compilation-filter . my-colorize-compilation-buffer))

(use-package cua-mode
  :ensure nil
  :straight nil
  :bind ("C-x c TAB" . cua-rectangle-mark-mode))

(use-package alert
  :custom
  (alert-notifier-command "/opt/homebrew/bin/terminal-notifier")
  (alert-default-style 'notifier))

;;; 09-general-package.el ends here
