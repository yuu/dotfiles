(eval-after-load "irony"
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++14")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-hook 'c-mode-common-hook 'irony-mode)))

(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))

(add-hook 'c-mode-common-hook
          (function (lambda ()
                    (add-hook 'after-save-hook
                              'clang-format-buffer))))

(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
