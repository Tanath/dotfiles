" ========
" Mappings
" ========

" Set <leader> to space, consistent with spacemacs/spacevim.
" Disabled due to insert-mode issues.
"let mapleader = " "
"let maplocalleader = " "
"nnoremap <SPACE> <Nop>

" -----
" Misc.
" -----
" Toggle folds, tab like spacemacs/spacevim.
nnoremap <tab> za
" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F1> :help <C-R><C-W><CR>
nmap <F3> :grep<space>
nmap <F10> :term<CR>

" <c-del> not working.
if $TERM == 'linux'
    " In VT
    inoremap [3~ <C-\><C-o>dw
else
    " Should work outside VT
    "inoremap <C-Del> <C-\><C-O>dw
    inoremap [3;5~ <C-\><C-o>dw
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" Quick yank/paste
set pastetoggle=<F2>
vnoremap <M-y> "+y
vnoremap <Leader>y "+y
vnoremap <Leader>Y "*y
nnoremap <M-p> "+p
nnoremap <Leader>p "+p
nnoremap <Leader>P "*p
nnoremap Y y$

" New line before/after paragraph:
" Disabled due to buggy direction keys.
"nnoremap o }O
"nnoremap O {o

" Retain selection when changing indent level
xnoremap < <gv
xnoremap > >gv

" Alt-up/down/left/right to move lines:
if $TERM == 'linux'
    " In VT
    nnoremap [A :m .-2<CR>
    nnoremap [B :m .+1<CR>
    nnoremap [C >>
    nnoremap [D <<
    vnoremap [A :m '<-2<CR>gv=gv
    vnoremap [B :m '>+1<CR>gv=gv
    xnoremap [C >gv
    xnoremap [D <gv
else
    " Elsewhere
    nnoremap [1;3B :m .+1<CR>
    nnoremap [1;3A :m .-2<CR>
    nnoremap [1;3D <<
    nnoremap [1;3C >>
    vnoremap [1;3B :m '>+1<CR>gv=gv
    vnoremap [1;3A :m '<-2<CR>gv=gv
    xnoremap [1;3D <gv
    xnoremap [1;3C >gv
    " Enabling these two makes you need to ESC twice to ESC insert-mode.
    "inoremap [1;3B <C-o>:m .+1<CR>
    "inoremap [1;3A <C-o>:m .-2<CR>
endif

" Alt-h/j/k/l to move lines:
if $TERM == 'linux'
    " No VT versions yet.
else
    " Should work outside VT
    nnoremap <A-j> :m .+1<CR>
    nnoremap <A-k> :m .-2<CR>
    nnoremap <a-h> <<
    nnoremap <a-l> >>
    inoremap <A-j> <Esc>:m .+1<CR>gi
    inoremap <A-k> <Esc>:m .-2<CR>gi
    xnoremap <A-j> :m '>+1<CR>gv=gv
    xnoremap <A-k> :m '<-2<CR>gv=gv
    xnoremap <a-h> <gv
    xnoremap <a-l> >gv
endif

" Table (column) align
vmap <leader>ca :!column -t<cr>
vmap <leader>ta :!column -to<bslash><bar> -s<bslash><bar><cr>

" -------
" Plugins
" -------
" fzf stuff https://github.com/junegunn/fzf.vim
nmap <leader>ff :FZF<cr>     " vim-fzf-git
nmap <leader>b :Buffers<cr>  " fzf buffers
" fzf silver searcher
nmap <leader>a :Ag<space>
nmap <leader>fc :Commits<cr> " fzf git commits
nmap <leader>fm :Maps<cr>    " fzf mappings
nmap <leader>ft :Tags<cr>    " fzf mappings
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"map <leader>td <Plug>TaskList
let g:pep8_map='<leader>8'

" =======
" Buffers
" =======
set hidden                          " Let you switch buffers without saving current. Don't mark buffers as abandoned if hidden.
set confirm                         " Prompt to save unsaved changes when exiting
" New buffer
nnoremap <leader>n :enew<CR>
" Delete buffer
nnoremap <leader>d :bd<CR>
" Cycle through buffers, tabs:
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>
" Switch to previous-viewed buffer
nnoremap <Bslash><Bslash> <C-^>

" ---------------------
" Navigation in buffer.
" ---------------------
" Up/down by row instead of line:
nnoremap j gj
nnoremap k gk

" Quickfix/errors
nnoremap ]] :cnext<cr>zz
nnoremap [[ :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ------
" Saving
" ------
" :w!!
" Write the file when you opened it without root privileges.
cmap w!! w !sudo tee % > /dev/null
" Use eunuch by tpope.
nnoremap <F5> :SudoWrite<cr>

" Save if needed. Requires for terminal: alias vim="stty stop '' -ixoff ; vim"
" If terminal freezes, hit <c-q> to resume.
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <c-o><c-s>
" For when <c-s> doesn't work
nnoremap <leader>s :update<cr>
vmap <leader>s <Esc>:update<cr>gv

" Save session
"nmap <c-S> :mks! ~/.vim/sessions/session.vim<CR>
"vmap <c-S> <Esc><c-S>gv
"imap <c-S> <c-o><c-S>

