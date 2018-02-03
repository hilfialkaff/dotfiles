#!/bin/bash

brew install tmux zsh
cp .tmux.conf ~
cp .zshrc ~
cp .vim* ~ -r
cp .gitconfig ~
cp .gitignore_global ~
cp .dircolors ~

chsh -s $(which zsh)
