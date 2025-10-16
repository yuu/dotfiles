;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package ffap)

(use-package counsel
  :diminish (ivy-mode counsel-mode)
  :hook (
          (after-init . ivy-mode)
          (after-init . counsel-mode))
  :bind
  ("M-x" . counsel-M-x)
  ("M-y" . counsel-yank-pop)
  ("C-x b" . ivy-switch-buffer)
  ("C-x C-b" . counsel-ibuffer)
  ("C-x f" . counsel-git)
  ("C-x C-f" . counsel-find-file-with-ffap)
  ("M-s M-s" . swiper-thing-at-point)
  ("C-c i" . imenu)
  ("C-c g g" . counsel-rg)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  (enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1)
  (counsel-find-file-ignore-regexp ".git/")
  (ivy-on-del-error-function 'ignore)
  :config
  (defun counsel-find-file-with-ffap ()
  "counsel-find-file file if ffap guessed"
  (interactive)
  (let ((file (ffap-guesser)))
    (if file
        (counsel-find-file file)
      (counsel-find-file))))
)

(use-package counsel-tramp
  :after counsel)

(use-package ivy-hydra
  :defer t
  :after counsel
  :ensure counsel
  :custom
  (ivy-read-action-function 'ivy-hydra-read-action))

(use-package counsel-projectile
  :hook ((after-init . counsel-projectile-mode)))

(use-package ivy-xref
  :defer t
  :bind
  ("M-m" . my/xref-push-marker-stack)
  :custom
  (xref-show-xrefs-function 'ivy-xref-show-xrefs)
  :init
  (when (>= emacs-major-version 27)
    (setq xref-show-definitions-function 'ivy-xref-show-defs))
  ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
  ;; commands other than xref-find-definitions (e.g. project-find-regexp) as well
  (setq xref-show-xrefs-function 'ivy-xref-show-xrefs)
  :config
  (defun my/xref-push-marker-stack ()
    "push xref marker"
    (interactive)
    (xref-push-marker-stack))
)

(use-package ivy-ghq
  :straight (:type git :host github :repo "analyticd/ivy-ghq")
  :after counsel
  :commands (ghq ivy-ghq-open)
  :config
  (defalias 'ghq 'ivy-ghq-open))

(use-package ivy-yasnippet
  :ensure t
  :after yasnippet
  :bind (("C-c y" . ivy-yasnippet)))

(use-package major-mode-hydra
  :ensure t
  :demand
  :bind
  ("M-SPC" . major-mode-hydra))

(pretty-hydra-define
  my/global-hydra-command-palette
  (:separator "-" :color teal :foreign-key warn :title "Global Palette" :quit-key "q")
  ("File"
    (
      ;; ("p" projectile-hydra/body "Projectile")
      ("f" counsel-find-file     "Find File")
      ;; ("d" counsel-find-dir      "Find Dir")
      ("r" counsel-recentf       "Recentf")
      ;; ("L" counsel-locate        "Locate")
      )

    ;; "Edit"
    ;; (("a" align-regexp "Align Regexp")
    ;;  ("[" origami-hydra/body "Origami")
    ;;  (";" comment-dwim "Comment"))

    "Code"
    (("G" counsel-projectile-rg            "Grep")
      ;; ("j" dumb-jump-pretty-hydra/body      "Dumb jump")
      ;; ("g" avy-hydra/body                   "Avy")
      ;; ("l" pretty-hydra-lsp/body            "LSP")
      ;; ("i" counsel-imenu                    "imenu")
      ;; ("y" yasnippet-hydra/body             "Yasnippet")
      ;; ("B" browse-at-remote                 "Browse")
      ;; ("C" blamer-show-posframe-commit-info "Bramer")
      ("g" magit-status                     "Magit"))

    "View"
    (("D" delete-other-windows      "Only This Win")
      ("h" windmove-left "focus left")
      ("j" windmove-down "focus down")
      ("k" windmove-up "focus up")
      ("l" windmove-right "focus right"))
    "Tool"
    (("SPC" major-mode-hydra         "Hydra(Major)")
      ;; ("h"   my/project-hydra         "Hydra(Project)")
      ;; ("s"   toggle-hydra/body        "Toggle switches")
      ;; ("A"   copilot-chat-hydra/body  "Copilot Chat")
      ("o"   global-org-hydra/body    "Org")
      ;; ("e"   el-get-hydra/body        "el-get")
      ;; ("k"   kibela-hydra/body        "Kibela")
      ;; ("/"   google-pretty-hydra/body "Google")
      ;; ("t"   subtools-hydra/body      "Sub Tools")
      )))

(pretty-hydra-define
  global-org-hydra
  (:separator "=" :title "Global Org commands")
  ("Main"
    (("a" org-agenda "Agenda")
      ("c" counsel-org-capture "Capture")
      ("C" org-roam-dailies-capture-today "Capture today")
      ("l" org-store-link "Store link")
      ("F" org-roam-node-find "Find")
      ;; ("t" my/org-tags-view-only-todo "Tagged Todo")
      ;; ("F" org-gcal-fetch "Fetch Calendar")
      ;; ("C" my/open-user-calendar "Calendar"))
      )
    "Clock"
    (("i" org-clock-in  "In")
      ("o" org-clock-out "Out")
      ("r" org-clock-in-last "Restart")
      ("x" org-clock-cancel "Cancel")
      ("j" org-clock-goto "Goto")
      ("r" org-clock-report "Report"))))

;;; general
(use-package eldoc
  :defer t
  :straight (:type built-in)
  :diminish eldoc-mode
  :config
  (defun ad:eldoc-message (f &optional string)
    (unless (active-minibuffer-window)
      (funcall f string)))
  (advice-add 'eldoc-message :around #'ad:eldoc-message))

(use-package imenu-list
  :bind
  ("<f10>" . imenu-list-smart-toggle)
  :custom-face
  (imenu-list-entry-face-1 ((t (:foreground "white"))))
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize nil)
)

(use-package quickrun
  :defer t
  :config
  (quickrun-add-command "c++/clang 1z"
    '((:command . "clang++")
       (:exec    . ("%c -std=c++17 -Wall -pedantic-errors %o -o %e %s"
                     "%e %a"))
       (:remove  . ("%e")))
    :default "c++"))

;;; General Syntax
(use-package treesit
  :straight (:type built-in)
  :custom
  (treesit-font-lock-level 4)
  :config
  (dolist (mapping
            '(
               (sh-mode . bash-ts-mode)
               (sh-base-mode . bash-ts-mode)
               (js-json-mode json-ts-mode)
               (yaml-mode yaml-ts-mode) ; via nothing
               (conf-toml-mode . toml-ts-mode)
               (c-mode . c-ts-mode)
               (c++-mode . c++-ts-mode)
               (c-or-c++-mode . c-or-c++-ts-mode)
               (css-mode . css-ts-mode)
               (html-mode . html-ts-mode)
               (js-mode . js-ts-mode)
               (python-mode . python-ts-mode)
               (ruby-mode . ruby-ts-mode)
               ))
    (add-to-list 'major-mode-remap-alist mapping)))

(defun treesit/setup-install-grammars ()
  "Install tree-sitter grammmars"
  (interactive)
  (dolist (grammar
            '(
               (bash "https://github.com/tree-sitter/tree-sitter-bash" "v0.23.3")
               (json "https://github.com/tree-sitter/tree-sitter-json" "v0.24.8")
               (yaml "https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0") ; 13
               (toml "https://github.com/tree-sitter/tree-sitter-toml" "v0.5.1") ; 13
               (kdl "https://github.com/tree-sitter-grammars/tree-sitter-kdl" "v1.1.0")
               (cmake "https://github.com/uyha/tree-sitter-cmake" "v0.7.1")
               (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile" "v0.2.0")
               (typespec "https://github.com/yuu/tree-sitter-typespec" "v0.23.0")
               (c "https://github.com/tree-sitter/tree-sitter-c" "v0.23.6")
               (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.23.4")
               (rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.3")
               (haskell "https://github.com/tree-sitter/tree-sitter-haskell" "v0.23.1")
               (css "https://github.com/tree-sitter/tree-sitter-css" "v0.23.2")
               (html "https://github.com/tree-sitter/tree-sitter-html" "v0.23.2")
               (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "v0.23.1")
               (jsdoc "https://github.com/tree-sitter/tree-sitter-jsdoc" "v0.23.2")
               (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "tsx/src"))
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "typescript/src"))
               (prisma "https://github.com/victorhqc/tree-sitter-prisma" "v1.5.1")
               (python "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6")
               (ruby "https://github.com/tree-sitter/tree-sitter-ruby" "v0.23.1")
               (php . ("https://github.com/tree-sitter/tree-sitter-php" "v0.23.12" "php/src"))
               (phpdoc "https://github.com/claytonrcarter/tree-sitter-phpdoc" "v0.1.6")
               ))
    (add-to-list 'treesit-language-source-alist grammar)
    ;; Only install `grammar' if we don't already have it
    ;; installed. However, if you want to *update* a grammar then
    ;; this obviously prevents that from happening.
    (unless (treesit-language-available-p (car grammar))
      (treesit-install-language-grammar (car grammar))))
  )

;;; Linter / Formatter
(use-package flycheck
  :defer t
  :init
  (setq display-buffer-alist '(("\\*\\(Flycheck\\|Project\\) errors\\*"
                          (display-buffer-in-side-window)
                          (side . bottom)
                          (window-height . 0.20)
                          (window-width . nil)
                          (dedicated . t)
                          (inhibit-same-window . t)
                          )))
  :custom
  (flycheck-check-syntax-automatically '(save))
  :bind (:map flycheck-mode-map
          ("M-n" . flycheck-next-error)
          ("M-p" . flycheck-previous-error))
)

(use-package flycheck-projectile
  :after (flycheck projectile)
  :bind (:map projectile-mode-map
          ("C-c p ! l" . flycheck-projectile-list-errors)))

(use-package reformatter
  :defer t
  :bind
  ("C-c f f" . refmt-pretty-buffer)
  :config
  (defun refmt-pretty-buffer ()
    "Buffer format function that dispatches to the appropriate formatter."
    (interactive)
    (cond
      ((derived-mode-p 'web-mode 'typescript-ts-mode 'tsx-ts-mode 'php-mode 'scss-mode)
        (refmt-prettier-format-buffer))
      ((derived-mode-p 'rust-mode)
        (rust-format-buffer))
      ((derived-mode-p 'prisma-mode)
        (refmt-prisma-format-buffer))
      ((derived-mode-p 'sql-mode)
        (refmt-sql-format-buffer))

      ;; 他のモードに対するフォーマッタをここに追加
      (t (message "No formatter defined for this mode."))))

  (reformatter-define refmt-prettier-format
    :program "npx"
    :args (let ((filepath (or buffer-file-name (buffer-name))))
            `("prettier" "--stdin-filepath" ,filepath))
    :lighter " prettier-auto-fmt")
  (reformatter-define refmt-prisma-format
    :program "npx"
    :args `("prisma" "format" ,buffer-file-name)
    :lighter " prisma-auto-fmt")
  (reformatter-define refmt-sql-format
    :program "sleek"
    :args `()
    :lighter " sql-auto-fmt")
  (reformatter-define refmt-ruby-format
    :program "bundle"
    :args `("exec", "rubocop", "-a")
    :lighter " ruby-rubocop-auto-fmt"))

;;; auto complete
(use-package company
  :bind
  (:map company-mode-map ("C-M-i" . company-complete))
  (:map company-active-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous)
    ("TAB" . company-complete-selection)
    ("C-s" . company-filter-candidates))
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
  (delete 'company-clang company-backends)
  (add-to-list 'company-backends 'company-keywords-gherkin))

;;; lsp
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :bind
  (:map lsp-mode ("C-c u d" . lsp-ui-doc-toggle))
  :custom
  (lsp-keymap-prefix "C-c l")
  ;; debug
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-headerline-breadcrumb-enable nil)
  (gc-cons-threshold 1600000)
  (read-process-output-max (* 1024 32768)) ;; 32mb
  ;; (lsp-document-sync-method 'lsp--sync-incremental)
  ;; (lsp-solargraph-use-bundler t)
  (lsp-prefer-capf t)
  (lsp-warn-no-matched-clients nil)
  (lsp-restart 'ignore)
  :config
  (add-to-list 'lsp-language-id-configuration '(web-mode . "twig"))
  (lsp-dependency 'twiggy-language-server
    '(:system "twiggy-language-server")
    '(:npm :package "twiggy-language-server"
       :path "twiggy-language-server"))
  (lsp-register-client
    (make-lsp-client
      :new-connection (lsp-stdio-connection '("npx" "twiggy-language-server" "--stdio"))
      :activation-fn (lambda (file-name _mode)
                       (string-match-p "\\.twig\\'" file-name))
      :server-id 'twig-ls
      :download-server-fn (lambda (_client callback error-callback _update?)
                            (lsp-package-ensure 'twiggy-language-server
                              callback error-callback))))

  (lsp-register-client
    (make-lsp-client
      :new-connection (lsp-stdio-connection '("bundle" "exec" "solargraph" "stdio"))
      :major-modes '(ruby-mode)
      :server-id 'ruby-ls))

  (lsp-dependency 'intelephense-language-server
    '(:system "intelephense-language-server")
    '(:npm :package "intelephense"
       :path "intelephense"))
  (lsp-register-client
    (make-lsp-client
      :new-connection (lsp-stdio-connection `("intelephense" "--stdio"))
      :priority -1
      :major-modes '(php-mode)
      :server-id 'php-lsp
      :download-server-fn (lambda (_client callback error-callback _update?)
                            (lsp-package-ensure 'intelephense-language-server
                              callback error-callback)))))

(use-package lsp-ui
  :hook ((lsp-mode-hook . lsp-ui-mode))
  :bind
  (:map lsp-ui-mode-map
    ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
    ([remap xref-find-references] . lsp-ui-peek-find-references)))

;;; Debugger
(use-package dap-mode
  :config
  (dap-mode 1)
  (dap-auto-configure-mode 1))

;;; AI
(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t
  :bind
  (:map copilot-mode-map ("TAB" . copilot-accept-completion)))

;;; markup lang
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setopt markdown-command '("pandoc" "--from=gfm+hard_line_breaks" "--to=html5"))
  (setopt markdown-fontify-code-blocks-natively t)
  (setopt markdown-header-scaling nil)
  (setopt markdown-indent-on-enter 'indent-and-new-item)
  (setopt markdown-xhtml-body-preamble "<div class=\"markdown-body\">")
  (setopt markdown-xhtml-body-epilogue "</div>")
  (setopt markdown-css-paths (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.7.0/github-markdown.min.css")))

(use-package markdown-toc)

(use-package plantuml-mode
  :mode
  (("\\.puml\\'" . plantuml-mode)
  ("\\.plantuml\\'" . plantuml-mode))
  :custom
  (plantuml-default-exec-mode 'jar)
  (plantuml-indent-level 2))

(use-package flycheck-plantuml
  :hook
  (plantuml-mode . flycheck-plantuml-setup)
  (plantuml-mode . flycheck-mode))

(use-package mermaid-mode
  :after org)

(use-package json-ts-mode
  :straight (:type built-in)
  :mode (("\\.json\\'" . json-ts-mode)))

(use-package yaml-ts-mode
  :straight (:type built-in)
  :mode (("\\.yml\\'" . yaml-ts-mode)
          ("\\.yaml\\'" . yaml-ts-mode)))

(use-package toml-ts-mode
  :straight (:type built-in)
  :mode (("\\.toml\\'" . toml-ts-mode)))

(use-package kdl-mode
  :straight (:host github :repo "taquangtrung/emacs-kdl-mode" :branch "main"))

(use-package csv-mode)

;;; docker
(use-package dockerfile-ts-mode
  :straight nil
  :mode (("[/\\]\\(?:Containerfile\\|Dockerfile\\)\\(?:\\.[^/\\]*\\)?\\'" . dockerfile-ts-mode)
          ("\\.dockerfile\\'" . dockerfile-ts-mode)))

(use-package lsp-docker
  :custom
  (lsp-docker-log-docker-supplemental-calls t))

(use-package graphql-mode)

(use-package terraform-mode
  :hook
  (terraform-mode-hook . terraform-format-on-save-mode))

(use-package rego-mode
  :ensure t)

(use-package typespec-ts-mode)

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
  :hook ((rust-mode . lsp-deferred))
  ;; :custom
  ;; (rust-mode-treesitter-derive t)
  :config
  (define-key rust-mode-map (kbd "C-c C-f") nil))

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
  ("C-c C-n". web-mode-element-end)
  ("C-c C-p". web-mode-element-beginning)
  :mode
  ("\\.html\\'" . web-mode)
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
  (web-mode . my-web-mode-twig-setup)

  :custom
  (web-mode-content-types-alist '(("jsx"  . "\\.jsx?\\'")))
  (web-mode-content-types-alist '(("jsx"  . "\\.tsx?\\'")))
  (web-mode-engines-alist
    '(("django" . "\\.twig\\'"))
  )
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (web-mode-enable-auto-pairing t)
  (web-mode-enable-auto-closing t)
  (web-mode-enable-current-element-highlight t)

  :init
  (defun my-web-setup-yas ()
    "Setup yas according tof `web-mode-engine`."
    (require 'yasnippet)
    (let ((extra-mode (cdr (assoc-string web-mode-engine my-web-yas-mode-alist))))
      (when extra-mode
        (yas-activate-extra-mode extra-mode))))
  (defun my-web-mode-twig-setup ()
    "Custom setup for .twig files in web mode."
    (when (string-equal "twig" (file-name-extension buffer-file-name))
      (electric-pair-local-mode -1)))
)

(use-package emmet-mode
  :defer t
  :after web-mode
  :hook (web-mode . emmet-mode))

(use-package js-ts-mode
  :straight nil
  :hook (typescript-ts-mode . lsp-deferred))

(use-package jsdoc
  :straight (:host github :repo "isamert/jsdoc.el"))

(use-package typescript-ts-mode
  :straight nil
  :mode (("\\.m?ts\\'" . typescript-ts-mode))
  :hook (typescript-ts-mode . lsp-deferred))

(use-package tsx-ts-mode
  :straight nil
  :mode (("\\.tsx\\'" . tsx-ts-mode))
  :hook (tsx-ts-mode . lsp-deferred))

(use-package tsx-ts-helper-mode
  :straight (tsx-ts-helper-mode
             :type git
             :host codeberg
             :repo "ckruse/tsx-ts-helper-mode")
  :commands (tsx-ts-helper-mode)
  :hook (tsx-ts-mode . tsx-ts-helper-mode))

(use-package lsp-tailwindcss
  :straight '(lsp-tailwindcss :type git :host github :repo "merrickluo/lsp-tailwindcss")
  :init (setq lsp-tailwindcss-add-on-mode t)
  :config
  (dolist (tw-major-mode
            '(css-mode
               css-ts-mode
               js-ts-mode
               typescript-mode
               typescript-ts-mode
               tsx-ts-mode
               clojure-mode))
    (add-to-list 'lsp-tailwindcss-major-modes tw-major-mode)))

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

;; (straight-use-package '(compile-eslint :type git :host github :repo "Fuco1/compile-eslint"))
;; (use-package compile-eslint
;;   :ensure nil
;;   :config
;;   (push 'eslint compilation-error-regexp-alist))

;;; vtl
;; (use-package vtl-mode :defer t)

;;; php
(use-package php-ts-mode
  :straight (:type built-in)
  :hook ((php-ts-mode . lsp-deferred)))
;; (use-package php--mode
;;   :defer t
;;   :config
;;   (define-key php-mode-map (kbd "C-c C-f") nil)
;;   (define-key php-mode-map (kbd "C-c RET") nil)
;; )

(use-package flycheck-phpstan)

;;; golang
(use-package go-mode
  :defer t)

(use-package prisma-mode
  :straight (:host github :repo "pimeys/emacs-prisma-mode" :branch "main"))

(use-package lua-mode)

(use-package protobuf-mode)

(use-package ruby-ts-mode
  :straight (:type built-in)
  :mode (("db/schemas/.*\\.schema\\'" . ruby-ts-mode))
  :hook (ruby-ts-mode . lsp-deferred))

(use-package conf-mode
  :defer t
  :mode
  ("\\.env\\'" . conf-mode))

(use-package slime
  :config
  (setq inferior-lisp-program "sbcl"))

(use-package eww
  :bind (:map eww-mode-map
          ("n" . scroll-up)
          ("p" . scroll-down)
          ("N" . eww-next-url)
          ("P" . eww-previous-url)))

;;; 10-use-package.el ends here
