;;; private/default/config.el -*- lexical-binding: t; -*-

(load! +bindings)


;;
;; Plugins
;;

(def-package! emacs-snippets :after yasnippet)


;;
;; Config
;;

(after! epa
  (setq epa-file-encrypt-to (or epa-file-encrypt-to user-mail-address)
        ;; With GPG 2.1, this forces gpg-agent to use the Emacs minibuffer to
        ;; prompt for the key passphrase.
        epa-pinentry-mode 'loopback))


(when (featurep 'evil)
  (load! +evil-commands)

  ;; Makes ; and , the universal repeat-keys in evil-mode
  (defmacro do-repeat! (command next-func prev-func)
    "Repeat motions with ;/,"
    (let ((fn-sym (intern (format "+evil*repeat-%s" command))))
      `(progn
         (defun ,fn-sym (&rest _)
           (define-key evil-motion-state-map (kbd ";") ',next-func)
           (define-key evil-motion-state-map (kbd ",") ',prev-func))
         (advice-add #',command :before #',fn-sym))))

  ;; n/N
  (do-repeat! evil-ex-search-next evil-ex-search-next evil-ex-search-previous)
  (do-repeat! evil-ex-search-previous evil-ex-search-next evil-ex-search-previous)
  (do-repeat! evil-ex-search-forward evil-ex-search-next evil-ex-search-previous)
  (do-repeat! evil-ex-search-backward evil-ex-search-next evil-ex-search-previous)

  ;; f/F/t/T/s/S
  (after! evil-snipe
    (setq evil-snipe-repeat-keys nil
          evil-snipe-override-evil-repeat-keys nil) ; causes problems with remapped ;

    (do-repeat! evil-snipe-f evil-snipe-repeat evil-snipe-repeat-reverse)
    (do-repeat! evil-snipe-F evil-snipe-repeat evil-snipe-repeat-reverse)
    (do-repeat! evil-snipe-t evil-snipe-repeat evil-snipe-repeat-reverse)
    (do-repeat! evil-snipe-T evil-snipe-repeat evil-snipe-repeat-reverse)
    (do-repeat! evil-snipe-s evil-snipe-repeat evil-snipe-repeat-reverse)
    (do-repeat! evil-snipe-S evil-snipe-repeat evil-snipe-repeat-reverse)
    (do-repeat! evil-snipe-x evil-snipe-repeat evil-snipe-repeat-reverse)
    (do-repeat! evil-snipe-X evil-snipe-repeat evil-snipe-repeat-reverse))

  ;; */#
  (after! evil-visualstar
    (do-repeat! evil-visualstar/begin-search-forward
                evil-ex-search-next evil-ex-search-previous)
    (do-repeat! evil-visualstar/begin-search-backward
                evil-ex-search-previous evil-ex-search-next))

  (after! evil-easymotion
    (let ((prefix (concat doom-leader-key " /")))
      ;; NOTE `evilem-default-keybinds' unsets all other keys on the prefix (in
      ;; motion state)
      (evilem-default-keybindings prefix)
      (evilem-define (kbd (concat prefix " n")) #'evil-ex-search-next)
      (evilem-define (kbd (concat prefix " N")) #'evil-ex-search-previous)
      (evilem-define (kbd (concat prefix " s")) #'evil-snipe-repeat
                     :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
                     :bind ((evil-snipe-scope 'buffer)
                            (evil-snipe-enable-highlight)
                            (evil-snipe-enable-incremental-highlight)))
      (evilem-define (kbd (concat prefix " S")) #'evil-snipe-repeat-reverse
                     :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
                     :bind ((evil-snipe-scope 'buffer)
                            (evil-snipe-enable-highlight)
                            (evil-snipe-enable-incremental-highlight))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(exec-path-from-shell-initialize)

(mapc 'exec-path-from-shell-copy-env (list
              "GOPATH"
              "GOBIN"
              "RUST_SRC_PATH"))

(setq omnisharp-server-executable-path
      "~/.emacs.d/.cache/omnisharp/server/v1.26.3/run")

;(if (eq system-type 'gnu/linux))

(setq racer-rust-src-path
    "~/Development/Resources/rust/src/")

(setq doom-font (font-spec
                    :family "Hack"
                    :size 11)
        doom-big-font (font-spec :family "Hack" :size 14))

(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Petter Karlsrud\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
  "-----")

(global-set-key [C-S-f1] 'org-skeleton)

(setq markdown-open-command "/usr/bin/typora")

; Disable theme before reloading
(defadvice load-theme (before theme-dont-propagate activate)
    (mapc #'disable-theme custom-enabled-themes))

(after! go-mode
  (defun my-go-mode-hook ()
    (push 'company-go company-backends))
  (add-hook 'go-mode-hook 'my-go-mode-hook))

(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 3))

(after! ace-window
  (setq aw-keys '(?h ?j ?k ?l ?a ?s ?d)
        aw-ignore-current t))

(after! org
  (set-face-foreground 'org-level-1 "#ffffff")
  (set-face-foreground 'org-level-2 "#ffffff")
  (set-face-foreground 'org-level-3 "#ffffff")
  (set-face-foreground 'org-level-4 "#ffffff")
  (set-face-foreground 'org-level-5 "#ffffff")
  (set-face-foreground 'org-level-6 "#ffffff")
  (set-face-foreground 'org-level-7 "#ffffff")

  (set-face-attribute 'org-level-4 nil :weight 'normal)
  (set-face-attribute 'org-level-5 nil :weight 'normal)
  (set-face-attribute 'org-level-6 nil :weight 'normal)
  (set-face-attribute 'org-level-7 nil :weight 'normal)
  (setq org-bullets-bullet-list '("◉" "◎" "⚫"))

  (setq org-agenda-files (apply 'append
                                (mapcar (lambda (directory)
                                          (directory-files-recursively
                                           directory org-agenda-file-regexp))
                                        '("~/Documents/Org/" "~/Dropbox/Org")))))

(after! rotate-text
  (push '("monday" "tuesday" "wednesday" "thursday" "friday" "saturday" "sunday") rotate-text-words)
  (push '("update" "insert" "delete" "select") rotate-text-words)
  (push '("album" "artist" "track") rotate-text-words)
  (push '("primary" "secondary") rotate-text-words)
  (push '("mandag" "tirsdag" "onsdag" "torsdag" "fredag" "lørdag" "søndag") rotate-text-words))

(require 'vue-mode)

; Use different themes for graphic and terminal Emacs
(if (display-graphic-p)
    (setq doom-theme 'doom-dracula)
  (setq doom-theme 'doom-spacegrey))
