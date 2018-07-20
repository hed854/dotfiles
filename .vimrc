" General options
set encoding=utf-8
set ruler
set nu
set relativenumber
filetype plugin indent on

" Searching
set hlsearch
set ignorecase
set incsearch

" Pathogen
execute pathogen#infect()

" Colors
set t_Co=256
syntax enable
colorscheme PaperColor
set background=dark

" Log mode 
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %H:%M")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %H:%M")<CR>

" Buffer Switch
nnoremap <space>n :bn<CR>
nnoremap <space>b :bp<CR>

" Lightline
set laststatus=2

" Markdown folding
function! MarkdownLevel()
	if getline(v:lnum) =~ '^# .*$'
		return ">1"
	endif
	if getline(v:lnum) =~ '^## .*$'
		return ">2"
	endif
	if getline(v:lnum) =~ '^### .*$'
		return ">3"
	endif
	return "=" 
endfunction
au BufEnter *.markdown setlocal foldexpr=MarkdownLevel()  
au BufEnter *.markdown setlocal foldmethod=expr

"" Tab switch
nnoremap td :tabclose<CR>
nnoremap tn :tabnext<CR>
nnoremap tb :tabprevious<CR>
nnoremap tt :tabnew<CR>

"" leader remap
let mapleader = " "

"" center search
nnoremap n nzz
nnoremap N Nzz

"" sort visual selection
vnoremap <leader>s :sort u<cr>
vnoremap <leader>S :sort! u<cr>

"" Gvim
set guifont=Droid_Sans_Mono:h10:cANSI
set backspace=2

"" webpack reloading
set backupcopy=yes
set noswapfile
