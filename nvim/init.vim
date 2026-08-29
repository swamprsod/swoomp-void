call plug#begin()

Plug 'https://github.com/xiyaowong/transparent.nvim'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'easymotion/vim-easymotion'
Plug 'bjarneo/pixel.nvim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'sphamba/smear-cursor.nvim'

call plug#end()
colorscheme pixel 

let mapleader = " "
syntax enable

set number
filetype on

set nocompatible
set relativenumber
set ruler

set ignorecase 

lua require('smear_cursor').setup({
    \cursor_color = '#ffffff',
\})


nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap <Leader>j 10j
nmap <Leader><Leader>f <Plug>(easymotion-bd-w)

lua <<EOF
require("transparent").setup({
  extra_groups={ 
    "NormalFloat", 
    "NvimTreeNormal", 
  },
  exclude_groups={}, 
})
EOF
set noshowmode
let g:vimtex_view_method= 'zathura'

autocmd BufNewFile,BufRead *.asm,*.nasm set filetype=nasm


let g:lightline={
      \ 'colorscheme': 'molokai',
      \ }

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
