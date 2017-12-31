(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle init-loader)
(el-get-bundle helm)
(el-get-bundle helm-tramp)
(el-get-bundle helm-ghq)
(el-get-bundle magit :branch "2.6.2")
(el-get-bundle elpa:hc-zenburn-theme)
(el-get-bundle smart-mode-line)

(el-get-bundle undohist)
(el-get-bundle undo-tree)
  (global-undo-tree-mode)
(el-get-bundle quickrun)
  (quickrun-add-command "c++/clang 1z"
    '((:command . "clang++")
      (:exec    . ("%c -std=c++1z %o -o %e %s"
                   "%e %a"))
      (:remove  . ("%e")))
    :default "c++")

;; v1.4.4
(el-get-bundle howm :type "git" :checkout "e0237b0"
               :url "git://git.osdn.net/gitroot/howm/howm.git")
(el-get-bundle org-mode)
(el-get-bundle markdown-mode)
(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(el-get-bundle markdown-toc)

(el-get-bundle company-mode)
(el-get-bundle flycheck)

;; golang
(el-get-bundle go-mode)
(el-get-bundle go-company)

;; c++
(el-get-bundle irony-mode)
(el-get-bundle flycheck-irony)
