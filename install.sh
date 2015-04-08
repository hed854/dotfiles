#!/bin/bash

backup_dir="backup_dotfiles"

echo "backup old files"
mkdir -p ~/$backup_dir
mv ~/.vimrc ~/$backup_dir/.vimrc
mv ~/.gitconfig ~/$backup_dir/.gitconfig

echo "copying .vimrc"
cp .vimrc ~/.vimrc
echo "copying .gitconfig"
cp .gitconfig ~/.gitconfig

if [ ! -d ~/.vim ];then
	echo "installing vim"
	mkdir -p ~/.vim/{colors,autoload,bundle,syntax}
	wget http://www.vim.org/scripts/download_script.php?src_id=16802 -O ~/.vim/colors/desertEx.vim
	wget http://www.vim.org/scripts/download_script.php?src_id=12849 -O ~/.vim/colors/256-grayvim.vim
fi
