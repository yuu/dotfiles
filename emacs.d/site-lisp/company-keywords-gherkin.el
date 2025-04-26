;;; company-keywords-gherkin.el --- company-mode keywords support for feature-mode

;; Authors: yuu <yuuxzy@gmail.com>
;; Package-Requires: ((emacs "24") cl-lib company)
;; Package-Version: 0.1
;; Keywords: company gherkin
;; homepage: https://github.com/yuu/dotfiles

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:

;;; Usage:
;; # General Emacs Config

;; ``` emacs-lisp
;; (use-package company)

;; (use-package company-keywords-gherkin
;;   :if (featurep 'company)
;;   :after (feature-mode company)
;;   :config (add-hook 'feature-mode-hook (lambda () (add-to-list 'company-backends 'company-keywords-gherkin))))
; ```

;;; Code:

(require 'cl-lib)
(require 'company)

(defconst gherkin-keywords
  '(
     "Feature" "機能"
     "Background" "背景"
     "Rule" "ルール"
     "Scenario" "シナリオ"
     "ScenarioOutline" "シナリオアウトライン"
     "Examples" "例"
     "Given" "前提"          ; *
     "When" "もし"           ; *
     "Then" "ならば"         ; *
     "And" "かつ"            ; *
     "But" "しかし" "ただし" ; *
     "*"
     ))

;;;###autoload
(defun company-keywords-gherkin (command &optional arg &rest ignored)
  "gherkin directive backend for the company mode."

  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-keywords-gherkin))
    (prefix (and (eq major-mode 'feature-mode)
                 (company-grab-symbol)))
    (candidates
     (cl-remove-if-not
      (lambda (c) (string-prefix-p arg c)) gherkin-keywords))))

(provide 'company-keywords-gherkin)

;;; company-keywords-gherkin.el ends here
