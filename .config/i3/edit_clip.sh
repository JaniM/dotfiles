#!/bin/bash

set +eu

time=$(date +"%Y-%m-%d_%H-%M-%S")
path="$HOME/clips/$time.md" # use md to enable fun features

cd $HOME/clips
xclip -o -sel clip > $path
vim $path
xclip -i -sel clip < $path

