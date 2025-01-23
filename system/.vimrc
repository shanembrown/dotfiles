" +----------------+
" | BASIC SETTINGS | 
" +----------------+
" enable syntax highlighting
syntax enable
" enable line numbers
set number
" enable search highlighting
set hlsearch
" set line break at indent
set breakindent
" enable filetype detection
filetype on
" set shift width to 4 spaces
set shiftwidth=4
" set tab width to 4 columns
set tabstop=4
" use space characters instead of tabs
set expandtab

" set relative/absolute auto-toggle for line numbers based on Insert
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END


" +-----------------+
" | FILE EXLORATION |
" +-----------------+
" netrw settings for file/directory exploration
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25	
let g:netrw_altv = 1
let g:netrw_alto = 1 
" enable line numbering for netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
" set 'ctrl + e' to Lexplore for quickly opening the file explorer
map <silent> <C-E> :Lexplore<CR>

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

" +---------+
" | PLUGINS |
" +---------+

" auto-install vim-plug 
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" list plugins here between 'call_begin and call_end' 
call plug#begin()

Plug 'sainnhe/everforest'

call plug#end()

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
