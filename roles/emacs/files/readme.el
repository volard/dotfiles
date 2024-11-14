(require 'package)
(require 'use-package-ensure) ;; Load use-package-always-ensure
(setq use-package-always-ensure t) ;; Always ensures that a package is installed

(setq package-archives '(("melpa" . "https://melpa.org/packages/") ;; Sets default package repositories
                        ("org" . "https://orgmode.org/elpa/")
                        ("elpa" . "https://elpa.gnu.org/packages/")
                        ("nongnu" . "https://elpa.nongnu.org/nongnu/"))) ;; For Eat Terminal

(package-initialize)

(use-package diminish)

(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	"https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setopt x-underline-at-descent-line nil)           ; Prettier underlines
    (blink-cursor-mode -1)                                ; Steady cursor

    ; Remap M-x to C-c x
    (global-set-key (kbd "C-c x") 'execute-extended-command)

    ; make ESC escape shit
    (global-set-key (kbd "<escape>") 'keyboard-escape-quit)


    (tool-bar-mode -1)             ; Disable the tool bar
    (menu-bar-mode -1)             ; Disable the menu bar 
    (scroll-bar-mode -1)           ; Hide the always-visible scrollbar
    (electric-indent-mode nil)     ; Turn off the weird indenting that Emacs does by default.
    (electric-pair-mode t)         ; Turns on automatic parens pairing
    (setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen





    ;; define function to shutdown emacs server instance
    (defun server-shutdown ()
	"Save buffers, Quit, and Shutdown (kill) server"
	(interactive)
	(save-some-buffers)
	(kill-emacs)
    )

	
    (use-package doom-modeline
	:init (doom-modeline-mode 1)
	:custom ((doom-modeline-height 15))
    )

   

(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.

(setq delete-by-moving-to-trash t)

(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
)

;(use-package gruvbox-theme
	;  :config
	;  (load-theme 'gruvbox-dark-medium t) ;; We need to add t to trust this package
 ; )

(use-package doom-themes
  :init (load-theme 'doom-dracula t)
)

; M-x menu-set-font to see the font and fontset menu
; M-x describe-font to see the requested font and actual font being used.
(set-face-attribute 'default nil
		    :font "JetBrainsMono NFM-14.5" )
(set-frame-font "JetBrainsMono NFM-12.5" nil t)

  ;; This sets the default font on all graphical frames created after restarting Emacs.
  ;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
  ;; are not right unless I also add this method of setting the default font.

(add-to-list 'default-frame-alist '(font . "JetBrainsMono NFM-14.5")) ;; Set your favorite font

;; M-x nerd-icons-install-fonts
(setq doom-modeline-icon t)

(use-package all-the-icons-dired
    :hook (dired-mode . all-the-icons-dired-mode)
)

(add-hook 'dired-mode-hook
      (lambda ()
        (dired-hide-details-mode)
        (dired-sort-toggle-or-edit))
)

(use-package emacs
  :bind
  ("C-+" . text-scale-increase)
  ("C--" . text-scale-decrease)
  ("<C-wheel-up>" . text-scale-increase)
  ("<C-wheel-down>" . text-scale-decrease)
)

(global-set-key [escape] 'keyboard-escape-quit)

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme"))
)

(
  use-package which-key
    :config
      (which-key-mode)
)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil)
)


(use-package evil
  :init ;; Execute code Before a package is loaded
    (evil-mode)

  :config ;; Execute code After a package is loaded
    (evil-set-initial-state 'eat-mode 'insert) ;; Set initial state in eat terminal to insert mode
    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal)

  :custom ;; Customization of package custom variables
    (evil-want-keybinding nil)    ;; Disable evil bindings in other modes (It's not consistent and not good)
    (evil-want-C-u-scroll t)      ;; Set C-u to scroll up
    (evil-want-C-i-jump nil)      ;; Disables C-i jump
    (evil-undo-system 'undo-redo) ;; C-r to redo
    (org-return-follows-link t)   ;; Sets RETURN key in org-mode to follow links

  ;; Unmap keys in 'evil-maps. If not done, org-return-follows-link will not work
  :bind (:map evil-motion-state-map
            ("SPC" . nil)
            ("RET" . nil)
            ("TAB" . nil)
        )
)



(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init)
)
(use-package evil-tutor)

(use-package dashboard
  :init
    (setq initial-buffer-choice 'dashboard-open)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
    ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
    (setq dashboard-startup-banner "~/.config/emacs/images/dtmacs-logo.png")  ;; use custom image as banner
    (setq dashboard-center-content nil) ;; set to 't' for centered content
    (setq dashboard-items '((recents . 5)
                            (agenda . 5 )
                            (bookmarks . 3)
                            (projects . 3)
                            (registers . 3)))
  :custom 
    (dashboard-modify-heading-icons '((recents . "file-text")
                (bookmarks . "book")))
  :config
    (dashboard-setup-startup-hook))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap ("C-c p" . projectile-command-map)
)

(use-package counsel-projectile
  :after projectile
  :config
    (counsel-projectile-mode 1)
)

(require 'org)

; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

; Try to remove strange auto indents
(setq org-adapt-indentation nil)

(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE"))
)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(setq org-hide-emphasis-markers t)

(setq org-src-fontify-natively t
	  org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

(add-hook 'org-mode-hook 'visual-line-mode)

;; Org styling, hide markup etc.
    (setq org-adapt-indentation t
	  org-hide-leading-stars t
	  ;org-hide-emphasis-markers t
	  org-pretty-entities t )

(use-package org-modern)
(with-eval-after-load 'org (global-org-modern-mode))

(straight-use-package 'ivy) 
  (straight-use-package 'swiper) 
  (straight-use-package 'counsel) 

  (ivy-mode 1)

  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
)

(straight-use-package 'helm)
;(global-set-key (kbd "C-c x") 'helm-M-x)
(helm-mode 1) ; make helm-mode start with Emacg
(setq completion-styles '(flex)) ; emacs 27+

(use-package lsp-mode
  :init
    (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
    (lsp-enable-which-key-integration t)
)

(use-package lsp-ui 
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
    (lsp-ui-doc-position 'bottom)
)

(use-package treemacs
  :after lsp
  :config
    ;(treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
)

(use-package treemacs-evil
  :after (treemacs evil)
)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
)

(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(use-package magit)

(use-package lua-mode)
  (use-package php-mode)
  (use-package web-mode)

; Makes web-mode the default mode for editing web files
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(use-package company
    :after lsp-mode
    :hook (lsp-mode . company-mode)
    :bind 
          (:map company-active-map
            ("<tab>" . company-complete-selection)
          )
          (:map lsp-mode-map
            ("<tab>" . company-indent-or-complete-common)
          )
    :custom
      (company-minimum-prefix-length 1)
      (company-idle-delay 0.0)
  )

  (use-package company-box
    :hook (company-mode . company-box-mode)
  )

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package term
  :config
  (setq explicit-shell-file-name "pwsh") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
)

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))
