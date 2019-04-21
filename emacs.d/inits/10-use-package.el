;;;; modeline
(use-package smart-mode-line
  :init
  (setq sml/theme 'light)
  (setq sml/no-confirm-load-theme t)
  (sml/setup)
)

;;;; theme
(use-package hc-zenburn-theme
  :init (load-theme 'hc-zenburn t)
  :config
  (set-face-background 'region "#696969")
  (set-frame-parameter nil 'alpha 85)
)

(use-package whitespace
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
  (set-face-underline  'whitespace-tab t)
)

;;;; keybind
(global-unset-key (kbd "C-x C-b"))
(global-unset-key (kbd "M-g g"))
(global-unset-key (kbd "C-h C-p")) ;view-emacs-problems
(global-unset-key (kbd "C-h n")) ;view-emacs-news
(global-unset-key (kbd "C-h C-n")) ;view-emacs-news
(global-unset-key (kbd "C-x ;"))

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>")) ; C-h BackSpace
(global-set-key (kbd "M-k")(lambda () (interactive) (kill-line 0))) ; backward kill line
(global-set-key (kbd "C-c ;") 'comment-line)

;; C-w 単語削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

;;;; packages
(use-package helm
  :bind (
  ("M-x" . helm-M-x)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  ("C-x f" . helm-find-files)
  ("C-x C-b" . helm-for-files)
  ("C-x C-f" . helm-ls-git-ls)
  ("C-c i" . helm-imenu)
  ("C-x r l" . helm-bookmarks))
  :init
  (use-package helm-ls-git
    :config
    (custom-set-variables
      '(helm-source-ls-git (helm-ls-git-build-ls-git-source))
    )
  )
  (use-package helm-xref
    :config
    (setq xref-show-xrefs-function 'helm-xref-show-xrefs))
  (use-package helm-tramp)
  (use-package docker-tramp)
  (use-package helm-ghq)
  :config
  (custom-set-variables
    '(helm-split-window-default-side 'right)
    '(helm-mini-default-sources
      '(helm-source-buffers-list
        helm-source-bookmarks
        helm-source-recentf
        helm-source-file-cache))
  )
)
(use-package undo-tree
  :diminish undo-tree-mode
  :init (global-undo-tree-mode)
)

(use-package yasnippet
  :diminish yas-minor-mode
  :init (yas-global-mode)
)

(use-package editorconfig
  :init (editorconfig-mode)
)

(use-package rg
  :config
  (rg-enable-default-bindings "\M-s")
  (setq rg-group-result t)
  (setq rg-align-position-numbers t)
  (setq rg-align-position-content-separator "|")
)

;;; vsc
(use-package magit
  :bind
  (("C-x c g" . magit-status))
  :config
  (set-face-foreground 'magit-branch-local "brightgreen")
  (set-face-bold 'magit-branch-local t)
  (set-face-foreground 'magit-branch-remote "brightred")
  (set-face-bold 'magit-branch-remote t)
)

(use-package git-gutter
  :init (global-git-gutter-mode)
)

;;; about frontend
(use-package company
  :bind
  (:map company-mode-map
    ("C-M-i" . company-complete))
  (:map company-active-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous)
    ("TAB" . company-complete-selection))
  (:map company-search-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous))
  :diminish company-mode
  :init
  (global-company-mode)
  (set-face-background 'company-preview "green")
  :custom
  (company-idle-delay nil)
  :config
  (delete 'company-clang company-backends)
)

(use-package lsp-mode
  :commands lsp
  :custom
  ;; debug
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental)
  (lsp-enable-completion-at-point nil)
)

(use-package company-lsp
  :after lsp-mode

)

;;; markup lang
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setq
    markdown-split-window-direction 'right
    markdown-command "github-markup"
    markdown-command-needs-filename t
    markdown-css-paths (list "https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css"))
)
(use-package markdown-toc)
(use-package plantuml-mode
  :mode
  (("\\.puml\\'" . plantuml-mode)
  ("\\.plantuml\\'" . plantuml-mode))
  :config
  (setq plantuml-jar-path "~/.emacs.d/straight/repos/plantuml-mode/bin/plantuml.jar")
)
(use-package toml-mode)
(use-package dockerfile-mode)
(use-package yaml-mode)

;;; cpp lang
(use-package modern-cpp-font-lock
  :diminish
  :hook
  (c++-mode . modern-c++-font-lock-mode)
)

(use-package ccls
  :hook
  (c++-mode . (lambda () (lsp)))
)

(use-package clang-format)
(use-package company-c-headers)
