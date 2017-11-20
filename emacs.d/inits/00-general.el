;; スタートアップ非表示
(setq inhibit-startup-screen t)
;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; ツールバー非表示
(tool-bar-mode -1)
;; メニューバーを非表示
(menu-bar-mode -1)
;; スクロールバー非表示
(set-scroll-bar-mode nil)
;; titilebar file full name
(setq frame-title-format "%f")

;;使用する言語環境
(set-language-environment "Japanese")
;;開く場合に優先する文字コード
(prefer-coding-system 'utf-8-unix)
;;デフォルトで使用する文字コード
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
;;キーボードから入力される文字コード
(set-keyboard-coding-system 'utf-8)
;;ターミナルの文字コード
(set-terminal-coding-system 'utf-8)
;;ファイル名の文字コード
(setq file-name-coding-system 'utf-8)
;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;; tab
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

;; backup file
(setq make-backup-files nil)
(setq auto-save-default nil)
;;(setq backup-directroy-alist '((".*" . ,(expand-file-name "/tmp")))
;;(setq auto-save-file-name-transforms '((".*" ,(expand-file-name "/tmp") t)))
(setq auto-save-timeout 900) ;; 15min
(setq auto-save-interval 300)

;; ミニバッファの履歴を保存する
(savehist-mode 1)
;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode

;; モードラインの割合表示を総行数表示
;; (defvar my-lines-page-mode t)
;; (defvar my-mode-line-format)

;; (when my-lines-page-mode
;;   (setq my-mode-line-format "%d")
;;   (if size-indication-mode
;;       (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
;;   (cond ((and (eq line-number-mode t) (eq column-number-mode t))
;;          (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
;;         ((eq line-number-mode t)
;;          (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
;;         ((eq column-number-mode t)
;;          (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

;;   (setq mode-line-position
;;         '(:eval (format my-mode-line-format
;;                         (count-lines (point-max) (point-min))))))
