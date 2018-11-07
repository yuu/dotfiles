(require 'helm-config)
  (helm-mode 1)

  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-M-z")   'helm-resume)
  (define-key global-map (kbd "C-x C-f")  'helm-find-files)
  (define-key global-map (kbd "C-x b")   'helm-mini)
  (define-key global-map (kbd "M-g l")   'helm-occur-from-isearch)

  (define-key global-map [remap find-file] 'helm-find-files)
  (define-key global-map [remap occur] 'helm-occur)
  (define-key global-map [remap list-buffers] 'helm-buffers-list)
  (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)

  (define-key helm-map (kbd "C-h") 'delete-backward-char)

(setq helm-mini-default-sources
      '(helm-source-buffers-list
        helm-source-bookmarks
        helm-source-recentf
        helm-source-file-cache))

(global-unset-key (kbd "C-x c c")) ; helm-colors
(global-unset-key (kbd "C-x c a")) ; helm-apropos
