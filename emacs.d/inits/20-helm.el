(require 'helm-config)
  (helm-mode 1)

  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-M-z")   'helm-resume)
  (define-key global-map (kbd "C-x f")   'helm-find-files)
  (define-key global-map (kbd "C-x b")   'helm-buffers-list)
  (define-key global-map (kbd "M-g g")   'helm-do-grep)
  (define-key global-map (kbd "M-g l")   'helm-occur-from-isearch)
 
;;  (define-key global-map [remap find-file] 'helm-find-files)
  ; (define-key global-map [remap occur] 'helm-occur)
;;  (define-key global-map [remap list-buffers] 'helm-buffers-list)
  ; (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)

  ; (unless (boundp 'completion-in-region-function)
  ;   (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  ;   (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
  ; (add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "$CONF_FILE") (delete-file "$CONF_FILE"))))

  
  ; (define-key helm-map (kbd "C-h") 'delete-backward-char)
  ; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  ; (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

  ;; Disable helm in some functions
  ; (add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

  ;; Emulate `kill-line' in helm minibuffer
  ; (setq helm-delete-minibuffer-contents-from-point t)
  ; (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  ;   "Emulate `kill-line' in helm minibuffer"
  ;   (kill-new (buffer-substring (point) (field-end))))
  ;
  ; (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  ;   "Execute command only if CANDIDATE exists"
  ;   (when (file-exists-p candidate)
  ;     ad-do-it))
  ;
  ; (defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
  ;   "Transform the pattern to reflect my intention"
  ;   (let* ((pattern (ad-get-arg 0))
  ;          (input-pattern (file-name-nondirectory pattern))
  ;          (dirname (file-name-directory pattern)))
  ;     (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
  ;     (setq ad-return-value
  ;           (concat dirname
  ;                   (if (string-match "^\\^" input-pattern)
  ;                       ;; '^' is a pattern for basename
  ;                       ;; and not required because the directory name is prepended
  ;                       (substring input-pattern 1)
  ;                                           (concat ".*" input-pattern)))))))
  ;

; (setq helm-buffer-max-length 50)
