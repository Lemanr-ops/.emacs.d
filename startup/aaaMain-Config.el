(setq inhibit-startup-message t)

(tool-bar-mode 1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode 1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)


;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))
;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


(unless (package-installed-p 'waher-theme)
  (package-install 'waher-theme))
(load-theme 'waher)
;self explainatory
(column-number-mode)
;row/column numbers in mode line
(global-display-line-numbers-mode)
(display-battery-mode)

;Adds completion functionality in minibuffer
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done))         
  :config
  (ivy-mode 1))

;your modeline (layer directly on top of minibuffer)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;pretty ()
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;Tells you short cut keys
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 2))


; gives extra info to M-x functions
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))
; adds additional info to M-x commands
(use-package ivy-rich
  :init (ivy-rich-mode 1))

;avoid asynch buffer creation
(add-to-list 'display-buffer-alist
  (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))
;===From Emacs Desktop environment #2 improving
;setup brightness and volumn keys
;(use-package desktop-environment
;  :after exwm
;  :config (desktop-environment-mode)
;  :custom
;  (desktop-environment-brightness-small-increment "2%+")
;  (desktop-environment-brightness-small-decrement "2%-")
;  (desktop-environment-brightness-normal-increment "5%+")
;  (desktop-environment-brightness-normal-dncrement "5%-"))


;EXWM setup
;Needed for system tray, able to run apps in background
;(defun efs/run-in-background (command)
;  (let ((command-parts (split-string command "[ ]+")))
;    (apply #'call-process '(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))
;(defun efs/exwm-init-hook ()
;  (exwm-workspace-switch-create 1)

;(efs/run-in-background "nm-applet")) ;Experimenting with

;(defun efs/exwm-update-class ()
;  (exwm-workspace-rename-buffer exwm-class-name))

;(use-package exwm
;  :config
  ;; Set the default number of workspaces
;  (setq exwm-workspace-number 5)

  ;; When window "class" updates, use it to set the buffer name
;  (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

  ;; These keys should always pass through to Emacs
;  (setq exwm-input-prefix-keys
;    '(?\C-x
;      ?\C-u
;      ?\C-h
;      ?\M-x
;      ?\M-`
;      ?\M-&
;      ?\M-:
;      ?\C-\M-j  ;; Buffer list
;      ?\C-\ ))  ;; Ctrl+Space

  ;; Ctrl+Q will enable the next key to be sent directly
;  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
;  (setq exwm-input-global-keys
;        `(
          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
;          ([?\s-r] . exwm-reset)

          ;; Move between windows
;          ([s-left] . windmove-left)
;          ([s-right] . windmove-right)
;          ([s-up] . windmove-up)
;          ([s-down] . windmove-down)

          ;; Launch applications via shell command
;          ([?\s-&] . (lambda (command)
;                       (interactive (list (read-shell-command "$ ")))
;                       (start-process-shell-command command nil command)))

          ;; Switch workspace
;          ([?\s-w] . exwm-workspace-switch)

;          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
;          ,@(mapcar (lambda (i)
;                      `(,(kbd (format "s-%d" i)) .
;                        (lambda ()
;                          (interactive)
;                          (exwm-workspace-switch-create ,i))))
;                    (number-sequence 0 9))))
;  (exwm-enable))
(display-time-mode)
;(exwm-init)

;setup emacs as commonlisp IDE with SLIME
;remember to do this in terminal sbcl --eval '(ql:quickload :quicklisp-slime-helper)' --quit
(unless (package-installed-p 'slime)
  (package-install 'slime))
(setq inferior-lisp-program "sbcl")
