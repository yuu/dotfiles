(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle init-loader)
(el-get-bundle helm)
(el-get-bundle helm-rg :type github :pkgname "microamp/helm-rg")
(el-get-bundle helm-tramp)
(el-get-bundle docker-tramp)
(el-get-bundle helm-ghq)
(el-get-bundle magit :branch "2.6.2")
(el-get-bundle git-gutter)
  (global-git-gutter-mode)
(el-get-bundle hc-zenburn-theme :type github :pkgname "edran/hc-zenburn-emacs")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/hc-zenburn-theme/")
(el-get-bundle smart-mode-line)

(el-get-bundle undohist)
(el-get-bundle undo-tree)
(el-get-bundle quickrun)
  (quickrun-add-command "c++/clang 1z"
    '((:command . "clang++")
      (:exec    . ("%c -std=c++1z %o -o %e %s"
                   "%e %a"))
      (:remove  . ("%e")))
    :default "c++")
(el-get-bundle yasnippet :type github :checkout "0.12.2"
               :pkgname "joaotavora/yasnippet")
  (yas-global-mode)

(el-get-bundle elpa:howm)
(el-get-bundle markdown-mode)
(el-get-bundle markdown-toc)
(el-get-bundle plantuml-mode :type github :pkgname "skuro/plantuml-mode")

(el-get-bundle company-mode)
(el-get-bundle flycheck)

;; golang
(el-get-bundle go-mode)
(el-get-bundle go-company)

;; c++
(el-get-bundle company-irony)
(el-get-bundle irony-mode)
(el-get-bundle flycheck-irony)
(el-get-bundle doxymacs :type github :checkout "v1.8.0"
               :pkgname "pniedzielski/doxymacs")
  (add-to-list 'load-path "~/.emacs.d/el-get/doxymacs/lisp/")
