" Plugins
" -------
" junegunn/vim-plug
if exists(':Plug')
    nnoremap <leader>pu :PlugUpdate<cr>
    nnoremap <leader>pU :PlugUpgrade<cr>
    nnoremap <leader>ps :PlugStatus<cr>
    nnoremap <leader>pd :PlugDiff<cr>
    nnoremap <leader>pi :PlugInstall<cr>
endif

" junegunn/fzf.vim
if exists(':FZF')
    " vim-fzf-git
    nnoremap <unique><silent> <leader>ff :FZF<cr>
    " fzf buffers
    nnoremap <unique><silent> gb :Buffers<cr>
    " fzf silver searcher
    nnoremap <leader>fa :Ag<space>
    " fzf git commits
    nnoremap <leader>gc :Commits<cr>
    " fzf mappings
    nnoremap <leader>km :Maps<cr>
    " fzf tags
    nnoremap <leader>ft :Tags<cr>
    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)
else
    nnoremap <unique><silent> <leader>ff :find<space><cr>
    nnoremap <unique><silent> gb :b<Space><c-d>
    nnoremap <unique><silent> <leader>a :grep<space><c-d>
endif

" tpope/vim-eunuch
if exists(':SudoWrite')
    nnoremap <leader>S :SudoWrite<cr>
    nnoremap <leader>fr :Rename<space>
    nnoremap <leader>fm :Move<space>
    nnoremap <leader>fD :Delete
    nnoremap <leader>fl :Llocate<space>
endif

" unblevable/quick-scope
if exists(':QuickScopeToggle')
    nnoremap <leader><F3> :QuickScopeToggle<cr>
endif

" godlygeek/tabular
if exists(":Tabularize")
    nnoremap <Leader>a= :Tabularize /=<CR>
    vnoremap <Leader>a= :Tabularize /=<CR>
    nnoremap <Leader>ap :Tabularize /<bar><CR>
    vnoremap <Leader>ap :Tabularize /<bar><CR>
    nnoremap <Leader>a: :Tabularize /:\zs<CR>
    vnoremap <Leader>a: :Tabularize /:\zs<CR>
    " Buggy mapping.
    "inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
    " Auto-align pipe tables in insert mode.
    "function! s:align()
    "    let p = '^\s*|\s.*\s|\s*$'
    "    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    "        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    "        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    "        Tabularize/|/l1
    "        normal! 0
    "        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    "    endif
    "endfunction
endif

" tpope/vim-fugitive
if exists(':Gstatus')
    nnoremap <leader>gs :Gstatus<cr>
    nnoremap <leader>gbl :Gblame<cr>
    nnoremap <leader>gco :Gcommit<cr>
    nnoremap <leader>gpl :Gpull<cr>
    nnoremap <leader>gps :Gpush<cr>
    nnoremap <leader>gmr :Gmerge<cr>
    nnoremap <leader>gmv :Gmove<cr>
    autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" tpope/vim-dispatch
if exists(':Make')
    nnoremap <leader>m :update <bar> Make<cr>
else
    nnoremap <leader>m :update <bar> make<cr>
endif

" janko/vim-test
if exists(':TestFile')
    " By default all runners are loaded.
    let test#enabled_runners = ['python#unittest', 'python#pytest', 'python#djangotest']
    " Runners available: 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose' and Python's built-in 'unittest'
    let test#python#runner = 'pytest'
    " Make test commands execute using dispatch.vim
    "let test#strategy = 'dispatch'
    " Don't let testers clear terminal.
    let g:test#preserve_screen = 1
    " Uses CWD as project root by default.
    "let test#project_root = '/path/to/your/project'
    " Auto-run when test file is saved.
    augroup test
        autocmd!
        autocmd BufWrite * if test#exists() |
            \   TestFile |
            \ endif
    augroup END
endif

" scrooloose/nerdtree
if exists(':NERDTree')
    nnoremap <leader>nn :NERDTreeToggle<cr>
endif

"map <unique> <leader>td <Plug>TaskList
let g:pep8_map='<leader>8'

