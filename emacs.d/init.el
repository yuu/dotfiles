;;(package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(load (concat user-emacs-directory "init-el-get.el"))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load (concat user-emacs-directory "inits"))
(custom-set-variables
 '(irony-additional-clang-options (quote ("-std=c++14")))
 '(magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256"))))
(custom-set-faces
 '(company-preview ((t (:background "green")))))
