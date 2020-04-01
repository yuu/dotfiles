(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(100 . 100) '(80 . 80)))))

(defun enable-tabs-mode ()
  "Enable indent-tabs-mode"
  (interactive)
  (setq indent-tabs-mode t))
(provide 'enable-tabs-mode)

(defun disable-tabs-mode ()
  "Disable indent-tabs-mode"
  (interactive)
  (setq indent-tabs-mode nil))
(provide 'disable-tabs-mode)

(defun enable-view-mode ()
  "Enable view-mode that always open file"
  (interactive)
  (add-hook 'find-file-hooks 'view-mode)
)

(defun disable-view-mode ()
  "Disable view-mode that always open file"
  (interactive)
  (remove-hook 'find-file-hooks 'view-mode)
)

(defvar isearch-initial-string nil)
(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))
(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))
(define-key isearch-mode-map "\C-w" 'isearch-forward-at-point)

(defun helm-buffers-truncate-lines-toggle ()
  (interactive)
  (if (eq helm-buffers-truncate-lines t)
    (setq helm-buffers-truncate-lines nil)
    (setq helm-buffers-truncate-lines t)))
