call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-grepper'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter',{'do': ':TSUpdate'}
call plug#end()

"TODO: Adapt all this to lua
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
set title
set list
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
set completeopt-=preview

" Make the Quickfix window more usable
noremap <C-n> :cn<CR>
noremap <C-m> :cp<CR>
noremap <C-q> :ccl<CR>

" Make splits more usable
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" noremap <C-w> <C-w>q

" Use same navigation commands in terminal windows
" (means terminal won't receive Ctrl-HJKL, but oh well)
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" Disable line numbers in terminal windows
au TermOpen * setlocal nonumber
" Keep terminal windows in insert mode by default
au TermOpen,WinEnter term://* startinsert
" Esc in terminal to go to normal mode
tnoremap <Esc> <C-\><C-n>

autocmd Bufenter * if &buftype == 'terminal' | set nonumber | endif

" Make
map <F9> :make<CR>

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

lua << EOF
-- Plugin-specific config broken out into separate lua files
local init2 = require('lspconfig-init')


-- Tree Sitter
require'nvim-treesitter.configs'.setup {
--  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}

EOF
