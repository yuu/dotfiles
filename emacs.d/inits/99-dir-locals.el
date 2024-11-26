;;; package --- Summary
;;; Commentary:
;;; Code:

;; allow .dir-locals.el configuration always
;; example message "foobar"
(use-package emacs
  :custom
  (safe-local-eval-forms '(
                            (message "foobar")
                            )
    ))

;;; 99-dir-loals.el ends here
