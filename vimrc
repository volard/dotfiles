set nocompatible 
filetype off       
set number
set clipboard=unnamedplus
set encoding=utf-8
set background=dark
set smartindent
set nu
set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile
set incsearch
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set expandtab
set relativenumber
set smartindent
set nowrap
set smartcase

call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} 
Plug 'gruvbox-community/gruvbox'
Plug 'lyokha/vim-xkbswitch'

call plug#end()

colorscheme gruvbox
let mapleader = " "
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
inoremap <C-c> <esc>
set wrap linebreak nolist "переносит строчки не посимвольно, а по словам

" vim-xkbswitch plugin
" to properly install the plugin don't forget to install xkb-switch as well
"> add-apt-repository ppa:atareao/atareao
"> apt-get update
"> apt-get install xkb-switch -y

let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
let g:XkbSwitchNLayout = 'us'

map <F7> gg=G<C-o><C-o>


