;; -*- no-byte-compile: t; -*-
;;; private/default/packages.el

(package! emacs-snippets
  :recipe (:fetcher github
           :repo "hlissner/emacs-snippets"
           :files ("*")))

(package! ace-jump-mode
  :ensure
  :init)

(package! angular-mode)

(package! company-lsp
  :ensure t
  :init
  :after (lsp-mode lsp-ui)
  :config
  (setq company-backends '(company-lsp))
  (setq company-lsp-async t))

(package! dot-mode)

(package! evil-magit
  :ensure t
  :init)

(package! evil-org
  :ensure t
  :init)

(package! kubernetes
  :ensure t
  :init)

(package! kubernetes-evil
  :ensure t
  :init)

(package! lsp-go)

(package! lsp-mode
  :ensure t
  :defer t
  :init
  :config
  (lsp-mode))

(package! lsp-typescript)

(package! lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-flycheck-enable t)
  (setq imenu-auto-rescan t)
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-ui-mode . flycheck-mode))

(package! lsp-vue)

(package! go-tag)

(package! spotify)

(package! swiper
  :ensure t
  :init)

(package! swiper-helm
  :ensure t
  :init)

(package! vue-mode
  :ensure t
  :init
  (require 'vue-mode)
  (add-hook 'vue-mode-hook))

(package! helm-spotify-plus)

(package! graphviz-dot-mode)

(use-package evil-magit
             :ensure t
             :init)

;(use-package lsp-javascript-typescript
;  :ensure t
;  :init
;  (require 'lsp-javascript-typescript)
;  (add-hook 'js-mode-hook #'lsp-mode)
;  (add-hook 'typescript-mode-hook #'lsp-mode))

(package! kubernetes
  :ensure t
  :commands (kubernetes-overview))

;; If you want to pull in the Evil compatibility package.
(package! kubernetes-evil
  :ensure t
  :after kubernetes)

(require 'vue-mode)
