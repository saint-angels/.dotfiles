;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "kou"
      user-mail-address "mikeprokofyev@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka SS15 Extended" :size 20 )
       doom-variable-pitch-font (font-spec :family "sans" :size 21))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(add-hook 'markdown-mode-hook (lambda () (writeroom-mode +1)))
(remove-hook 'markdown-mode-hook (lambda () (variable-pitch-mode)))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\Library\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\Temp\\'")
  ;; or
  ;; (add-to-list 'lsp-file-watch-ignored-files "[/\\\\]\\.my-files\\'")
  (setq lsp-ui-sideline-show-code-actions nil)
(setq lsp-ui-doc-enable nil)
(setq lsp-lens-enable t)
  )

; Iterate through CamelCase words
(global-subword-mode 1)


(defadvice! my-evil-delete-default-to-black-hole-a (fn beg end &optional type register yank-handler)
  "Advise `evil-delete' to set default REGISTER to the black hole register."
  :around #'evil-delete
  (unless register (setq register ?_))
  (funcall fn beg end type register yank-handler))

;; org
(setq org-directory "~/Dropbox/writing/")
(defun kou/org-reformat-buffer ()
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))

;; (package! org-download)
(defun kou/org-download-paste-clipboard (&optional use-default-filename)
  (interactive "P")
  (require 'org-download)
  (let ((file
         (if (not use-default-filename)
             (read-string (format "Filename [%s]: "
                                  org-download-screenshot-basename)
                          nil nil org-download-screenshot-basename)
           nil)))
    (org-download-clipboard file)))

(after! org
  (setq org-download-method 'directory)
  (setq org-download-image-dir "images")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_")
  (setq org-image-actual-width 300)
  (map! :map org-mode-map
        "C-c l a y" #'kou/org-download-paste-clipboard
        "C-i p" #'kou/org-download-paste-clipboard))


;; Go lang things
(setq auto-mode-alist
      (append '((".*\\.tmpl\\'" . web-mode))
              auto-mode-alist))
(setq web-mode-engines-alist
      '(
        ("go"    . "\\.tmpl\\'")
        )
)
