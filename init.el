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
  '(ht loop flx babel company better-defaults ein elpy exec-path-from-shell flycheck js2-mode json-mode magit markdown-mode markdown-preview-mode py-autopep8 rainbow-delimiters smart-mode-line web-mode yaml-mode which-key org htmlize paredit paredit-everywhere command-log-mode dash ivy windmove))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; Load all files in the LISP directory
(defun load-directory (dir)
  (let ((load-it (lambda (f)
                   (load-file (concat (file-name-as-directory dir) f)))))
    (mapc load-it (directory-files dir nil "\\.el$"))))
    (load-directory "~/.emacs.d/lisp/")

(add-to-list 'load-path "~/.emacs.d/lisp/")
(load-library "new_funcs")
;;(require 'new_funcs)

;;Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; BASIC CUSTOMIZATION
;; --------------------------------------

;;cheatsheet
(require 'cheatsheet)
(global-set-key (kbd "C-x e") 'cheatsheet-show)

;; whichkey(which-key-setup-minibuffer)

;;Windmove
(windmove-default-keybindings)
;(global-set-key (kbd "C-c C-r") 'ivy-resume)

; And add babel inline code execution babel, for executing code in org-mode.
(org-babel-do-load-languages
 'org-babel-load-languages

;;load all language marked with (lang . t).
 '((C . t) (R . t) (asymptote) (awk . t) (calc) (clojure) (comint) (css . t) (ditaa . t) (dot . t) (emacs-lisp . t) (fortran . t) (gnuplot . t) (haskell) (io) (java) (js . t) (latex) (ledger) (lilypond) (lisp) (matlab) (maxima) (mscgen) (ocaml) (octave) (org . t)(perl . t) (picolisp) (plantuml) (python . t) (ref) (ruby . t) (sass . t) (scala . t) (scheme) (screen) (sh . t) (shen) (sql . t) (sqlite)))

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

;;Ivy, Swiper, Counsel
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-display-style 'fancy)
(setq swiper-completion-method 'ivy)
(setq ivy-count-format "(%d/%d) ")
;;(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-x <down>") 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

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

;;Company
(require 'company)
(define-key company-active-map (kbd "C-n") 'comany-select-next)
(define-key company-active-map (kbd "C-p") 'comany-select-previous)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)

(setq elpy-rpc-python-command "python3")
(setq python-shell-interpreter "python3")

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
