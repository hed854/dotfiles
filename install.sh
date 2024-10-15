#!/bin/bash

# prerequisites: git, wget
# Parameter: home dir (mandatory)
if [ -z $1 ];then
	echo "You must specify your home dir"
	exit 1
else
	home_dir=$1
fi
echo "Set home dir: $home_dir"

backup_dir="backup/dotfiles"

git_install_package()
{
	install_dir=$(echo $1 | cut -d'/' -f5-)
	if [ ! -d "~/.vim/bundle/$install_dir" ]; then
 		echo "Installing $install_dir"
 		cd ~/.vim/bundle
 		git clone $1
		cd -
	else
		echo "  - $install_dir... OK!"
	fi
}

backup()
{
	echo "Backup old files"
	mkdir -p $home_dir/$backup_dir
	if [[ -f $home_dir/.vimrc ]]; then
		mv $home_dir/.vimrc $home_dir/$backup_dir/.vimrc
	fi
	if [[ -f $home_dir/.gitconfig ]]; then
		mv $home_dir/.gitconfig $home_dir/$backup_dir/.gitconfig
	fi
	if [[ -f $home_dir/.bashrc ]]; then
		mv $home_dir/.bashrc $home_dir/$backup_dir/.bashrc
	fi
}

vim_install()
{
	echo "Copying .vimrc"
	cp .vimrc $home_dir/.vimrc
	if [ ! -d ~/.vim ];then
		echo "Creating vim basic dirs"
		mkdir -p ~/.vim/autoload ~/.vim/bundle
	else
		echo "Vim basic dirs... OK!"
	fi
	if [ ! -e "~/.vim/autoload/pathogen.vim" ]; then
		echo "Installing Pathogen"
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	else
		echo "Pathogen... OK!"
	fi

	echo "Installing plugins:"
	git_install_package "https://github.com/jeetsukumaran/vim-filebeagle"
	git_install_package "https://github.com/itchyny/lightline.vim"
	git_install_package "https://github.com/octol/vim-cpp-enhanced-highlight"
	git_install_package "https://github.com/elzr/vim-json"
	git_install_package "https://github.com/vim-python/python-syntax"
	git_install_package "https://github.com/tpope/vim-markdown"
	git_install_package "https://github.com/nelstrom/vim-markdown-folding"
	git_install_package "https://github.com/stephpy/vim-yaml"
	git_install_package "https://github.com/vim-scripts/nginx.vim"
	git_install_package "https://github.com/pangloss/vim-javascript"
	git_install_package "https://github.com/martinda/Jenkinsfile-vim-syntax"
	git_install_package "https://github.com/lepture/vim-jinja"
	git_install_package "https://github.com/airblade/vim-gitgutter"
	git_install_package "https://github.com/nvie/vim-flake8"
	git_install_package "https://github.com/luochen1990/rainbow.git"
	git_install_package "https://github.com/fatih/vim-go"
	git_install_package "https://github.com/hashivim/vim-terraform"
	git_install_package "https://github.com/ntpeters/vim-better-whitespace.git"
	git_install_package "https://github.com/tomlion/vim-solidity"
	git_install_package "https://github.com/hed854/vim-vtc"
	git_install_package "https://github.com/fourjay/vim-hurl"

	echo "Installing themes:"
	git_install_package "https://github.com/morhetz/gruvbox"
	git_install_package "https://github.com/NLKNguyen/papercolor-theme"
	git_install_package "https://github.com/fcpg/vim-orbital"
}

bashrc_install()
{
	echo "Copying .bashrc"
	cp .bashrc $home_dir/.bashrc
	echo "Copying .bash_aliases"
	cp .bash_aliases $home_dir/.bash_aliases
}

git_install()
{
	echo "Copying .gitconfig"
	cp .gitconfig $home_dir/.gitconfig
}

backup
vim_install
bashrc_install
git_install $home_dir
