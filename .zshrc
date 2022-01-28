# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi
eval "$(starship init zsh)"

setopt interactivecomments
bindkey "^q" push-input
alias r=ranger

play() {
  cd ~/fun/play
  nvim -c "wincmd l" -O Cargo.toml src/main.rs
}

export EDITOR=nvim

NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$PATH:${HOME}/.cargo/bin"
export PATH="$PATH:${HOME}/scripts"

export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

eval $(thefuck --alias)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
