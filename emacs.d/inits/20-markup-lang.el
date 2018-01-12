(autoload 'gfm-mode "markdown-mode" "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
