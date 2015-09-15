#!/bin/bash

if [ -z $1 ];then
	echo "You must specify your home dir"
	exit 1
else
	home_dir=$1
fi
backup_dir="backup/dotfiles"
vim_dir="$home_dir/.vim"

git_install()
{
	install_dir=$(echo $1 | cut -d'/' -f5-)
	if [ -d $install_dir ]; then
 		echo "Installing $install_dir"
 		cd $vim_dir/bundle
 		git clone $1
	else
		echo "  - $install_dir... OK!"
	fi
}

echo "Backup old files"
mkdir -p ~/$backup_dir
mv ~/.vimrc ~/$backup_dir/.vimrc
mv ~/.gitconfig ~/$backup_dir/.gitconfig

echo "Copying .vimrc"
cp .vimrc ~/.vimrc
echo "Copying .gitconfig"
cp .gitconfig ~/.gitconfig


if [ ! -d $vim_dir ];then
	echo "Creating vim basic dirs"
	mkdir -p $vim_dir/{autoload,bundle}
else
	echo "Vim basic dirs... OK!"
fi
if [ ! -e "$vim_dir/autoload/pathogen.vim" ]; then
	echo "Installing Pathogen"
	cd $vim_dir/autoload
	wget https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
else
	echo "Pathogen... OK!"
fi

echo "Installing plugins:"
git_install "https://github.com/scrooloose/nerdtree"
git_install "https://github.com/itchyny/lightline.vim"
git_install "https://github.com/vim-scripts/desertEx"
git_install "https://github.com/vim-scripts/256-grayvim"
