#!/bin/bash

backup_dir="backup_dotfiles"

echo "creating backup dir"
mkdir ~/$backup_dir
echo "backup current .vimrc"
mv ~/.vimrc ~/$backup_dir/.vimrc
echo "copying .vimrc"
cp .vimrc ~/.vimrc
echo "backup current .gitconfig"
mv ~/.gitconfig ~/$backup_dir/.gitconfig
echo "copying .gitconfig"
cp .gitconfig ~/.gitconfig
