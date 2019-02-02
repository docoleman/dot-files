(require 'package)

(message "Package required")

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enabled-at-startup nil)
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)

(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode t)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(setq visual-bell t)
(column-number-mode t)
(set-fill-column 80)

(message "visual-bell --> %s" visual-bell)

(defvar backup-dir "~/.emacs.d/backups/")
(setq backup-directory-alist (list (cons "." backup-dir)))
(setq make-backup-files nil)

;; Org mode!
; (use-package org
;   :ensure t)

(use-package helm
  :ensure t
  :diminish helm-mode
  :commands helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level))


(use-package evil
  :ensure t
  :config
  (message "evil-mode config section")

  (use-package evil-leader
    :ensure t
    :commands
    (global-evil-leader-mode evil-leader/set-leader evil-leader/set-key)
    :config
    (evil-leader/set-leader ",")
    (evil-leader/set-key
      "w" 'save-buffer
      "v" 'list-buffer
      ;; "1" ;; What's the function to hide other buffers and show the current one?
      "q" 'fill-paragraph
      "e" 'find-file
      "b" 'switch-to-buffer
      "k" 'kill-buffer
      )
  (use-package evil-commentary
    :ensure t))
  (global-evil-leader-mode t))
    
(evil-mode t)

(setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))
(setq org-agenda-files '("~/Dropbox/org/"))

(define-key lisp-interaction-mode-map (kbd "<C-return>") 'eval-last-sexp)




;; Evil Mode configuration
;; (dolist (mode '(eshell-mode
;; 		dired-mode
;; 		org-capture-mode
;; 		term-mode
;; 		))
;;   (add-to-list 'evil-emacs-state-modes mode))

;; (delete 'term-mode evil-insert-state-modes)
;; (delete 'eshell-mode evil-insert-state-modes)

;; (evil-add-hjkl-bindings occur-map-mode 'emacs
;;   (kbd "/")       'evil-search-forward
;;   (kbd "n")       'evil-search-next
;;   (kbd "N")       'evil-search-previous
;;   (kbd "C-d")     'evil-scroll-down
;;   (kdb "C-u")     'evil-scroll-up
;;   (kbd "C-w C-w") 'other-window)

;; Global bindings

(provide 'init)
