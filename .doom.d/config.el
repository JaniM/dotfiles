(setq user-full-name "Jani Mustonen"
      user-mail-address "janijohannes@kapsi.fi")

(setq auth-sources '("~/.authinfo"))

(setq doom-theme 'doom-gruvbox)
(set-face-attribute 'default nil :height 150)

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package! color-identifiers-mode
  :config
  (add-hook 'after-init-hook #'global-color-identifiers-mode)
  (setq color-identifiers:min-color-saturation 0.5))

(setq display-line-numbers-type t)

(setq org-directory "~/org")

;; Restore default TAB behavior
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(setq org-default-notes-file (concat org-directory "/index.org"))

(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

;; patch rustic for stable rust
(after! rustic
  (setq rustic-flycheck-clippy-params "--message-format=json"))
