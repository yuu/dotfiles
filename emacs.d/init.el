(package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(load (concat user-emacs-directory "init-el-get.el"))

(load-theme 'hc-zenburn t)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load (concat user-emacs-directory "inits"))

;; ~/.emacs.d/site-lisp 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
  (normal-top-level-add-subdirs-to-load-path)))

(setq-default message-log-max nil)
(kill-buffer "*Messages*")
(kill-buffer "*scratch*")
