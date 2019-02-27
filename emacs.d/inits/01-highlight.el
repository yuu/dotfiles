;; 括弧のハイライト
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)

;; リージョンカラー
(set-face-background 'region "#696969")

(with-eval-after-load 'whitespace
  (setq whitespace-style '(face           ; faceで可視化
                           trailing       ; 行末
                           empty          ; 先頭/末尾の空行
                           tabs           ; タブ
                           tab-mark
                           spaces
                           space-mark     ; 表示のマッピング
                           ))

  (setq whitespace-display-mappings
        '((space-mark ?\u3000 [?\u25a1])
          (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (set-face-foreground 'whitespace-space "#7cfc00")
  (set-face-background 'whitespace-space 'nil)
  (set-face-bold 'whitespace-space t)
  (set-face-foreground 'whitespace-tab "#669125")
  (set-face-background 'whitespace-tab 'nil)
  (set-face-underline  'whitespace-tab t))
;; (global-whitespace-mode)

(with-eval-after-load 'magit
    (set-face-foreground 'magit-branch-local "brightgreen")
    (set-face-bold 'magit-branch-local t)
    (set-face-foreground 'magit-branch-remote "brightred")
    (set-face-bold 'magit-branch-remote t)
)

(with-eval-after-load 'company
    (set-face-background 'company-preview "green")
)
