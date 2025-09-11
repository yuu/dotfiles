;;; ef-hc-zenburn-theme.el --- hc-zenburn-theme -*- lexical-binding:

;; clone https://github.com/edran/hc-zenburn-emacs

;; (defvar hz-colors-alist
;;   '(
;;      ("hc-zenburn-fg+1"     . "#FFFFEF")
;;      ("hc-zenburn-fg"       . "#DCDCCC")
;;      ("hc-zenburn-fg-1"     . "#70705E")

;;      ("hc-zenburn-bg-2"     . "#000000")
;;      ("hc-zenburn-bg-1"     . "#202020")
;;      ("hc-zenburn-bg-05"    . "#2D2D2D")
;;      ("hc-zenburn-bg"       . "#313131")
;;      ("hc-zenburn-bg+05"    . "#383838")
;;      ("hc-zenburn-bg+1"     . "#3E3E3E")
;;      ("hc-zenburn-bg+2"     . "#4E4E4E")
;;      ("hc-zenburn-bg+3"     . "#5E5E5E")

;;      ("hc-zenburn-red+1"    . "#E9B0B0")
;;      ("hc-zenburn-red"      . "#D9A0A0")
;;      ("hc-zenburn-red-1"    . "#C99090")
;;      ("hc-zenburn-red-2"    . "#B98080")
;;      ("hc-zenburn-red-3"    . "#A97070")
;;      ("hc-zenburn-red-4"    . "#996060")

;;      ("hc-zenburn-yellow"   . "#FDECBC")
;;      ("hc-zenburn-yellow-1" . "#EDDCAC")
;;      ("hc-zenburn-yellow-2" . "#DDCC9C")

;;      ("hc-zenburn-green-1"  . "#6C8C6C")
;;      ("hc-zenburn-green"    . "#8CAC8C")
;;      ("hc-zenburn-green+1"  . "#9CBF9C")
;;      ("hc-zenburn-green+2"  . "#ACD2AC")
;;      ("hc-zenburn-green+3"  . "#BCE5BC")
;;      ("hc-zenburn-green+4"  . "#CCF8CC")

;;      ("hc-zenburn-blue+1"   . "#9CC7FB")
;;      ("hc-zenburn-blue"     . "#99DDE0")
;;      ("hc-zenburn-blue-1"   . "#89C5C8")
;;      ("hc-zenburn-blue-2"   . "#79ADB0")
;;      ("hc-zenburn-blue-3"   . "#699598")
;;      ("hc-zenburn-blue-4"   . "#597D80")
;;      ("hc-zenburn-blue-5"   . "#436D6D")

;;      ("hc-zenburn-orange"   . "#ECBC9C")
;;      ("hc-zenburn-cyan"     . "#A0EDF0")
;;      ("hc-zenburn-magenta"  . "#E090C7")
;;      )
;;   "List of Hc-Zenburn colors.
;; Each element has the form (NAME . HEX).

;; `+N' suffixes indicate a color is lighter.
;; `-N' suffixes indicate a color is darker.")

;;; Code:


(eval-and-compile
  (require 'ef-themes

  ;;;###theme-autoload
    (deftheme ef-hc-zenburn
      "hc-zenburn"
      :background-mode 'dark
      :kind 'color-scheme
      :family 'ef)

    (defconst ef-hc-zenburn-palette
      '(
;;; Basic values

         (bg-main     "#313131")  ; hc-zenburn-bg
         (fg-main     "#DCDCCC")  ; hc-zenburn-fg
         (bg-dim      "#383838")  ; hc-zenburn-bg+05
         (fg-dim      "#70705E")  ; hc-zenburn-fg-1
         (bg-alt      "#3E3E3E")  ; hc-zenburn-bg+1
         (fg-alt      "#FFFFEF")  ; hc-zenburn-fg+1
         (bg-active   "#4E4E4E")  ; hc-zenburn-bg+2
         (bg-inactive "#000000")  ; hc-zenburn-bg-2

;;; Basic hues for foreground values

         (red             "#D9A0A0")  ; hc-zenburn-red
         (red-warmer      "#E9B0B0")  ; hc-zenburn-red+1
         (red-cooler      "#C99090")  ; hc-zenburn-red-1
         (red-faint       "#A97070")  ; hc-zenburn-red-3
         (green           "#8CAC8C")  ; hc-zenburn-green
         (green-warmer    "#ACD2AC")  ; hc-zenburn-green+2
         (green-cooler    "#6C8C6C")  ; hc-zenburn-green-1
         (green-faint     "#9CBF9C")  ; hc-zenburn-green+1
         (yellow          "#FDECBC")  ; hc-zenburn-yellow
         (yellow-warmer   "#ECBC9C")  ; hc-zenburn-orange
         (yellow-cooler   "#EDDCAC")  ; hc-zenburn-yellow-1
         (yellow-faint    "#DDCC9C")  ; hc-zenburn-yellow-2
         (blue            "#99DDE0")  ; hc-zenburn-blue
         (blue-warmer     "#9CC7FB")  ; hc-zenburn-blue+1
         (blue-cooler     "#89C5C8")  ; hc-zenburn-blue-1
         (blue-faint      "#597D80")  ; hc-zenburn-blue-4
         (magenta         "#E090C7")  ; hc-zenburn-magenta
         (magenta-warmer  "#E090C7")  ; hc-zenburn-magenta (same)
         (magenta-cooler  "#E090C7")  ; hc-zenburn-magenta (same)
         (magenta-faint   "#E090C7")  ; hc-zenburn-magenta (same)
         (cyan            "#A0EDF0")  ; hc-zenburn-cyan
         (cyan-warmer     "#A0EDF0")  ; hc-zenburn-cyan (same)
         (cyan-cooler     "#A0EDF0")  ; hc-zenburn-cyan (same)
         (cyan-faint      "#79ADB0")  ; hc-zenburn-blue-2

;;; Basic hues for background values

         (bg-red-intense     "#996060")  ; hc-zenburn-red-4
         (bg-green-intense   "#6C8C6C")  ; hc-zenburn-green-1
         (bg-yellow-intense  "#DDCC9C")  ; hc-zenburn-yellow-2
         (bg-blue-intense    "#436D6D")  ; hc-zenburn-blue-5
         (bg-magenta-intense "#E090C7")  ; hc-zenburn-magenta
         (bg-cyan-intense    "#699598")  ; hc-zenburn-blue-3

         (bg-red-subtle      "#B98080")  ; hc-zenburn-red-2
         (bg-green-subtle    "#6C8C6C")  ; hc-zenburn-green-1
         (bg-yellow-subtle   "#DDCC9C")  ; hc-zenburn-yellow-2
         (bg-blue-subtle     "#597D80")  ; hc-zenburn-blue-4
         (bg-magenta-subtle  "#E090C7")  ; hc-zenburn-magenta
         (bg-cyan-subtle     "#79ADB0")  ; hc-zenburn-blue-2

;;; Diffs

         (bg-added          "#6C8C6C")  ; hc-zenburn-green-1
         (bg-added-faint    "#6C8C6C")  ; hc-zenburn-green-1
         (bg-added-refine   "#8CAC8C")  ; hc-zenburn-green
         (fg-added          "#FFFFEF")  ; hc-zenburn-fg+1

         (bg-changed        "#DDCC9C")  ; hc-zenburn-yellow-2
         (bg-changed-faint  "#DDCC9C")  ; hc-zenburn-yellow-2
         (bg-changed-refine "#FDECBC")  ; hc-zenburn-yellow
         (fg-changed        "#313131")  ; hc-zenburn-bg (dark text for yellow bg)

         (bg-removed        "#996060")  ; hc-zenburn-red-4
         (bg-removed-faint  "#996060")  ; hc-zenburn-red-4
         (bg-removed-refine "#A97070")  ; hc-zenburn-red-3
         (fg-removed        "#FFFFEF")  ; hc-zenburn-fg+1

;;; Graphs

         (bg-graph-red-0     "#b52c2c")
         (bg-graph-red-1     "#702020")
         (bg-graph-green-0   "#0fed00")
         (bg-graph-green-1   "#007800")
         (bg-graph-yellow-0  "#f1e00a")
         (bg-graph-yellow-1  "#b08940")
         (bg-graph-blue-0    "#2fafef")
         (bg-graph-blue-1    "#1f2f8f")
         (bg-graph-magenta-0 "#bf94fe")
         (bg-graph-magenta-1 "#5f509f")
         (bg-graph-cyan-0    "#47dfea")
         (bg-graph-cyan-1    "#00808f")

;;; Special hues

         (bg-mode-line       "#2D2D2D")  ; hc-zenburn-bg-05
         (fg-mode-line       "#DCDCCC")  ; hc-zenburn-fg
         (bg-completion      "#383838")  ; hc-zenburn-bg+05
         (bg-hover           "#4E4E4E")  ; hc-zenburn-bg+2
         (bg-hover-secondary "#3E3E3E")  ; hc-zenburn-bg+1
         (bg-hl-line         "#383838")  ; hc-zenburn-bg+05
         (bg-paren           "#5E5E5E")  ; hc-zenburn-bg+3
         (bg-err             "#996060")  ; hc-zenburn-red-4
         (bg-warning         "#313131")  ; hc-zenburn-yellow-2 -> hc-zenburn-orange -> hc-zenburn-bg
         (bg-info            "#6C8C6C")  ; hc-zenburn-green-1

         (border        "#5E5E5E")  ; hc-zenburn-bg+3
         (cursor        "#FFFFEF")  ; hc-zenburn-fg+1
         (fg-intense    "#FFFFEF")  ; hc-zenburn-fg+1

         (modeline-err     "#D9A0A0")  ; hc-zenburn-red
         (modeline-warning "#FDECBC")  ; hc-zenburn-yellow
         (modeline-info    "#8CAC8C")  ; hc-zenburn-green

         (underline-err     "#D9A0A0")  ; hc-zenburn-red
         (underline-warning "#FDECBC")  ; hc-zenburn-yellow
         (underline-info    "#8CAC8C")  ; hc-zenburn-green

         (bg-char-0 "#0050af")
         (bg-char-1 "#7f1f7f")
         (bg-char-2 "#625a00")

;;; Mappings

;;;; General mappings

         (bg-fringe unspecified)
         (fg-fringe unspecified)

         (err red)
         (warning yellow-warmer)
         (info green-cooler)

         (link blue-faint) ; cyan-warmer
         (link-alt magenta)
         (name "#DCDCCC")     ; hc-zenburn-orange for magit-log-author
         (keybind green-cooler)
         (identifier "#70705E")    ; hc-zenburn-bg+3 for magit-hash (dimmed) -> hc-zenburn-fg-1
         (prompt cyan-warmer)

         (bg-region "#696969")    ; hc-zenburn-bg+05 -> custom
         (fg-region unspecified)

;;;; Code mappings

         (builtin cyan)           ; hc-zenburn-cyan
         (comment green-cooler)   ; hc-zenburn-green-1
         (constant yellow-warmer) ; hc-zenburn-orange
         (fnname blue)            ; hc-zenburn-blue
         (keyword yellow)         ; hc-zenburn-yellow
         (preprocessor blue-warmer) ; hc-zenburn-blue+1
         (docstring green-faint)  ; hc-zenburn-green+1
         (string red)             ; hc-zenburn-red
         (type cyan-faint)        ; hc-zenburn-blue-2
         (variable yellow-warmer) ; hc-zenburn-orange
         (rx-escape yellow)       ; hc-zenburn-yellow
         (rx-construct magenta)   ; hc-zenburn-magenta

;;;; Accent mappings

         (accent-0 blue)           ; hc-zenburn-blue for magit-branch-local
         (accent-1 green)          ; hc-zenburn-green for magit-branch-remote
         (accent-2 cyan)           ; hc-zenburn-cyan
         (accent-3 yellow-warmer)  ; hc-zenburn-orange for magit-tag

;;;; Date mappings

         (date-common fg-dim)     ; hc-zenburn-fg-1 for magit-log-date
         (date-deadline red)
         (date-deadline-subtle red-faint)
         (date-event fg-alt)
         (date-holiday magenta-warmer)
         (date-now fg-main)
         (date-range fg-alt)
         (date-scheduled yellow)
         (date-scheduled-subtle yellow-faint)
         (date-weekday cyan)
         (date-weekend red-faint)

;;;; Prose mappings

         (prose-code magenta-warmer)
         (prose-done green-cooler)
         (prose-macro cyan-cooler)
         (prose-metadata fg-dim)
         (prose-metadata-value fg-alt)
         (prose-table fg-alt)
         (prose-table-formula info)
         (prose-tag fg-alt)
         (prose-todo red)
         (prose-verbatim blue-cooler)

;;;; Mail mappings

         (mail-cite-0 blue)
         (mail-cite-1 magenta-warmer)
         (mail-cite-2 green-cooler)
         (mail-cite-3 yellow-cooler)
         (mail-part cyan)
         (mail-recipient blue-warmer)
         (mail-subject cyan-cooler)
         (mail-other cyan-warmer)

;;;; Search mappings

         (bg-search-match bg-warning)
         (bg-search-current bg-yellow-intense)
         (bg-search-lazy bg-blue-intense)
         (bg-search-replace bg-red-intense)

         (bg-search-rx-group-0 bg-magenta-intense)
         (bg-search-rx-group-1 bg-green-intense)
         (bg-search-rx-group-2 bg-red-subtle)
         (bg-search-rx-group-3 bg-cyan-subtle)

;;;; Space mappings

         (bg-space unspecified)
         (fg-space border)
         (bg-space-err bg-yellow-intense)

;;;; Tab mappings

         (bg-tab-bar      bg-alt)
         (bg-tab-current  bg-main)
         (bg-tab-other    bg-active)

;;;; Terminal mappings

         (bg-term-black           "black")
         (fg-term-black           "black")
         (bg-term-black-bright    "gray35")
         (fg-term-black-bright    "gray35")

         (bg-term-red             red)
         (fg-term-red             red)
         (bg-term-red-bright      red-warmer)
         (fg-term-red-bright      red-warmer)

         (bg-term-green           green)
         (fg-term-green           green)
         (bg-term-green-bright    green-warmer)
         (fg-term-green-bright    green-warmer)

         (bg-term-yellow          yellow)
         (fg-term-yellow          yellow)
         (bg-term-yellow-bright   yellow-warmer)
         (fg-term-yellow-bright   yellow-warmer)

         (bg-term-blue            blue)
         (fg-term-blue            blue)
         (bg-term-blue-bright     blue-warmer)
         (fg-term-blue-bright     blue-warmer)

         (bg-term-magenta         magenta)
         (fg-term-magenta         magenta)
         (bg-term-magenta-bright  magenta-cooler)
         (fg-term-magenta-bright  magenta-cooler)

         (bg-term-cyan            cyan)
         (fg-term-cyan            cyan)
         (bg-term-cyan-bright     cyan-cooler)
         (fg-term-cyan-bright     cyan-cooler)

         (bg-term-white           "gray65")
         (fg-term-white           "gray65")
         (bg-term-white-bright    "white")
         (fg-term-white-bright    "white")

;;;; Rainbow mappings

         (rainbow-0 cyan-warmer)
         (rainbow-1 magenta-cooler)
         (rainbow-2 yellow-cooler)
         (rainbow-3 blue-warmer)
         (rainbow-4 magenta)
         (rainbow-5 green)
         (rainbow-6 yellow)
         (rainbow-7 cyan)
         (rainbow-8 green-warmer))
      "The `ef-hc-zenburn' palette."))

  (defun ef-hc-zenburn-face-overrides ()
    (let ((c '((class color) (min-colors 256))))
      (custom-theme-set-faces
        'ef-hc-zenburn
        `(git-commit-summary        ((,c :foreground "#DCDCCC"))) ; fg-main
;;;;; magit
        `(magit-section-heading     ((,c :foreground "#FDECBC" :weight bold))) ; yellow
        `(magit-diff-file-heading   ((,c :foreground "#DCDCCC"))) ; fg-main
;;;;; grep
        `(grep-context-face ((,c :foreground "#DCDCCC"))) ; fg-main
        `(grep-error-face ((,c :foreground "#D9A0A0" :weight bold :underline t)))
        `(grep-hit-face ((,c :foreground "#99DDE0")))
        `(grep-match-face ((,c :foreground "#ECBC9C" :weight bold)))
        `(match ((,c :background "#3E3E3E" :foreground "#ECBC9C" :weight bold)))
        )))

;; (defface rg-match-face `((t :inherit ,grep-match-face))
;; (defface rg-error-face `((t :inherit ,grep-error-face))
;; (defface rg-context-face `((t :inherit ,grep-context-face))
;; (defface rg-info-face '((t :inherit compilation-info))
;; (defface rg-warning-face '((t :inherit compilation-warning))
;; (defface rg-filename-face '((t :inherit rg-info-face))
;; (defface rg-file-tag-face '((t :inherit rg-info-face))
;; (defface rg-line-number-face '((t :inherit compilation-line-number))
;; (defface rg-column-number-face '((t :inherit compilation-column-number))
;; (defface rg-match-position-face '((t :inherit default))

  (ef-themes-theme ef-hc-zenburn ef-hc-zenburn-palette)

  (add-hook 'ef-themes-post-load-hook
    (lambda ()
      (when (eq (car custom-enabled-themes) 'ef-hc-zenburn)
        (ef-hc-zenburn-face-overrides))))

  (provide-theme 'ef-hc-zenburn))

;;; ef-hc-zenburn-theme.el ends here
