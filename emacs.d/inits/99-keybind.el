;; C-h BackSpace
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; C-w 単語削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)
