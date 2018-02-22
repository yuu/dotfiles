;; 括弧のハイライト
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; リージョンカラー
(set-face-background 'region "#696969")

(require 'whitespace)
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
(set-face-bold-p 'whitespace-space t)
(set-face-foreground 'whitespace-tab "#669125")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)

(global-whitespace-mode 1)
