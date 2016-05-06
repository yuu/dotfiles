;; #! ファイルは，+x で保存
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; 0.03s後にカーソル行ハイライト 
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
;; (cancel-timer global-hl-line-timer)
