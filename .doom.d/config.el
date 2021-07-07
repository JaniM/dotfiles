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

(setq lsp-eslint-server-command
   '("node"
     "/home/jani/.vscode/extensions/dbaeumer.vscode-eslint-2.1.8/server/out/eslintServer.js"
     "--stdio"))

(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)

(add-hook 'after-init-hook #'desktop-read)

(use-package! company-tabnine)
(after! company-tabnine
  (set-company-backend! 'python-mode #'company-tabnine)
  (set-company-backend! 'rustic-mode #'company-tabnine)
  ;; Trigger completion immediately.
  (setq company-idle-delay 0)

  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (setq company-show-numbers t))
