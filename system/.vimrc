" vimrc
" -- general -------------------------------------------------------------------
syntax enable                   " enable syntax highlighting
filetype on                     " enable filetype detection
filetype plugin indent on       " enable filetype detection

set relativenumber              " set absolute and relative line numbers to enable hybrid line numbers
set number                      " set absolute and relative line numbers to enable hybrid line numbers

set guicursor=                  " set block cursor
let &t_SI = "\e[2 q"            " insert mode - block
let &t_EI = "\e[2 q"            " normal mode - block
let &t_SR = "\e[2 q"            " replace mode - block

set signcolumn=yes              " display the column bar at 80 width
set colorcolumn=80

set tabstop=4                   " set tab width to 4 columns
set softtabstop=4               " set tab width to 4 columns
set shiftwidth=4                " set shift width to 4 spaces
set expandtab                   " use space characters instead of tabs

set smartindent                 " set smart indent true
set breakindent                 " set line break at indent

set hlsearch                    " enable search highlighting
set incsearch                   " while searching through a file, incrementally highlight matching
set ignorecase                  " ignore capital letters during search
set smartcase                   " override ignorecase if searching for capital letters
set showmatch                   " show matching words during a search

set clipboard=unnamedplus       " use system clipboard

" enable spell check for text (.txt) and markdown (.md) files
autocmd BufRead,BufNewFile *.txt,*.md setlocal spell spelllang=en_us


" -- statusline ---------------------------------------------------------------
set laststatus=2
set statusline=%F%m%r%h%w       " full path, modified flag, readonly, help, preview
set statusline+=%=              " right align
set statusline+=\ %l            " line
set statusline+=\ [%L]          " total lines


" -- remap ---------------------------------------------------------------------
" set 'space' as the mapleader
nnoremap <SPACE> <Nop> 
let mapleader = " " 

" Use 'rc' for 'reload config'
nnoremap <leader>rc :source ~/.vimrc<CR>

" keep the cursor at the beginning of the line when using 'J' to join a line
nnoremap J mzJ`z

" move selected lines up/down in Visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" set 'pv' to exit to netrw
nnoremap <leader>pv :Ex<CR>

" set 'CTRL+D to always center on the screen 
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" set 'js' to prettify JSON
nnoremap <leader>js :%!jq

" set 'f' to fzf (:GFiles)
nnoremap <leader>f :GFiles<Enter>

" set 'b' to fzf (:Buffers)
nnoremap <leader>b :Buffers<Enter>

" OS-specific clipboard mappings
if has('clipboard')
  " native clipboard support
  vnoremap <C-y> "+y
  nnoremap <C-y> "+yy
  nnoremap <C-p> "+p
  inoremap <C-p> <C-r>+
elseif executable('wl-copy')
  " Wayland clipboard provider
  vnoremap <C-y> :w !wl-copy<CR><CR>
  nnoremap <C-y> :.w !wl-copy<CR><CR>
  nnoremap <C-p> :r !wl-paste<CR>
  inoremap <C-p> <C-r> =system('wl-paste')<C-R>
endif

" insert current YYYY-MM-DD
nnoremap <leader>9 "=strftime('%Y-%m-%d')<CR>p



" -- netrw ---------------------------------------------------------------------
let g:netrw_banner=0                    " remove the banner
let g:netrw_winsize=25                  " set the winsize to 25 column width
let g:netrw_browse_split=0

" navigate splits using CTRL+[H, J, K, L]
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>


" filetype headers -------------------------------------------------------------
augroup templates
  autocmd! BufNewFile *.sh execute "normal i#!/usr/bin/env bash\r\r"
  autocmd! BufNewFile *.zsh execute "normal i#!/bin/zsh\r\r"
  autocmd! BufNewFile *.plist execute "normal i<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version=\"1.0\">\r</plist>"
augroup END

let g:is_bash=1

" show linenumbers in netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" glow markdown ----------------------------------------------------------------
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

" -- plugins -------------------------------------------------------------------
" https://github.com/junegunn/vim-plug
" Automatic installation of vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" list plugins here between 'call_begin and call_end' 
call plug#begin()

Plug 'catppuccin/vim', { 'as': 'catppuccin' }           " colorscheme
Plug 'sheerun/vim-polyglot'                             " syntax highlighting
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf in vim
Plug 'junegunn/fzf.vim'

call plug#end()

" USAGE
" :PlugInstall - install the plugins
" :PlugUpdate install or update the plugins
" :PlugDiff to review the changes from the last update
" :PlugClean to remove plugins no longer in the list

" -- themes --------------------------------------------------------------------
" ensure colors are set
set termguicolors

colorscheme catppuccin_frappe
