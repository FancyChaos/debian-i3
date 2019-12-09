call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/itchyny/calendar.vim'
call plug#end()

let g:deoplete#enable_at_startup = 1

map <C-n> :NERDTreeToggle<CR>
