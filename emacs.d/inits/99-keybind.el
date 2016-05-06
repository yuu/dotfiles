;; C-h BackSpace
(keyboard-translate ?\C-h ?\C-?)
;; C-? help
(define-key global-map (kbd "C-x ?") 'help-command)

;; C-w 単語削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

;; C-aでインデントを飛ばした行頭に移動
(defun beginning-of-indented-line (current-point)
"インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文字しかない場合は、行頭に戻る。"
  (interactive "d")
  (if (string-match
       "^[ ¥t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
        (back-to-indentation)))
