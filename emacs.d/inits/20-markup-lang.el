(autoload 'gfm-mode "markdown-mode" "Major mode for editing GitHub Flavored Markdown files" t)
(with-eval-after-load 'markdown-mode
    (setq
        markdown-split-window-direction 'right
        markdown-command "github-markup"
        markdown-command-needs-filename t
        markdown-css-paths (list "https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css")))

(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(autoload 'plantuml-mode "plantuml-mode" "plantuml-mode" t)
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(setq plantuml-jar-path "~/.emacs.d/el-get/plantuml-mode/bin/plantuml.jar")
