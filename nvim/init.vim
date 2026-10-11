call plug#begin()

Plug 'https://github.com/xiyaowong/transparent.nvim'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex', { 'tag': 'v2.15' }
Plug 'easymotion/vim-easymotion'
Plug 'bjarneo/pixel.nvim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'bakpakin/ats2.vim'

call plug#end()
colorscheme pixel 

let mapleader = " "
syntax enable

set number
filetype on

set winbar=%!lightline#statusline(0)
highlight! link WinBar StatusLine
set laststatus=0
set noruler
set statusline=

set nocompatible
set relativenumber

set ignorecase 
hi cErrInParen guifg=NONE guibg=NONE gui=NONE
hi cErrInBracket guifg=NONE guibg=NONE gui=NONE
hi cError guifg=NONE guibg=NONE gui=NONE
"lua require('smear_cursor').setup({
\cursor_color='#0000ff',
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
      \ 'colorscheme': 'simpleblack',
      \ }
let g:vimtex_version_check=0

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>


