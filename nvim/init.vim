call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'wadackel/vim-dogrun'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/xiyaowong/transparent.nvim'

call plug#end()

colorscheme dogrun

nnoremap <C-t> :NERDTreeToggle<CR>

lua <<EOF
require("transparent").setup({
  extra_groups = { -- Ничего тут не трогай нахуй оно тебе можёт всё сломать!!!!!!!!!
    "NormalFloat", 
    "NvimTreeNormal", 
  },
  exclude_groups = {}, 
})
EOF

lua <<EOF
vim.keymap.set('v', '<C-S-c>', '"+y', { noremap = true, silent = true })
EOF

autocmd BufNewFile,BufRead *.asm,*.nasm set filetype=nasm
autocmd FileType nasm setlocal tabstop=4
autocmd FileType nasm setlocal shiftwidth=4
autocmd FileType nasm setlocal expandtab
autocmd FileType nasm setlocal autoindent
autocmd FileType nasm setlocal smartindent
