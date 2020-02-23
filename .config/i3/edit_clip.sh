#!/bin/bash

set +eu

time=$(date +"%Y-%m-%d_%H-%M-%S")
path="$HOME/clips/$time"

cd $HOME/clips
xclip -o -sel clip > $path
vim $path
xclip -i -sel clip < $path

