;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("M-y" . counsel-yank-pop)
  ("C-x b" . ivy-switch-buffer)
  ("C-x C-b" . counsel-ibuffer)
  ("C-x f" . counsel-git)
  ("C-x C-f" . counsel-find-file)
  ("M-s M-s" . swiper-thing-at-point)
  ("C-c i" . imenu)
  ("C-c g g" . counsel-rg)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  (enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1)
  (counsel-find-file-ignore-regexp (regexp-opt completion-ignored-extensions))
  :config
  (ivy-mode)
  (counsel-mode))

(use-package counsel-tramp
  :after counsel)

(use-package ivy-hydra
  :defer t
  :after counsel
  :ensure counsel
  :custom
  (ivy-read-action-function 'ivy-hydra-read-action))

;; (use-package ivy-xref
;;   :defer t
;;   :custom
;;   (xref-show-xrefs-function 'ivy-xref-show-xrefs)
;;   :init
;;   (when (>= emacs-major-version 27)
;;     (setq xref-show-definitions-function 'ivy-xref-show-defs))
;;   ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
;;   ;; commands other than xref-find-definitions (e.g. project-find-regexp) as well
;;   (setq xref-show-xrefs-function 'ivy-xref-show-xrefs))

(straight-use-package '(ivy-ghq :type git :host github :repo "analyticd/ivy-ghq"))
(use-package ivy-ghq
  :ensure nil
  :after counsel
  :commands (ghq ivy-ghq-open)
  :config
  (defalias 'ghq 'ivy-ghq-open))

(use-package ivy-yasnippet
  :ensure t
  :after yasnippet
  :bind (("C-c y" . ivy-yasnippet)))

;;; general
(use-package eldoc
  :defer t
  :ensure nil
  :config
  (defun ad:eldoc-message (f &optional string)
    (unless (active-minibuffer-window)
      (funcall f string)))
  (advice-add 'eldoc-message :around #'ad:eldoc-message))

(use-package quickrun
  :defer t
  :config
  (quickrun-add-command "c++/clang 1z"
    '((:command . "clang++")
       (:exec    . ("%c -std=c++17 -Wall -pedantic-errors %o -o %e %s"
                     "%e %a"))
       (:remove  . ("%e")))
    :default "c++"))

(use-package flycheck
  :defer t
  :custom
  (flycheck-check-syntax-automatically '(save))
  :bind (:map flycheck-mode-map
          ("M-n" . flycheck-next-error)
          ("M-p" . flycheck-previous-error))
)

(use-package prettier
  :defer t
  :bind
  ("C-c f f" . prettier-prettify))

;;; auto complete
(use-package company
  :bind
  (:map company-mode-map ("C-M-i" . company-complete))
  (:map company-active-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous)
    ("TAB" . company-complete-selection))
  (:map company-search-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous))
  :diminish company-mode
  :custom
  (company-idle-delay nil)
  (company-dabbrev-downcase nil)
  (company-dabbrev-ignore-case t)
  (completion-ignore-case t)
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (delete 'company-clang company-backends))

;;; lsp
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((rust-mode . lsp))
  :bind
  (:map lsp-mode ("C-c u d" . lsp-ui-doc-toggle))
  :custom
  ;; debug
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-headerline-breadcrumb-enable nil)
  (gc-cons-threshold 1600000)
  (read-process-output-max (* 1024 32768)) ;; 32mb
  (lsp-document-sync-method 'lsp--sync-incremental)
  (lsp-solargraph-use-bundler t)
  (lsp-prefer-capf t)
  (lsp-headerline-breadcrumb-enable nil)
)

(use-package lsp-ui
  :hook ((lsp-mode-hook . lsp-ui-mode))
  :bind
  (:map lsp-ui-mode-map
    ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
    ([remap xref-find-references] . lsp-ui-peek-find-references)))

; completion-map not working...
(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t
  :bind
  (:map copilot-mode-map ("TAB" . copilot-accept-completion))
)

;;; markup lang
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setq
    markdown-split-window-direction 'right
    markdown-command "github-markup"
    markdown-command-needs-filename t
    markdown-css-paths (list "https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css")))

(use-package markdown-toc)

(use-package plantuml-mode
  :mode
  (("\\.puml\\'" . plantuml-mode)
  ("\\.plantuml\\'" . plantuml-mode))
  :custom
  (plantuml-default-exec-mode 'jar)
  (plantuml-indent-level 2)
)

(use-package flycheck-plantuml
  :hook
  (plantuml-mode . flycheck-plantuml-setup)
  (plantuml-mode . flycheck-mode))

(use-package toml-mode)
(use-package yaml-mode)
(use-package json-mode)
(use-package csv-mode)
(use-package dockerfile-mode)
(use-package graphql-mode)

(use-package terraform-mode
  :hook
  (terraform-mode-hook . terraform-format-on-save-mode))

;;; cpp lang
(use-package modern-cpp-font-lock
  :defer t
  :hook
  (c++-mode . modern-c++-font-lock-mode))

(use-package ccls
  :defer t
  :hook
  (c++-mode . (lambda () (lsp))))

(use-package clang-format
  :defer t)
(use-package company-c-headers
  :defer t)

;;; rust lang
(use-package rust-mode
  :defer t
  :hook (rust-mode . lsp)
)

(use-package cargo
  :defer t
  :after rust-mode
  :hook
  (rust-mode-hook . cargo-minor-mode))

;;; swift lang
(use-package swift-mode
  :defer t)

;;; csharp
;; (use-package omnisharp
;;   :defer t
;;   :hook
;;   (csharp-mode-hook . omnisharp-mode)
;;   (csharp-mode-hook . (lambda () (add-to-list 'company-backends 'company-omnisharp))))

;;; web
(use-package web-mode
  :defer t
  :bind
  ("C-c TAB" . nil)
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.js\\'" . web-mode)
  ("\\.jsx\\'" . web-mode)
  ("\\.tsx\\'" . web-mode)
  ("\\.ts\\'" . web-mode)
  ("\\.d.ts\\'" . web-mode)
  ("\\.erb\\'" . web-mode)
  ("\\.twig\\'" . web-mode)
  :config
  (defcustom my-web-yas-mode-alist
    '(("erb" . erb)
       ("django" . django))
    ""
    :group 'web-mode
    :type '(repeat (cons
                     :tag "Map engine name to mode"
                     (string :tag "Engine Name")
                     (symbol :tag "Mode"))))

  :hook
  (web-mode-on-engine-setted . my-web-setup-yas)
  (web-mode . lsp-deferred)

  :custom
  (web-mode-content-types-alist '(("jsx"  . "\\.jsx?\\'")))
  (web-mode-content-types-alist '(("jsx"  . "\\.tsx?\\'")))
  (web-mode-engines-alist
    '(("djang" . "\\.twig\\'"))
  )
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (web-mode-enable-auto-pairing t)
  (web-mode-enable-auto-closing t)

  :init
  (defun my-web-setup-yas ()
    "Setup yas according tof `web-mode-engine`."
    (require 'yasnippet)
    (let ((extra-mode (cdr (assoc-string web-mode-engine my-web-yas-mode-alist))))
      (when extra-mode
        (yas-activate-extra-mode extra-mode)))))

(use-package add-node-modules-path
  :after web-mode
  :hook
  ((web-mode . add-node-modules-path)))

(use-package emmet-mode
  :defer t
  :after web-mode
  :hook (web-mode . emmet-mode))

;; See: https://qiita.com/watson1978/items/debafdfc49511fb173e9
(flycheck-define-checker ruby-rubocop
  "A Ruby syntax and style checker using the RuboCop tool."
  :command ("rubocop" "--format" "emacs"
             (config-file "--config" flycheck-rubocoprc) source)
  :error-patterns
  ((warning line-start
     (file-name) ":" line ":" column ": " (or "C" "W") ": " (message) line-end)
    (error line-start
      (file-name) ":" line ":" column ": " (or "E" "F") ": " (message) line-end))
  :modes (ruby-mode motion-mode))

;; (use-package rubocop
;;   :hook
;;   (ruby-mode-hook . rubocop-mode)
;;   (ruby-mode-hook . (lambda () (setq flycheck-checker 'ruby-rubocop)))
;; )

(use-package js-doc
  :defer t)

;; (straight-use-package '(compile-eslint :type git :host github :repo "Fuco1/compile-eslint"))
;; (use-package compile-eslint
;;   :ensure nil
;;   :config
;;   (push 'eslint compilation-error-regexp-alist))

;;; vtl
;; (use-package vtl-mode :defer t)

;;; php
(use-package php-mode
  :defer t
)

;;; 10-use-package.el ends here
