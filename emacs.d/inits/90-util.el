;;; package --- Summary
;;; Commentary:
;;; Code:

(defun enable-tabs-mode ()
  "Enable indent-tabs-mode."
  (interactive)
  (setq indent-tabs-mode t))
(provide 'enable-tabs-mode)

(defun disable-tabs-mode ()
  "Disable indent-tabs-mode."
  (interactive)
  (setq indent-tabs-mode nil))
(provide 'disable-tabs-mode)

(defun enable-view-mode ()
  "Enable view-mode that always open file."
  (interactive)
  (add-hook 'find-file-hook 'view-mode)
)

(defun disable-view-mode ()
  "Disable view-mode that always open file."
  (interactive)
  (remove-hook 'find-file-hook 'view-mode)
)

(defvar isearch-initial-string nil)
(defun isearch-set-initial-string ()
  "."
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))
(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point ARG 'REGEXP-P 'NO-RECURSIVE-EDIT."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))
(define-key isearch-mode-map "\C-w" 'isearch-forward-at-point)

(defun new-buffer-frame ()
  "Create a new frame with a new empty buffer."
  (interactive)
  (let ((buffer (generate-new-buffer "untitled")))
    (set-buffer-major-mode buffer)
    (display-buffer-same-window buffer nil)))
(global-set-key (kbd "C-x c n") 'new-buffer-frame)

(defvar ar-html2uml
  '(
    ("&nbsp;" " ")
    ("&iexcl;" "¡")
    ("&cent;" "¢")
    ("&pound;" "£")
    ("&curren;" "\x{00A4}")
    ("&yen;" "¥")
    ("&brvbar;" "\x{00A6}")
    ("&sect;" "§")
    ("&uml;" "\x{00A8}")
    ("&copy;" "©")
    ("&ordf;" "ª")
    ("&laquo;" "«")
    ("&not;" "¬")
    ("&shy;" "­")
    ("&reg;" "®")
    ("&macr;" "¯")
    ("&deg;" "°")
    ("&plusmn;" "±")
    ("&sup2;" "²")
    ("&sup3;" "³")
    ("&acute;" "\x{00B4}")
    ("&micro;" "µ")
    ("&para;" "¶")
    ("&middot;" "·")
    ("&cedil;" "\x{00B8}")
    ("&sup1;" "¹")
    ("&ordm;" "º")
    ("&raquo;" "»")
    ("&frac14;" "\x{00BC}")
    ("&frac12;" "\x{00BD}")
    ("&frac34;" "\x{00BE}")
    ("&iquest;" "¿")
    ("&Agrave;" "À")
    ("&Aacute;" "Á")
    ("&Acirc;" "Â")
    ("&Atilde;" "Ã")
    ("&Auml;" "Ä")
    ("&Aring;" "Å")
    ("&AElig;" "Æ")
    ("&Ccedil;" "Ç")
    ("&Egrave;" "È")
    ("&Eacute;" "É")
    ("&Ecirc;" "Ê")
    ("&Euml;" "Ë")
    ("&Igrave;" "Ì")
    ("&Iacute;" "Í")
    ("&Icirc;" "Î")
    ("&Iuml;" "Ï")
    ("&ETH;" "Ð")
    ("&Ntilde;" "Ñ")
    ("&Ograve;" "Ò")
    ("&Oacute;" "Ó")
    ("&Ocirc;" "Ô")
    ("&Otilde;" "Õ")
    ("&Ouml;" "Ö")
    ("&times;" "×")
    ("&Oslash;" "Ø")
    ("&Ugrave;" "Ù")
    ("&Uacute;" "Ú")
    ("&Ucirc;" "Û")
    ("&Uuml;" "Ü")
    ("&Yacute;" "Ý")
    ("&THORN;" "Þ")
    ("&szlig;" "ß")
    ("&agrave;" "à")
    ("&aacute;" "á")
    ("&acirc;" "â")
    ("&atilde;" "ã")
    ("&auml;" "ä")
    ("&aring;" "å")
    ("&aelig;" "æ")
    ("&ccedil;" "ç")
    ("&egrave;" "è")
    ("&eacute;" "é")
    ("&ecirc;" "ê")
    ("&euml;" "ë")
    ("&igrave;" "ì")
    ("&iacute;" "í")
    ("&icirc;" "î")
    ("&iuml;" "ï")
    ("&eth;" "ð")
    ("&ntilde;" "ñ")
    ("&ograve;" "ò")
    ("&oacute;" "ó")
    ("&ocirc;" "ô")
    ("&otilde;" "õ")
    ("&ouml;" "ö")
    ("\&Ouml;" "Ö")
    ("&divide;" "÷")
    ("&oslash;" "ø")
    ("&ugrave;" "ù")
    ("&uacute;" "ú")
    ("&ucirc;" "û")
    ("&uuml;" "ü")
    ("&yacute;" "ý")
    ("&thorn;" "þ")
    ("&yuml;" "ÿ")
    ))

(defun ar-uml2html ()
  "Translate chars into html entities."
  (interactive "*")
  (let ((liste ar-html2uml)
        case-fold-search erg)
    (dolist (ele liste)
      (goto-char (point-min))
      (while (search-forward (cadr ele) nil t 1)
        (setq erg (car ele))
        ;; Replacing with code starting from & upcases
        ;; Emacs bug?
        (replace-match "")
        (insert erg)))))

(defun ar-html2uml ()
  "Translate html entities into text."
  (interactive "*")
  (let ((liste ar-html2uml))
    (dolist (ele liste)
      (goto-char (point-min))
      (while (search-forward (car ele) nil t 1)
        (replace-match "")
        (insert (cadr ele))))))

(defun zdx/use-prettier-if-in-node-modules ()
  "Enable prettier-js-mode iff prettier was found installed locally in project."
  (interactive)
  (let* ((file-name (or (buffer-file-name) default-directory))
         (root (locate-dominating-file file-name "node_modules"))
         (prettier (and root
                        (expand-file-name "node_modules/prettier/bin-prettier.js" root))))
    (if (and prettier (file-executable-p prettier))
        (progn
          (message "Found local prettier executable at %s. Enabling prettier-js-mode" prettier)
          (setq prettier-js-command prettier)
          (make-variable-buffer-local 'prettier-js-command)
          (prettier-js-mode)
          (message "Disabling aggressive-indent-mode in favour of prettier")
          (aggressive-indent-mode -1))
      (progn
        (message "Prettier not found in %s. Not enabling prettier-js-mode" root)
        (message "Falling back to aggressive-indent-mode")
        (aggressive-indent-mode 1)))))

(defun kill-region-or-backward-kill-word ()
  "Remove word."
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

(defun yas-capitalize-first (string)
  "Capitalize the first letter of STRING."
  (concat (capitalize (substring string 0 1)) (substring string 1)))

(defun yas-camel-to-capital (string)
  "Convert camelCase STRING to CapitalCase."
  (mapconcat 'identity (mapcar 'capitalize (split-string-and-unquote string "[A-Z][^A-Z]*")) ""))

(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
         (current-width (window-width))
         (current-height (window-height))
         (dx (if (= (nth 0 (window-edges)) 0) 1
               -1))
         (dy (if (= (nth 1 (window-edges)) 0) 1
               -1))
         action c)
    (catch 'end-flag
      (while t
        (setq action
          (read-key-sequence-vector (format "size[%dx%d]"
                                      (window-width)
                                      (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
                (enlarge-window-horizontally dx))
          ((= c ?h)
            (shrink-window-horizontally dx))
          ((= c ?j)
            (enlarge-window dy))
          ((= c ?k)
            (shrink-window dy))
          ;; otherwise
          (t
            (let ((last-command-char (aref action 0))
                   (command (key-binding action)))
              (when command
                (call-interactively command)))
            (message "Quit")
            (throw 'end-flag t)))))))
(global-set-key (kbd "C-x w r") 'window-resizer)

(defun find-files ()
  "Use `find` to locate files and open them interactively."
  (interactive)
  (let* ((default-directory (read-directory-name "Start directory: "))
         (find-command (read-string "Find command: " "fd -t f -I "))
         (candidates (split-string (shell-command-to-string find-command) "\n" t)))
    (ivy-read "Find file: " candidates
              :action (lambda (file)
                        (find-file (expand-file-name file default-directory))))))

;;; 90-util.el ends here
