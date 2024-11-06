" enable syntax highlighting 
syntax enable

" enable line numbers
set number

" set listchars: tab = ▸; end-of-line = ¬; trail= ·
set listchars=eol:¬,tab:▸-,space:·

" set relative/absolute auto-toggle for line numbers based on Insert
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" enable search highlighting
set hlsearch
" set line break at indent
set breakindent


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

" add headers to filetypes
augroup templates
  autocmd! BufNewFile *.sh execute "normal i#!/usr/bin/env bash\r\r"
  autocmd! BufNewFile *.zsh execute "normal i#!/bin/zsh\r\r"
  autocmd! BufNewFile *.plist execute "normal i<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version=\"1.0\">\r</plist>"
augroup END

" auto-install vim-plug 
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" PLUGINS
" https://github.com/junegunn/vim-plug

call plug#begin()

" List your plugins here
Plug 'Plug 'sainnhe/everforest''

call plug#end()

" CONFIGURE EVERFOREST
" https://github.com/sainnhe/everforest/blob/master/doc/everforest.txt

" ensure termguicolors are set
        if has('termguicolors')
          set termguicolors
        endif

        " For dark version.
        set background=dark

        " Set contrast.
        " This configuration option should be placed before `colorscheme everforest`.
        " Available values: 'hard', 'medium'(default), 'soft'
        let g:everforest_background = 'soft'

        " For better performance
        let g:everforest_better_performance = 1

        colorscheme everforest
