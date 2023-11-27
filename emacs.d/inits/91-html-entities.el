;;; package --- Summary
;;; Commentary:
;;; Code:

(defvar user/html-entity-to-unicode-alist
  '(("Aacute" . "Á") ("aacute" . "á") ("Acirc" . "Â") ("acirc" . "â") ("acute" . "´") ("AElig" . "Æ") ("aelig" . "æ") ("Agrave" . "À") ("agrave" . "à") ("alefsym" . "ℵ") ("Alpha" . "Α") ("alpha" . "α") ("amp" . "&") ("and" . "∧") ("ang" . "∠") ("apos" . "'") ("aring" . "å") ("Aring" . "Å") ("asymp" . "≈") ("atilde" . "ã") ("Atilde" . "Ã") ("auml" . "ä") ("Auml" . "Ä") ("bdquo" . "„") ("Beta" . "Β") ("beta" . "β") ("brvbar" . "¦") ("bull" . "•") ("cap" . "∩") ("ccedil" . "ç") ("Ccedil" . "Ç") ("cedil" . "¸") ("cent" . "¢") ("Chi" . "Χ") ("chi" . "χ") ("circ" . "ˆ") ("clubs" . "♣") ("cong" . "≅") ("copy" . "©") ("crarr" . "↵") ("cup" . "∪") ("curren" . "¤") ("Dagger" . "‡") ("dagger" . "†") ("darr" . "↓") ("dArr" . "⇓") ("deg" . "°") ("Delta" . "Δ") ("delta" . "δ") ("diams" . "♦") ("divide" . "÷") ("eacute" . "é") ("Eacute" . "É") ("ecirc" . "ê") ("Ecirc" . "Ê") ("egrave" . "è") ("Egrave" . "È") ("empty" . "∅") ("emsp" . " ") ("ensp" . " ") ("Epsilon" . "Ε") ("epsilon" . "ε") ("equiv" . "≡") ("Eta" . "Η") ("eta" . "η") ("eth" . "ð") ("ETH" . "Ð") ("euml" . "ë") ("Euml" . "Ë") ("euro" . "€") ("exist" . "∃") ("fnof" . "ƒ") ("forall" . "∀") ("frac12" . "½") ("frac14" . "¼") ("frac34" . "¾") ("frasl" . "⁄") ("Gamma" . "Γ") ("gamma" . "γ") ("ge" . "≥") ("gt" . ">") ("harr" . "↔") ("hArr" . "⇔") ("hearts" . "♥") ("hellip" . "…") ("iacute" . "í") ("Iacute" . "Í") ("icirc" . "î") ("Icirc" . "Î") ("iexcl" . "¡") ("igrave" . "ì") ("Igrave" . "Ì") ("image" . "ℑ") ("infin" . "∞") ("int" . "∫") ("Iota" . "Ι") ("iota" . "ι") ("iquest" . "¿") ("isin" . "∈") ("iuml" . "ï") ("Iuml" . "Ï") ("Kappa" . "Κ") ("kappa" . "κ") ("Lambda" . "Λ") ("lambda" . "λ") ("lang" . "〈") ("laquo" . "«") ("larr" . "←") ("lArr" . "⇐") ("lceil" . "⌈") ("ldquo" . "“") ("le" . "≤") ("lfloor" . "⌊") ("lowast" . "∗") ("loz" . "◊") ("lrm" . "") ("lsaquo" . "‹") ("lsquo" . "‘") ("lt" . "<") ("macr" . "¯") ("mdash" . "—") ("micro" . "µ") ("middot" . "·") ("minus" . "−") ("Mu" . "Μ") ("mu" . "μ") ("nabla" . "∇") ("nbsp" . "") ("ndash" . "–") ("ne" . "≠") ("ni" . "∋") ("not" . "¬") ("notin" . "∉") ("nsub" . "⊄") ("ntilde" . "ñ") ("Ntilde" . "Ñ") ("Nu" . "Ν") ("nu" . "ν") ("oacute" . "ó") ("Oacute" . "Ó") ("ocirc" . "ô") ("Ocirc" . "Ô") ("OElig" . "Œ") ("oelig" . "œ") ("ograve" . "ò") ("Ograve" . "Ò") ("oline" . "‾") ("omega" . "ω") ("Omega" . "Ω") ("Omicron" . "Ο") ("omicron" . "ο") ("oplus" . "⊕") ("or" . "∨") ("ordf" . "ª") ("ordm" . "º") ("oslash" . "ø") ("Oslash" . "Ø") ("otilde" . "õ") ("Otilde" . "Õ") ("otimes" . "⊗") ("ouml" . "ö") ("Ouml" . "Ö") ("para" . "¶") ("part" . "∂") ("permil" . "‰") ("perp" . "⊥") ("Phi" . "Φ") ("phi" . "φ") ("Pi" . "Π") ("pi" . "π") ("piv" . "ϖ") ("plusmn" . "±") ("pound" . "£") ("Prime" . "″") ("prime" . "′") ("prod" . "∏") ("prop" . "∝") ("Psi" . "Ψ") ("psi" . "ψ") ("quot" . "\"") ("radic" . "√") ("rang" . "〉") ("raquo" . "»") ("rarr" . "→") ("rArr" . "⇒") ("rceil" . "⌉") ("rdquo" . "”") ("real" . "ℜ") ("reg" . "®") ("rfloor" . "⌋") ("Rho" . "Ρ") ("rho" . "ρ") ("rlm" . "") ("rsaquo" . "›") ("rsquo" . "’") ("sbquo" . "‚") ("scaron" . "š") ("Scaron" . "Š") ("sdot" . "⋅") ("sect" . "§") ("shy" . "") ("Sigma" . "Σ") ("sigma" . "σ") ("sigmaf" . "ς") ("sim" . "∼") ("spades" . "♠") ("sub" . "⊂") ("sube" . "⊆") ("sum" . "∑") ("sup" . "⊃") ("sup1" . "¹") ("sup2" . "²") ("sup3" . "³") ("supe" . "⊇") ("szlig" . "ß") ("Tau" . "Τ") ("tau" . "τ") ("there4" . "∴") ("Theta" . "Θ") ("theta" . "θ") ("thetasym" . "ϑ") ("thinsp" . " ") ("thorn" . "þ") ("THORN" . "Þ") ("tilde" . "˜") ("times" . "×") ("trade" . "™") ("uacute" . "ú") ("Uacute" . "Ú") ("uarr" . "↑") ("uArr" . "⇑") ("ucirc" . "û") ("Ucirc" . "Û") ("ugrave" . "ù") ("Ugrave" . "Ù") ("uml" . "¨") ("upsih" . "ϒ") ("Upsilon" . "Υ") ("upsilon" . "υ") ("uuml" . "ü") ("Uuml" . "Ü") ("weierp" . "℘") ("Xi" . "Ξ") ("xi" . "ξ") ("yacute" . "ý") ("Yacute" . "Ý") ("yen" . "¥") ("yuml" . "ÿ") ("Yuml" . "Ÿ") ("Zeta" . "Ζ") ("zeta" . "ζ") ("zwj" . "") ("zwnj" . ""))
  "Alist that maps HTML entity names to equivalent unicode characters.")

(defvar user/html-entity-to-unicode-hash nil
  "Hash table mapping HTML entities to unicode characters.")

(defvar user/html-unicode-to-entity-hash nil
  "Hash table mapping unicode characters to HTML entities.")

(let ((entity-list-length (length user/html-entity-to-unicode-alist)))
  (setq user/html-entity-to-unicode-hash (make-hash-table :test 'equal :size entity-list-length))
  (loop for (key . val) in user/html-entity-to-unicode-alist
        do (puthash key val user/html-entity-to-unicode-hash))

  (setq user/html-unicode-to-entity-hash (make-hash-table :test 'equal :size entity-list-length))
  (loop for (val . key) in user/html-entity-to-unicode-alist
        do (puthash key val user/html-unicode-to-entity-hash)))

(defun user/html-entity-to-unicode (entity)
  "To unicode ARG 'ENTITY."
  (gethash entity user/html-entity-to-unicode-hash))

(defun user/html-unicode-to-entity (unicode)
  "To entity ARG 'UNICODE."
  (gethash unicode user/html-unicode-to-entity-hash))

(defun user/html-string-entities-to-unicode (string)
  "To unicode ARG 'STRING."
  (replace-regexp-in-string "&[[:word:]]+;"
                            (lambda (s)
                              (or (user/html-entity-to-unicode (substring s 1 -1)) s))
                            string))

(defun user/html-string-unicode-to-entities (string)
  "To Entities ARG 'STRING."
  (replace-regexp-in-string "[^[:word:]]"
                            (lambda (s)
                              (or (user/html-unicode-to-entity s) s))
                            string))

(defun user/html-escape (&optional start end)
  "Escape characters to HTML entities in the current buffer between start and end, which default to the whole buffer ARG 'START 'END."
  (interactive "r")
  (unless start (setq start (point-min)))
  (unless end (setq end (point-max)))
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "\\([^[:word:]]\\)" nil t)
        (let* ((match (match-string 1))
               (entity (user/html-unicode-to-entity (match-string 1))))
          (when entity
              (setq entity (concat "&" entity ";")))
          (replace-match (or entity match) nil nil))))))

(defun user/html-unescape (&optional start end)
  "Unescape HTML entities to characters in the current buffer between start and end, which default to the whole buffer ARG 'START 'END."
  (interactive "r")
  (unless start (setq start (point-min)))
  (unless end (setq end (point-max)))
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "\\(&\\([[:word:]]+\\);\\)" nil t)
        (replace-match (or (user/html-entity-to-unicode (match-string 2))
                           (match-string 1))
                       nil nil)))))

;;; 91-html-entities.el ends here
