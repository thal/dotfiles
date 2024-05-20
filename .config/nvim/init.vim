call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
set list
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
set completeopt-=preview

colorscheme evening
highlight NonText guibg=None
highlight EndOfBuffer guibg=None
highlight Normal guibg=None

" Make the Quickfix window more usable
" Next result
nnoremap <C-n> <Cmd>cn<CR>
" Previous result
nnoremap <C-p> <Cmd>cp<CR>
" Close quickfix
" noremap <C-q> <Cmd>ccl<CR>

noremap <C-_> <Cmd>noh<CR>
" Make splits more usable
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-t> <C-w>t
set noequalalways

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

" TODO: look into termdebug plugin

" augroup nerdtree
"     autocmd!
"     " Autostart NERDTree if vim is started with no arguments
"     autocmd VimEnter * if argc() == 0 | NERDTree | endif
"     " Switch to editor window after starting NERDTree
"     autocmd VimEnter * wincmd p
"     " Automatically find opened files in nerdtree
"     "autocmd BufEnter,BufNew * if &buftype == '' | NERDTreeFind | endif
" augroup END

" autocmd Bufenter * if &buftype == 'terminal' | set nonumber | endif

let NERDTreeShowHidden=1
let NERDTreeChDirMode=2

set title

let mapleader = ","

" Commands from fzf.vim
let g:fzf_vim = {}
noremap<C-b> :Buffers<CR>
noremap<C-f> :Files<CR>
noremap<C-g> :Ag<CR>
let g:fzf_vim.listproc_ag = { list -> fzf#vim#listproc#quickfix(list) }
let g:fzf_vim.listproc_files = { list -> fzf#vim#listproc#quickfix(list) }
"" Disable Ex mode
noremap Q <Nop>

noremap <F12> :echo luaeval("require'nvim-treesitter'.statusline()")<CR>

if has('nvim')
    let $GIT_EDITOR='nvr -cc split --remote-wait'
endif
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" Open terminal with ,T
noremap <leader>T :botright terminal<CR>

" ,, for omnifunc completion
inoremap <leader>, <c-x><c-o>

lua <<EOF

local lspconfiginit = require('lspconfig-init')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    --disable = { "c","cpp" },
    disable = {},
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.lsp.set_log_level("off")
EOF
