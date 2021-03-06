;; -*- no-byte-compile: t; -*-
;;; private/default/packages.el

(package! emacs-snippets
  :recipe (:fetcher github
           :repo "hlissner/emacs-snippets"
           :files ("*")))

(package! ace-jump-mode
  :ensure
  :init)

(package! protobuf-mode
  :ensure t
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

(package! go-gen-test)
(package! apropospriate-theme)

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

(package! lsp-go
  :ensure t)

(package! exec-path-from-shell
  :ensure t)

(package! lsp-mode
  :ensure t
  :defer t
  :init
  :config
  (lsp-mode))

(package! lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-flycheck-enable t)
  (setq imenu-auto-rescan t)
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-ui-mode . flycheck-mode))

(package! lsp-vue)

(package! go-tag
          :ensure t)

(package! spotify)

(package! swiper
  :ensure t
  :init)

(package! swiper-helm
  :ensure t
  :init)

(use-package vue-mode
  :ensure t
  :init)

(package! helm-spotify-plus)

(package! graphviz-dot-mode
          :ensure t)

(use-package evil-magit
             :ensure t
             :init)

(package! lsp-typescript)
(use-package lsp-javascript-typescript
  :ensure t
  :init
  (require 'lsp-javascript-typescript)
  (add-hook 'js-mode-hook #'lsp-mode)
  (add-hook 'typescript-mode-hook #'lsp-mode))

(package! kubernetes
  :ensure t
  :commands (kubernetes-overview))

(package! kubernetes-evil
  :ensure t
  :after kubernetes)
