;; init.el --- Emacs configuration

(desktop-save-mode 1)

(setq user-full-name "Matthew S. ONeil")
(setq user-mail-address "nwyawka@gmail.com")
(setq python-indent-offset 4)

;; INSTALL PACKAGES
;; --------------------------------------

(fset 'yes-or-no-p 'y-or-n-p)

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(ido
    flx
    babel
    company
    ace-window
    better-defaults
    ein
    elpy
    exec-path-from-shell
    flycheck
    go-add-tags
    go-autocomplete
    go-eldoc
    go-guru
    go-mode
    js2-mode
    json-mode
    markdown-mode
    markdown-preview-mode
    py-autopep8
    rainbow-delimiters
    smart-mode-line
    web-mode
    yaml-mode
    which-key
    counsel
    org
    swiper
    htmlize
    flatland-theme
    paredit
    paredit-everywhere
    spacegray-theme
    command-log-mode
    smex))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(add-to-list 'load-path "~/.emacs.d/lisp/ob-tangle.el")
(require 'ob-tangle)

(require 'smex) ; Not needed if you use package.el
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; OLD M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; BASIC CUSTOMIZATION
;; --------------------------------------
; And add babel inline code execution babel, for executing code in org-mode.
(org-babel-do-load-languages
 'org-babel-load-languages
 ; load all language marked with (lang . t).
 '((C . t)
   (R . t)
   (asymptote)
   (awk . t)
   (calc)
   (clojure)
   (comint)
   (css . t)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (fortran . t)
   (gnuplot . t)
   (haskell)
   (io)
   (java)
   (js . t)
   (latex)
   (ledger)
   (lilypond)
   (lisp)
   (matlab)
   (maxima)
   (mscgen)
   (ocaml)
   (octave)
   (org . t)
   (perl . t)
   (picolisp)
   (plantuml)
   (python . t)
   (ref)
   (ruby . t)
   (sass . t)
   (scala . t)
   (scheme)
   (screen)
   (sh . t)
   (shen)
   (sql . t)
   (sqlite)))

(add-hook 'after-init-hook 'global-company-mode)

(allout-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(global-hl-line-mode 1)
(set-face-background hl-line-face "white")

;; Start IDO
(setq ido-use-filename-at-point 'guess)

(require 'ido-vertical-mode)
(ido-mode 1)
(setq ido-use-faces t)
(set-face-attribute 'ido-vertical-first-match-face nil
                    :background nil
                    :foreground "orange")
(set-face-attribute 'ido-vertical-only-match-face nil
                    :background nil
                    :foreground nil)
(set-face-attribute 'ido-vertical-match-face nil
                    :foreground nil)
(ido-vertical-mode 1)

(setq ido-create-new-buffer 'always)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
;; End IDO

(add-to-list 'load-path "~/.emacs.d/lisp/describe-prefix-bindings.el")
(global-set-key (kbd "C-x r") 'describe-prefix-bindings)

;org-mode
(require 'org)
; and some more org stuff
; http://orgmode.org/guide/Activation.html#Activation
; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq inhibit-startup-message t) ;; hide the startup message
;(global-linum-mode t) ;; enable line numbers globally
(global-font-lock-mode 1)
(global-prettify-symbols-mode 1)
(set-face-attribute 'font-lock-comment-face nil :foreground "red" )

; Activate transparent GnuPG encryption.
(require 'epa-file)
;(epa-file-enable)

(global-set-key (kbd "M-p") 'ace-window)
(setq aw-background nil)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Ensure paredit is used EVERYWHERE!
(require 'paredit-everywhere)
(add-hook 'prog-mode-hook #'paredit-everywhere-mode)

(require 'rainbow-delimiters)
(add-hook 'lisp-mode-hook
            (lambda()
              (rainbow-delimiters-mode)
              ))

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
