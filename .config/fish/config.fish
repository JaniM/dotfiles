
# Remove the annoying header
set fish_greeting

alias fc "vim ~/.config/fish/config.fish; and source ~/.config/fish/config.fish"
alias ic "vim ~/.config/i3/config; and i3 reload"
alias cf "vim (find ~/.config -type f | fzf)"

abbr ts "taito start"
abbr ti "taito install"
abbr tl "taito open logs:prod"
abbr tk "taito open kanban"

abbr ga 'git add -A'
abbr gc 'git commit -m'
abbr gca 'git commit . -m'
abbr gcal 'git commit . -m "style: lint"'
abbr gp "git pull --rebase"
abbr gs "git status"
abbr gd "git diff"
abbr gco 'git checkout'

alias podlog "kubectl logs -f (kubectl get pods | fzf -n1 --header-lines=1 --height=20 --reverse | cut -f1 -d\ )"
alias pod "kubectl get pods | fzf -n1 --header-lines=1 --height=20 --reverse | cut -f1 -d\ "
alias podc "pod | tee /dev/tty | head -c -1 | xclip -i -sel clip"
alias kubecontext "kubectl config use-context (kubectl config get-contexts | fzf -n2 --header-lines=1 --height=20 --reverse | tr '*' ' ' | awk '{print \$1;}')"

function org
  fish -c "cd ~/org && vim $argv"
end
abbr o 'org index.org'
abbr ow 'org work.org'

function c
  printf "%s" $argv | xclip -i -sel clip
end

set -x NPM_PACKAGES "$HOME/.npm-packages"
set -x FZF_DEFAULT_OPTS "--height=20"
set -x FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore'

set -x EDITOR vim
set -x PATH "$NPM_PACKAGES/bin" "$HOME/.emacs.d/bin" $PATH

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
set MANPATH
set -x MANPATH "$NPM_PACKAGES/share/man:"(manpath)

thefuck --alias | source

