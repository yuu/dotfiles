(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(kill-buffer "*Messages*")
;(kill-buffer "*scratch*")
(setq-default message-log-max nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(savehist-mode 1) ; Save mini-buffer history
(setq history-length 3000) ; Up history num
(setq recentf-max-saved-itemds 3000)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)

;;; view
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-scroll-bar-mode nil)
(set-fringe-mode 0)
(blink-cursor-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq frame-title-format "%f") ; titilebar file full name
(setq split-width-threshold 9999999)
(if (display-graphic-p)
  (menu-bar-mode t))

;; 1行ずつスクロール
(setq scroll-conservatively 35
  scroll-margin 0
  scroll-step 1)
(setq comint-scroll-show-maximum-output t) ; shell-mode

(setq isearch-wrap-function '(lambda nil)) ; disable wrapping in isearch
