" <c-del> not working.
if $TERM == 'linux'
    " In VT
    inoremap [3~ <C-\><C-o>dw
else
    " Should work outside VT
    "inoremap <C-Del> <C-\><C-O>dw
    inoremap [3;5~ <C-\><C-o>dw
endif

" New line before/after paragraph:
" Disabled due to buggy direction keys.
"nnoremap o }O
"nnoremap O {o

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
    " Causing issues, needing extra ESCs
    "nnoremap j :m .+1<CR>
    "nnoremap k :m .-2<CR>
    "nnoremap h <<
    "nnoremap l >>
    "inoremap j <Esc>:m .+1<CR>gi
    "inoremap k <Esc>:m .-2<CR>gi
    "xnoremap j :m '>+1<CR>gv=gv
    "xnoremap k :m '<-2<CR>gv=gv
    "xnoremap h <gv
    "xnoremap l >gv
    " Not working
    "nnoremap <A-j> :m .+1<CR>
    "nnoremap <A-k> :m .-2<CR>
    "nnoremap <a-h> <<
    "nnoremap <a-l> >>
    "inoremap <A-j> <Esc>:m .+1<CR>gi
    "inoremap <A-k> <Esc>:m .-2<CR>gi
    "xnoremap <A-j> :m '>+1<CR>gv=gv
    "xnoremap <A-k> :m '<-2<CR>gv=gv
    "xnoremap <a-h> <gv
    "xnoremap <a-l> >gv
endif

" ------
" Saving
" ------
" Write the file when you opened it without root privileges.
" :w!!
cmap w!! w !sudo tee % > /dev/null

" Save if needed. Requires for terminal:
" alias vim="stty stop '' -ixoff ; vim"
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

