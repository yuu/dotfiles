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
(el-get-bundle docker-tramp)
(el-get-bundle helm-ghq)
(el-get-bundle magit :branch "2.6.2")
(el-get-bundle git-gutter)
(el-get-bundle hc-zenburn-theme :type github :pkgname "edran/hc-zenburn-emacs")
(el-get-bundle smart-mode-line)

(el-get-bundle undohist)
(el-get-bundle undo-tree)
(el-get-bundle quickrun)
(el-get-bundle yasnippet :type github :checkout "0.12.2" :pkgname "joaotavora/yasnippet")
(el-get-bundle rg :type github :checkout "stable" :pkgname "dajva/rg.el")

;; markup lang
(el-get-bundle markdown-mode)
(el-get-bundle markdown-toc)
(el-get-bundle plantuml-mode :type github :pkgname "skuro/plantuml-mode")
(el-get-bundle browser-refresh :type github :pkgname "syohex/emacs-browser-refresh")
(el-get-bundle toml-mode)
(el-get-bundle dockerfile-mode)
(el-get-bundle yaml-mode)

(el-get-bundle company-mode)
(el-get-bundle flycheck)
(el-get-bundle editorconfig)

;; golang
(el-get-bundle go-company)
(el-get-bundle go-eldoc)

;; c++
(el-get-bundle company-irony)
(el-get-bundle flycheck-irony)
(el-get-bundle clang-format)
(el-get-bundle doxymacs :type github :checkout "v1.8.0" :pkgname "pniedzielski/doxymacs")
(el-get-bundle company-c-headers :type github :pkgname "randomphrase/company-c-headers")
(el-get-bundle cmake-mode :type git :checkout "v3.12.4" :url "https://gitlab.kitware.com/cmake/cmake.git")

;; python
(el-get-bundle company-jedi)
(el-get-bundle py-autopep8 :type github :pkgname "fujimisakari/py-autopep8.el")

;; web
(el-get-bundle web-mode)
(el-get-bundle company-web)

;; rust
(el-get-bundle rust-mode)
(el-get-bundle flymake-rust)
(el-get-bundle racer)
(el-get-bundle cargo)
