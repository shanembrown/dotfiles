" +----------------+
" | BASIC SETTINGS | 
" +----------------+
syntax enable       " enable syntax highlighting
filetype on         " enable filetype detection
filetype plugin indent on         " enable filetype detection

set number          " set absolute and relative line numbers to enable hybrid line numbers
set relativenumber  " set absolute and relative line numbers to enable hybrid line numbers

set signcolumn=yes

set colorcolumn=80

set tabstop=4       " set tab width to 4 columns
set softtabstop=4   " set tab width to 4 columns
set shiftwidth=4    " set shift width to 4 spaces
set expandtab       " use space characters instead of tabs

set smartindent     " set smart indent true
set breakindent     " set line break at indent

set hlsearch        " enable search highlighting
set incsearch       " while searching through a file, incrementally highlight matching
set ignorecase      " ignore capital letters during search
set smartcase       " override ignorecase if searching for capital letters
set showmatch       " show matching words during a search


" +----------------+
" | REMAP SETTINGS |
" +----------------+
" set 'space' as the mapleader
nnoremap <SPACE> <Nop> 
let mapleader = " "

" set leader+pv to exit to netrw rather than the default ':Ex'
nnoremap <leader>pv :Ex<CR>

" set CTRL+D to always center on the screen 
nnoremap <C-d> <C-d>zz
" set CTRL+U to always center on the screen 
nnoremap <C-u> <C-u>zz

nnoremap <leader>js :%!jq

" +----------------+
" | NETRW SETTINGS |
" +----------------+
let g:netrw_banner=0 " remove the banner
let g:netrw_winsize=25 " set the winsize to 25 column width
let g:netrw_browse_split=0



" +-----------------+
" | FILE EXLORATION |
" +-----------------+
" netrw settings for file/directory exploration
" let g:netrw_banner = 0
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 25	
" let g:netrw_altv = 1
" let g:netrw_alto = 1 
" enable line numbering for netrw
" let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
" set 'ctrl + e' to Lexplore for quickly opening the file explorer
" map <silent> <C-E> :Lexplore<CR>

" split window navigation
" use ctrl-j; rather than using ctrl-w then j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" add CTRL+Y and CTRL+P to copy/paste externally
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

" +------------------+
" | FILETYPE HEADERS |
" +------------------+
"
augroup templates
  autocmd! BufNewFile *.sh execute "normal i#!/usr/bin/env bash\r\r"
  autocmd! BufNewFile *.zsh execute "normal i#!/bin/zsh\r\r"
  autocmd! BufNewFile *.plist execute "normal i<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version=\"1.0\">\r</plist>"
augroup END

let g:is_bash=1

" +---------+
" | PLUGINS |
" +---------+

" https://github.com/junegunn/vim-plug
" list plugins here between 'call_begin and call_end' 
call plug#begin()

Plug 'sainnhe/everforest'
Plug 'sheerun/vim-polyglot'

call plug#end()

" :PlugInstall to install the plugins
" :PlugUpdate to install or update the plugins
" :PlugDiff to review the changes from the last update
" :PlugClean to remove plugins no longer in the list

" +--------+
" | THEMES |
" +--------+

" everforest
" https://github.com/sainnhe/everforest/blob/master/doc/everforest.txt

" ensure termguicolors are set
if has('termguicolors')
  set termguicolors
endif

" set background: 'dark', 'light'
set background=dark

" set contrast: 'hard', 'medium'(default), 'soft'
" This configuration option should be placed before `colorscheme everforest`.
let g:everforest_background = 'soft'

" For better performance
let g:everforest_better_performance = 1

colorscheme everforest
