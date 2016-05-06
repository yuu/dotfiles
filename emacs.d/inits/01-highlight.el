;; ハイライト
(defface my-hl-line-face
  ;; 背景がdarkならば背景色を紺
  '((((class color) (background dark))
     (:background "2f4f4f" t))
    ;; 背景がlightならば背景色を緑
    (((class color) (background light))
     (:background "2f4f4f" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;; 括弧のハイライト
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; リージョンカラー
(set-face-background 'region "#696969"

;; 行末の空白を強調表示
;; (setq-default show-trailing-whitespace t)
;; (set-face-background 'trailing-whitespace "#b14770")
