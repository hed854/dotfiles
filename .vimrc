" General options
set encoding=utf-8
set ruler
set nu
set relativenumber
filetype plugin indent on
let mapleader="\<Space>"

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
nnoremap <leader>n :bn<CR>
nnoremap <leader>b :bp<CR>

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

" Lint jenkinsfile
:command Jenkinslint :!http --form POST http://jenkins.devnvm.private.francemm.com/pipeline-model-converter/validate jenkinsfile=@%



" Markdown filetype
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Ngnix filetype
autocmd BufNewFile,BufreadPost /etc/nginx/*,/usr/local/nginx/conf/* set filetype=nginx

"" Ftplugin
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType php setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType ant setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType xml setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType cpp setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType json setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType python setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType html setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType markdown setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType javascript setlocal expandtab softtabstop=2 shiftwidth=2
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

let python_highlight_all = 1

let g:terraform_align=1

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

"" elzr/json conceal disable
let g:vim_json_syntax_conceal = 0

"" rainbow disabled at start
let g:rainbow_active = 0

"" webpack reloading
set backupcopy=yes
set noswapfile

"" vim-go config
let g:go_highlight_types = 1
autocmd FileType go nmap <leader>e  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
