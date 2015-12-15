" General interface
set ruler
set nu

" Searching
set hlsearch
set ignorecase
set incsearch

" Indentation
filetype plugin indent on

" Colors
set t_Co=256
syntax enable
colorscheme elflord
set background=dark

" Log mode 
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %H:%M")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %H:%M")<CR>

" Buffer Switch
nnoremap <space>n :bn<CR>
nnoremap <space>b :bp<CR>

" Writing mode
func! WritingMode() 
	setlocal lbr
	map j gj
	map k gk
	setlocal wrap 
	syntax off
	"set synmaxcol=100
	"set lazyredraw
	"set filetype=markdown
	colorscheme 256-grayvim
	set foldcolumn=2
	set nonu
endfu 
com! WM call WritingMode()

" Pathogen
execute pathogen#infect()

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

"" Ftplugin
autocmd FileType php setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType ant setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType xml setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType cpp setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType json setlocal expandtab softtabstop=4 shiftwidth=4

"" Tab switch
nnoremap td :tabclose<CR>
nnoremap tn :tabnext<CR>
nnoremap tb :tabprevious<CR>
nnoremap tt :tabnew<CR>
