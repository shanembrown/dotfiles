" enable syntax highlighting 
syntax enable

" enable line numbers
set number

" set listchars: tab = ▸; end-of-line = ¬; trail= ·
set listchars=eol:¬,tab:▸-,space:·

" using autocommand for tiletype indentation
autocmd FileType markdown setlocal tabstop=2 shiftwidth=4 softtabstop=4 expandtab

" " set relative/absolute auto-toggle for line numbers based on Insert
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
