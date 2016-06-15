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

" Pathogen
execute pathogen#infect()

" Lightline
set laststatus=2

"" Ftplugin
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType php setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType ant setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType xml setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType cpp setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType json setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType python setlocal expandtab softtabstop=4 shiftwidth=4
autocmd FileType html setlocal expandtab softtabstop=4 shiftwidth=4
let python_highlight_all = 1

"" Tab switch
nnoremap td :tabclose<CR>
nnoremap tn :tabnext<CR>
nnoremap tb :tabprevious<CR>
nnoremap tt :tabnew<CR>

"" Gvim
set guifont=Droid_Sans_Mono:h10:cANSI
set backspace=2

"" elzr/json conceal disable
let g:vim_json_syntax_conceal = 0
