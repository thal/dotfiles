call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-grepper'
call plug#end()

command W wall

" Some sensible defaults
set number
set clipboard+=unnamedplus
set mouse=a
set tabstop=4
set shiftwidth=4
set expandtab
set splitright
set splitbelow
set background=dark
set ignorecase
set smartcase

" Make the Quickfix window more usable
noremap <C-n> :cn<CR>
noremap <C-m> :cp<CR>
noremap <C-q> :ccl<CR>

" Make splits more usable
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

augroup nerdtree
    autocmd!
    " Autostart NERDTree if vim is started with no arguments
    autocmd VimEnter * if argc() == 0 | NERDTree | endif
    " Switch to editor window after starting NERDTree
    autocmd VimEnter * wincmd p
augroup END

let NERDTreeShowHidden=1
let NERDTreeChDirMode=2

let mapleader = ","
" ,g: Search for a string
noremap <leader>g :Grepper -tool ag<CR>
" ,G: Search for a filename
noremap <leader>G :Grepper -tool ag -grepprg ag --vimgrep -g<CR>
" ,k: Search for the word under the cursor
noremap <leader>k :Grepper -tool ag -cword -noprompt<CR>
