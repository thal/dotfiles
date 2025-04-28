call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mfussenegger/nvim-dap'
call plug#end()

command W wall

" Some sensible defaults
set number
set clipboard+=unnamedplus
set mouse=niv
set tabstop=4
set shiftwidth=4
set expandtab
set splitright
set splitbelow
set background=dark
set ignorecase
set smartcase
set list
set wrap
set lbr
set sidescroll=5
set listchars+=precedes:<,extends:>

"colorscheme vim
"set notermguicolors
colorscheme evening
highlight NonText ctermbg=None guibg=None
highlight EndOfBuffer ctermbg=None guibg=None
highlight Normal ctermbg=None guibg=None
highlight NormalFloat ctermbg=235 guibg=Grey15
highlight Pmenu ctermbg=235 guibg=Grey15
highlight link SnippetTabstop Pmenu

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

" Open terminal with ,T
noremap <leader>T :botright terminal<CR>

let $EDITOR='nvr -cc split --nostart  --remote-wait +"set bufhidden=delete"'

" Open terminal with ,T
noremap <leader>T :split<CR><C-w>J10<C-w>_:terminal<CR>

autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd BufNewFile,BufRead wscript setlocal ft=python

lua <<EOF

local lspsetup = require('lspsetup')
local dapinit = require('dap-init')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
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


