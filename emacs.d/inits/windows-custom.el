;; using (w32-select-font)
;; "源ノ角ゴシック Code JP M-10:medium"
;; "Source Code Pro Medium-11:medium"
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 110
                    :weight 'normal
                    :width 'normal)
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "源ノ角ゴシック Code JP M"))

(use-package rg
  :config
  (add-to-list 'rg-toggle-command-line-flags "--path-separator \"/\"")
)
