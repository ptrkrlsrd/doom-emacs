;; -*- no-byte-compile: t; -*-
;;; private/default/packages.el

(package! emacs-snippets
  :recipe (:fetcher github
           :repo "hlissner/emacs-snippets"
           :files ("*")))


(package! angular-mode)
(package! company-lsp
  :ensure t
  :init)
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
  :init)
(package! lsp-typescript)
(package! lsp-ui)
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

(use-package lsp-javascript-typescript
  :ensure t
  :init
  (require 'lsp-javascript-typescript)
  (add-hook 'js-mode-hook #'lsp-mode)
  (add-hook 'typescript-mode-hook #'lsp-mode))

(require 'kubernetes)
(require 'vue-mode)
