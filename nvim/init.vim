call plug#begin()

Plug 'https://github.com/xiyaowong/transparent.nvim'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'

call plug#end()

set number
set relativenumber

nnoremap <ESC><ESC> :nohlsearch<CR>

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
