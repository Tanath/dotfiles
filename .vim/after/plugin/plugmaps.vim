" Plugins
" -------
" junegunn/fzf.vim
if exists(':FZF')
    " vim-fzf-git
    nmap <unique><silent> <leader>ff :FZF<cr>
    " fzf buffers
    nmap <unique><silent> gb :Buffers<cr>
    " fzf silver searcher
    nmap <leader>a :Ag<space>
    " fzf git commits
    nmap <leader>fc :Commits<cr>
    " fzf mappings
    nmap <leader>fm :Maps<cr>
    " fzf mappings
    nmap <leader>ft :Tags<cr>
    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)
else
    nmap <unique><silent> gb :b<Space><c-d>
    nmap <unique><silent> <leader>a :grep<space><c-d>
    nmap <leader>fm :map<cr>
endif

" tpope/vim-eunuch
if exists(':SudoWrite')
    nnoremap <leader>S :SudoWrite<cr>
endif

" tpope/fugitive
if exists(':Gstatus')
    nnoremap <leader>gs :Gstatus<cr>
    nnoremap <leader>gbl :Gblame<cr>
    nnoremap <leader>gc :Gcommit<cr>
    nnoremap <leader>gpl :Gpull<cr>
    nnoremap <leader>gps :Gpush<cr>
    nnoremap <leader>gmr :Gmerge<cr>
    nnoremap <leader>gmv :Gmove<cr>
endif

" tpope/vim-dispatch
if exists(':Make')
    nnoremap <leader>m :update <bar> Make<cr>
else
    nnoremap <leader>m :update <bar> make<cr>
endif

" scrooloose/nerdtree
if exists(':NERDTree')
    nnoremap <leader>nn :NERDTreeToggle<cr>
endif

"map <unique> <leader>td <Plug>TaskList
let g:pep8_map='<leader>8'

