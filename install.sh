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
	if [ ! -d "$vim_dir/bundle/$install_dir" ]; then
 		echo "Installing $install_dir"
 		cd $vim_dir/bundle
 		git clone $1
	else
		echo "  - $install_dir... OK!"
	fi
}

echo "Backup old files"
mkdir -p ~/$backup_dir
if [[ -f ~/.vimrc ]]; then
	mv ~/.vimrc ~/$backup_dir/.vimrc
fi
if [[ -f ~/.gitconfig ]]; then
	mv ~/.gitconfig ~/$backup_dir/.gitconfig
fi
if [[ -f ~/.bashrc ]]; then
	mv ~/.bashrc ~/$backup_dir/.bashrc
fi

echo "Copying .vimrc"
cp .vimrc ~/.vimrc
echo "Copying .gitconfig"
cp .gitconfig ~/.gitconfig
echo "Copying .bashrc"
cp .bashrc ~/.bashrc
echo "Copying diffwrap"
cp diffwrap.sh ~/diffwrap.sh


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
git_install "https://github.com/jeetsukumaran/vim-filebeagle"
git_install "https://github.com/itchyny/lightline.vim"
git_install "https://github.com/octol/vim-cpp-enhanced-highlight"
git_install "https://github.com/elzr/vim-json"
git_install "https://github.com/hdima/python-syntax"
git_install "https://github.com/tpope/vim-markdown"
git_install "https://github.com/nelstrom/vim-markdown-folding"
git_install "https://github.com/stephpy/vim-yaml"
echo "Installing themes:"
git_install "https://github.com/vim-scripts/desertEx"
git_install "https://github.com/vim-scripts/256-grayvim"
git_install "https://github.com/andrwb/vim-lapis256"
git_install "https://github.com/NLKNguyen/papercolor-theme"
