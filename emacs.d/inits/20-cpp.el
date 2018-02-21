(eval-after-load 'company
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++14")))
     (add-hook 'c-mode-hook 'irony-mode)
     (add-hook 'c++-mode-hook 'irony-mode)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-to-list 'company-backends 'company-irony)))

(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))

(add-hook 'c-mode-common-hook
          (lambda ()
                    (add-hook 'after-save-hook
                              'clang-format-buffer nil 'local)))

(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
