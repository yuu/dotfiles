(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle init-loader)
(el-get-bundle helm)
(el-get-bundle magit :branch "2.6.2")
(el-get-bundle elpa:hc-zenburn-theme)
(el-get-bundle smart-mode-line)

(el-get-bundle undohist)
(el-get-bundle undo-tree)
  (global-undo-tree-mode)

(el-get-bundle markdown-mode)
(el-get-bundle markdown-toc)

(el-get-bundle auto-complete)
(el-get-bundle auto-complete-clang)
