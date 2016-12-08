;; init.el --- Emacs configuration

(desktop-save-mode 1)

(setq user-full-name "Matthew S. ONeil")
(setq user-mail-address "nwyawka@gmail.com")
(setq python-indent-offset 4)

;; INSTALL PACKAGES
;; --------------------------------------

(fset 'yes-or-no-p 'y-or-n-p)

(split-window-right)

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(helm
    ace-window
    better-defaults
    ein
    tangotango-theme
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
    magit
    markdown-mode
    markdown-preview-mode
    helm-company
    py-autopep8
    rainbow-delimiters
    smart-mode-line
    web-mode
    yaml-mode
    which-key
    counsel
    hydra
    org
    swiper
    htmlize
    flatland-theme
    paredit
    spacegray-theme
    command-log-mode))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(add-to-list 'load-path "~/.emacs.d/lisp/helm-company.el")
(require 'helm-company)


(add-to-list 'load-path "~/.emacs.d/lisp/ob-tangle.el")
(require 'ob-tangle) 

(which-key-setup-minibuffer)
(setq which-key-popup-type 'minibuffer)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(require 'helm)

(setq helm-split-window-in-side-p     t ; open helm buffer in current window, not occupy whole other window
      helm-move-to-line-cycle-in-source t ; move to nd or beg of source when reaching top or bot of source.
      helm-ff-search-library-in-sexp   t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount               8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(allout-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;(global-hl-line-mode 1)

; Activate org-mode
(require 'org)
; and some more org stuff
; http://orgmode.org/guide/Activation.html#Activation
; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'tangotango t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

(global-prettify-symbols-mode 1)

(set-face-attribute 'font-lock-comment-face nil :foreground "#f44242")

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'arjen-grey t))

(defhydra hydra-buffer-menu (:color pink
                                    :hint nil)
    "
^Mark^             ^Unmark^           ^Actions^          ^Search
^^^^^^^^-----------------------------------------------------------------
_m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
_s_: save          _U_: unmark up     _b_: bury          _I_: isearch
_d_: delete        ^ ^                _g_: refresh       _O_: multi-occur
_D_: delete up     ^ ^                _T_: files only: % -28`Buffer-menu-files-only
_~_: modified
"
    ("m" Buffer-menu-mark)
    ("u" Buffer-menu-unmark)
    ("U" Buffer-menu-backup-unmark)
    ("d" Buffer-menu-delete)
    ("D" Buffer-menu-delete-backwards)
    ("s" Buffer-menu-save)
    ("~" Buffer-menu-not-modified)
    ("x" Buffer-menu-execute)
    ("b" Buffer-menu-bury)
    ("g" revert-buffer)
    ("T" Buffer-menu-toggle-files-only)
    ("O" Buffer-menu-multi-occur :color blue)
    ("I" Buffer-menu-isearch-buffers :color blue)
    ("R" Buffer-menu-isearch-buffers-regexp :color blue)
    ("c" nil "cancel")
    ("v" Buffer-menu-select "select" :color blue)
    ("o" Buffer-menu-other-window "other-window" :color blue)
    ("q" quit-window "quit" :color blue))

(define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
          (define-key company-active-map (kbd "C-:") 'helm-company)))

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
 '(safe-local-variable-values
   (quote
    ((eval setq byte-compile-not-obsolete-vars
           (quote
            (display-buffer-function)))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
