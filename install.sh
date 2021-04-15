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

# Parameter: keyboard type (optional)
if [ -z $2 ]; then
	keyboard_type="iso_tkl"
else
	case $2 in
		"ansi") keyboard_type="ansi" ;;
		"iso_tkl") keyboard_type="iso_tkl" ;;
		*) echo "Invalid keyboard type"; exit 1 ;;
	esac
fi
echo "Set keyboard type: $keyboard_type"

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

generate_xmodmap()
{
	xmodmap_file=$home_dir/xmodmap.conf
	# keycode: run `showkey` in a virtual console
	# keysym: http://wiki.linuxquestions.org/wiki/List_of_Keysyms_Recognised_by_Xmodmap
	# debug mapping: xmodmap -pke
	MAP_ANSI=(
		"keycode 100 = less NoSymbol"
		"keycode 101 = greater NoSymbol"
	)
	MAP_ISO_TKL=(
		"keycode 24 = a A NoSymbol NoSymbol aring Aring"
	)
	case $1 in
		"ansi") map=$MAP_ANSI ;;
		"iso_tkl") map=$MAP_ISO_TKL ;;
	esac

	echo "" > $xmodmap_file
	for i in "${map[@]}"; do
		echo "$i" >> $xmodmap_file

	done
	echo "Generated $xmodmap_file, apply manually (for now)"

}

generate_xmodmap $keyboard_type
backup
vim_install
bashrc_install
git_install $home_dir
