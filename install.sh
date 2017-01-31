#!/bin/bash

if [ -z $1 ];then
	echo "You must specify your home dir"
	exit 1
else
	home_dir=$1
fi

backup_dir="backup/dotfiles"
vim_dir="$home_dir/.vim"

git_install_package()
{
	install_dir=$(echo $1 | cut -d'/' -f5-)
	if [ ! -d "$vim_dir/bundle/$install_dir" ]; then
 		echo "Installing $install_dir"
 		cd $vim_dir/bundle
 		git clone $1
		cd -
	else
		echo "  - $install_dir... OK!"
	fi
}

backup()
{
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
}

vim_install()
{
	echo "Copying .vimrc"
	cp .vimrc ~/.vimrc
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
		cd -
	else
		echo "Pathogen... OK!"
	fi
	
	echo "Installing plugins:"
	git_install_package "https://github.com/jeetsukumaran/vim-filebeagle"
	git_install_package "https://github.com/itchyny/lightline.vim"
	git_install_package "https://github.com/octol/vim-cpp-enhanced-highlight"
	git_install_package "https://github.com/elzr/vim-json"
	git_install_package "https://github.com/hdima/python-syntax"
	git_install_package "https://github.com/tpope/vim-markdown"
	git_install_package "https://github.com/nelstrom/vim-markdown-folding"
	git_install_package "https://github.com/stephpy/vim-yaml"
	git_install_package "https://github.com/vim-scripts/nginx.vim"
	git_install_package "https://github.com/pangloss/vim-javascript"
	git_install_package "https://github.com/lepture/vim-jinja"
	git_install_package "https://github.com/mxw/vim-jsx"
	
	echo "Installing themes:"
	git_install_package "https://github.com/vim-scripts/256-grayvim"
	git_install_package "https://github.com/morhetz/gruvbox"
	git_install_package "https://github.com/NLKNguyen/papercolor-theme"
}

bashrc_install()
{
	echo "Copying .bashrc"
	cp .bashrc ~/.bashrc
}

git_install()
{
	echo "Copying .gitconfig"
	cp .gitconfig ~/.gitconfig
}

backup
vim_install
bashrc_install
git_install $home_dir
