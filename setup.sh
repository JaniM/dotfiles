#!/usr/bin/env sh

link() {
  dir="$(dirname "$1")"
  if [ ! -z "$dir" ]; then
    mkdir -p "$HOME/$dir"
    echo "made path ~/$dir"
  fi
  if [ ! -e "$HOME/$1" ]; then
    ln -s "$HOME/dotfiles/$1" "$HOME/$1"
    echo "~/$1 -> ~/dotfiles/$1"
  else
    echo "~/$1 exists"
  fi
}

link scripts
link .doom.d
link .tmux.conf
link .config/Code/User/settings.json


