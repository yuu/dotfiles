;;; package --- Summary
;;; Commentary:
;;; Code:

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq debug-on-error nil)
(setq straight-vc-git-debug nil)

(use-package straight
  :ensure nil
  :custom (straight-use-package-by-default t))

(use-package init-loader
  :ensure t
  :custom
  (init-loader-show-log-after-init nil)
  :config
  (init-loader-load (concat user-emacs-directory "inits")))

;;; init.el ends here
