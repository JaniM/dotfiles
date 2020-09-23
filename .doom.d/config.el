(setq user-full-name "Jani Mustonen"
      user-mail-address "janijohannes@kapsi.fi")

(setq auth-sources '("~/.authinfo"))

(setq doom-theme 'doom-gruvbox)
(setq inhibit-x-resources t)

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package! color-identifiers-mode
  :config
  (add-hook 'after-init-hook #'global-color-identifiers-mode)
  (setq color-identifiers:min-color-saturation 0.3)
  (setq color-identifiers:color-luminance 0.7))

(setq display-line-numbers-type t)

(setq doom-font (font-spec :family "Fira Code" :size 20)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 21 :weight 'bold) ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Fira Code" :size 20)
      doom-big-font (font-spec :family "Fira Code" :size 28))

(use-package! mixed-pitch
  :config
  (setq mixed-pitch-set-height 't)
  (add-hook 'org-mode-hook #'mixed-pitch-mode)
  (add-hook 'markdown-mode-hook #'mixed-pitch-mode))

(use-package! fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("x" "#["))
  :hook prog-mode)

(setq org-directory "~/org")

;; Restore default TAB behavior
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(setq org-default-notes-file (concat org-directory "/index.org"))

(use-package! org-notify
  :config
  (org-notify-start)
  (org-notify-add 'default)
  (org-notify-add 'yes
                  '(:time "1h" :period "10m" :duration 20
                    :actions -notify/window)
                  '(:time "2h" :period "10m" :actions -message)
                  '(:time "1d" :duration 300 :actions -notify/window)))

(add-hook 'org-mode-hook #'visual-line-mode)

(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

;; patch rustic for stable rust
(after! rustic
  (setq rustic-flycheck-clippy-params "--message-format=json"))

(setq lsp-rust-analyzer-cargo-watch-command "clippy")

(add-hook 'markdown-mode-hook #'visual-line-mode)

(after! projectile
  (setq projectile-project-root-files '(".git")))

(after! calendar
  (setq calendar-week-start-day 1))

(after! yasnippet
  (define-key yas-minor-mode-map (kbd "C-§") #'yas-expand))
