call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'wadackel/vim-dogrun'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/xiyaowong/transparent.nvim'

call plug#end()

nnoremap <C-t> :NERDTreeToggle<CR>

colorscheme dogrun

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

