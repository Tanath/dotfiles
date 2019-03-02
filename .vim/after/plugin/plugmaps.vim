" -------
" Plugins
" -------
if exists(':FZF')
    " fzf stuff https://github.com/junegunn/fzf.vim
    " vim-fzf-git
    nmap <unique> <leader>ff :FZF<cr>
    " fzf buffers
    nmap <unique> <leader>b :Buffers<cr>
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
    nmap <unique> <leader>b :buffers<cr>
    nmap <unique> <leader>a :grep<space>
endif

"map <unique> <leader>td <Plug>TaskList
let g:pep8_map='<leader>8'

if exists(':SudoWrite')
    " Use eunuch by tpope.
    nnoremap <leader>S :SudoWrite<cr>
endif
