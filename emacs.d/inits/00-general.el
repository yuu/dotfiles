;;; package --- Summary
;;; Commentary:
;;; Code:

(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
;(kill-buffer "*Messages*")
;(kill-buffer "*scratch*")
(setq-default message-log-max nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(savehist-mode 1) ; Save mini-buffer history
(setq history-length 3000) ; Up history num
(setq recentf-max-saved-itemds 3000)

(prefer-coding-system 'utf-8-unix)

(setq-default indent-tabs-mode nil)

;;; view
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq frame-title-format "%f") ; titilebar file full name

;; disable bell and flash
(setq ring-bell-function 'ignore)

;; 整数の場合は、元のウィンドウが最低でもその行数なければ分割しないことを意味する。
;; nilの場合は、この方法では分割しないことを意味する。
(defun adjust-window-split-thresholds nil
  "Adjust split thresholds so that popup windows always split vertically in a tall frame, horizontally in a wide frame, with a maximum of two columns."
  (interactive)
  (setq split-width-threshold  (+ (/ (frame-width) 2) 10)) ; 10 = offset. when exist 2 window, don't split
  (setq split-height-threshold nil)
)
(add-hook 'window-configuration-change-hook 'adjust-window-split-thresholds)

(if (display-graphic-p)
  (menu-bar-mode t))

;; 1行ずつスクロール
(setq scroll-conservatively 35
  scroll-margin 0
  scroll-step 1)
(setq comint-scroll-show-maximum-output t) ; shell-mode

(setq isearch-wrap-function '(lambda nil)) ; disable wrapping in isearch

;; デフォルトでは、ウィンドウを分割したとき、
;; Emacsは分割されたウィンドウのサイズをフレームのデフォルトフォントの整数倍にします。
;; これによりスクリーンが正確に2分割されない場合があります。
;; 変数window-resize-pixelwiseを非nil値にセットすると、
;; Emacsは分割されたウィンドウのサイズを、同じピクセル数にします
;; (元のサイズが奇数のピクセル数の場合、1ピクセル増減されます)。
;; フレームのピクセル数がフレームの文字サイズ倍でない場合、
;; このオプションがnilでも、
;; 少なくとも1つのウィンドウがピクセル幅のサイズ変更をされることに注意してください。
(setq window-resize-pixelwise t)
(setq frame-resize-pixelwise t)

;;;; keybind
(global-unset-key (kbd "C-x C-b"))
(global-unset-key (kbd "M-g g"))
(global-unset-key (kbd "C-h C-p")) ;view-emacs-problems
(global-unset-key (kbd "C-h n")) ;view-emacs-news
(global-unset-key (kbd "C-h C-n")) ;view-emacs-news
(global-unset-key (kbd "C-x ;"))

(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)

(keyboard-translate ?\C-h ?\C-?)
(keymap-global-set "C-h" nil)

; (global-set-key (kbd "M-k")(lambda () (interactive) (kill-line 0))) ; backward kill line
(global-set-key (kbd "C-c ;") 'comment-line)

(global-set-key (kbd "C-x j") 'pretty-hydra-usefull-commands/body)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;; 00-general.el ends here
