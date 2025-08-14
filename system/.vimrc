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

" Use <leader>rc for "reload config"
nnoremap <leader>rc :source ~/.vimrc<CR>


" +------------+
" | STATUSLINE |
" +------------+
set laststatus=2
set statusline=%F%m%r%h%w     " Full path, modified flag, readonly, help, preview
set statusline+=%=            " Right align
set statusline+=\ %l          " Line
set statusline+=\ [%L]        " Total lines

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
augroup templates
  autocmd! BufNewFile *.sh execute "normal i#!/usr/bin/env bash\r\r"
  autocmd! BufNewFile *.zsh execute "normal i#!/bin/zsh\r\r"
  autocmd! BufNewFile *.plist execute "normal i<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version=\"1.0\">\r</plist>"
augroup END

let g:is_bash=1

" +---------------+
" | GLOW MARKDOWN |
" +---------------+
function! MarkdownVerticalPreview()
    write
    let filepath = expand('%:p')
    execute 'tabnew | terminal ++curwin glow --pager "' . filepath . '"'
    setlocal nonumber norelativenumber
    setlocal laststatus=0 noruler noshowcmd
    " Hide terminal-specific UI elements
    setlocal nomodeline
    setlocal bufhidden=wipe
    stopinsert
    normal! gg
endfunction

nnoremap <leader>md :call MarkdownVerticalPreview()<CR>

" +---------+
" | PLUGINS |
" +---------+
" https://github.com/junegunn/vim-plug
" Automatic installation of vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" list plugins here between 'call_begin and call_end' 
call plug#begin()

Plug 'sainnhe/everforest'         " color theme
Plug 'sheerun/vim-polyglot'       " syntax highlighting
Plug 'darfink/vim-plist'          " property list (.plist) file support
Plug 'ycm-core/YouCompleteMe'     " code completion

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


" +-----+
" | YCM |
" +-----+
" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']

" Don't ask about loading .ycm_extra_conf.py files
let g:ycm_confirm_extra_conf = 0

" Useful keybindings
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jr :YcmCompleter GoToReference<CR>
nnoremap <leader>jt :YcmCompleter GetType<CR>
nnoremap <leader>jf :YcmCompleter FixIt<CR>
