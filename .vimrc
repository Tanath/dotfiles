" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

"set shell=/bin/zsh\ -i
set shcf=-c

" Misc basics
" ===========
" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
" Use UTF-8 if we can and env LANG didn't tell us not to
if has('multi_byte') && !exists('$LANG') && &encoding ==# 'latin1'
  set encoding=utf-8
endif
set modelines=0                        " Prevent some security issues (settings options by buffer content)
set ttyfast                            " Indicates a fast terminal connection.
set notimeout ttimeout ttimeoutlen=200 " Quickly time out on keycodes, but never time out on mappings
set nosol                              " No start of line jump when selecting.
silent! set cm=blowfish2
" Automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =
set showmatch                          " When a bracket is inserted, briefly jump to the matching
                                       " one. Only done if the match is on the screen.
set matchtime=4                        " The timing can be set with 'matchtime'.
" Add suffixes to check for gf.
set suffixesadd+='.md','.wiki'
set confirm                            " Prompt instead of just rejecting risky :write, :saveas
                                       " In vim-tiny but not NeoVim, so just suppress errors
set include=                           " Don't assume editing C; let the filetype set this
set nrformats-=octal                   " Treat numbers with leading 0 as decimal, not octal
set path+=**                           " Search under cwd.

" Language, spelling.
" Set language from user's environment.
" TODO: Support multiple comma-separated langs.
let g:lang=tolower(split(expand($LANG), '\.')[0])
let &spelllang=g:lang
let &langmenu=g:lang
set spell spellsuggest=best
map <F7> :setl spell! \| let &spelllang=g:lang<CR>
" Quick spelling fixes.
nmap <leader>1 1z=
nmap <leader>2 2z=

" Remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
if has('viminfo')
    set viminfo='15,\"100,:30,%,n~/.viminfo
endif
" TODO Saving/restoring folds not working.
set viewoptions=folds,cursor           " Save fold state and cursor
au BufRead * loadview
au BufWrite * mkview

" :h sessionoptions
"if exists('+sessionoptions')
"    set sessionoptions-=blank,buffers,options,localoptions
"endif

" Backup, swap, undo files
if !isdirectory($HOME . ".vim")        " Create vim dirs if missing
	silent !mkdir -p ~/.vim/cache/{backup,view} > /dev/null 2>&1
	silent !mkdir -p ~/.vim/cache/undo > /dev/null 2>&1
	silent !mkdir -p ~/.vim/pack/plugins/{start,opt} > /dev/null 2>&1
endif
set backup
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/cache/undo//
    if has('win32') || has('win64')
        set undodir-=~/.vim/cache/undo//
        set undodir^=~/vimfiles/cache/undo//
    endif
endif
set backupdir=$HOME/.vim/cache/backup// " For backup files
set directory=$HOME/.vim/cache/backup// " For .swp files
if has('win32') || has('win64')
    set backupdir-=~/.vim/cache/backup//
    set backupdir^=~/vimfiles/cache/backup//
endif
set backupskip=/tmp/*                  " Add some paths not to back up
set backupskip^=/dev/shm/*             " Shared memory RAM disk
set backupskip^=/var/tmp/*             " Debian's $TMPDIR for sudoedit(8)
if !has('unix')
  set backupskip-=/dev/shm/*
  set backupskip-=/var/tmp/*
endif
set history=2000
set undolevels=2000                    " Number of undos
set undoreload=10000                   " Number of lines to save for undo

" Searching
set ignorecase						   " do case insensitive matching
set smartcase						   " overrides ignorecase if uppercase used in search string
set incsearch						   " Incremental search as you type.
set wrapscan						   " jumps to the beginning if reaching end, and viceversa
" To toggle search highlight: C-/ in terminal, C-_ in gvim. C-7 also works?
nnoremap <C-_> :set hlsearch! hlsearch?<CR>

" Auto-formatting
" TODO Test in au bufread to restore after .md format changes.
set formatoptions=ncroql              " How automatic formatting works. See :h fo-table
if v:version + has('patch541') >= 704
  set formatoptions+=j
endif
"au bufread *.md set formatoptions=want " Attempt markdown list behaviour
" Make sure *.md is seen as markdown.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" TODO Test md fenced code block syntax:
"let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" Wrapping
set textwidth=80
set wrap linebreak                    " Linebreaks at word boundaries.
" Toggle wrap.
nnoremap <F4> :set wrap! wrap?<cr>

" Indenting.
set autoindent                         " Copy indent from current line when starting a new line
"set nostartofline                     " Emulate typical editor navigation behaviour
silent! set breakindent                " Indent wrapped lines

" Tabbing, backspace
set tabstop=4 softtabstop=4
set shiftwidth=4                       " Number of spaces to use for (auto)indenting.
set expandtab                          " Expand tabs & indents to spaces. <C-v><tab> to not.
set smarttab                           " <Tab> at start of a line puts spaces. <BS> deletes
                                       " 'shiftwidth' spaces.
set backspace=2                        " Influences <BS>, <Del>, CTRL-W and CTRL-U in insert mode.
set backspace=indent,eol,start         " Better handling of <BS>

" Interface
" =========
if has('mouse')
	set mouse=a                        " Enable the use of the mouse (all modes).
endif
set visualbell                         " Flash instead of beep
"set t_vb=                              " Disable even the flashing
set splitright                         " Vertical splits use right half of screen
set splitbelow                         " Horizontal splits use bottom half of screen

" More 'list' display characters
set listchars+=extends:>               " Unwrapped text to screen right
set listchars+=precedes:<              " Unwrapped text to screen left
set listchars+=tab:>-                  " Tab characters, preserve width
set listchars+=trail:_                 " Trailing spaces
silent! set listchars+=nbsp:+          " Non-breaking spaces

" Theme/colours, syntax
" Switch syntax highlighting on, when the terminal has colours.
" Also switch on highlighting the last used search pattern.
if has('syntax')
    " Handled by vim-plug. Not needed: Use syntax Highlighting
    "if !exists('g:syntax_on')
    "    " Keeps current colour settings. 'on' overrules with defaults.
    "    syntax enable
    "endif
    if &t_Co > 2 || has("gui_running")
        set hlsearch
    endif
    if !exists('g:colors_name')
        set background=dark
        colors elflord
    endif
    " Toggle highlighting column 80:
    nmap <F9> :if &cc != 80 \| setl cc=80 cc? \| else \| setl cc& cc? \| endif<cr>
endif

" Status/Command line
set showcmd                            " Show (partial) command in status line.
set showmode
set wildmenu
"set wildmode=longest,list,full         " Complete longest common string, then list alternatives, then select the sortest first
set wildmode=list:longest,list:full    " Complete longest common string, then list alternatives, then select the sortest first
silent! set wildignorecase             " Case insensitive, if supported
set laststatus=2                       " Always show status line
set cmdheight=2                        " Prevent 'Press Enter' messages
" Show more info in status line if airline isn't available.
set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]
" Configure Airline:
"let g:airline_powerline_fonts = 1
" :h airline-extensions
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#ale#enabled = 1
"let g:airline#extensions#virtualenv#enabled = 1
" Airline extension opt-in:
"let g:airline_extensions = ['branch', 'syntastic', 'fugitiveline']

" Line numbers, cursor
setg number                            " Show line numbers.
setg relativenumber                    " Show relative line numbers.
setg scrolloff=2                       " Keep cursor # lines from top/bottom.
set cursorline                         " Underline line with cursor
set ruler                              " Show the line and column number of the cursor position,
                                       " separated by a comma.
" Cycle line numbering types:
nnoremap <leader>N :exe 'set nu!' &nu ? 'rnu!' : ''<cr>

" Folding
" Fold based on indent, but only when I ask
if has('folding')
    set foldenable
    set foldlevel=99
    set foldlevelstart=1               " Start with folds open/closed/some, 99/0/1
    set foldnestmax=10                 " Max depth 10
    "set foldmethod=syntax
    "set foldcolumn=2
    " Allow conceal, but not if the cursor is on the line
    set conceallevel=2
    set concealcursor=
    let g:vimwiki_folding='syntax'
endif
"Indent w/manual folds:
"augroup vimrc
"  au BufReadPre * setl foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setl foldmethod=manual | endif
"augroup END

" GUI options
" -----------
set guioptions=
set guioptions+=a                      " Automatically make visual selection available in system clipboard
set guioptions+=A                      " Same for modeless selection
set guioptions+=e                      " GUI tabs
set guioptions+=g                      " Grayed-out menu items that aren't active
set guioptions+=i                      " Use a Vim icon
set guioptions+=m                      " Show the menu bar
set guicursor+=a:blinkon0              " Don't blink the cursor
set mousehide                          " Hide the mouse while typing
set winaltkeys=no                      " Don't use ALT to access the menu
" Set font for gvim if running.
if has('gui_running')
	set guifont=Noto\ Mono\ 9
endif
set termguicolors

" Mappings
" ========
"let mapleader = " "
"let maplocalleader = " "
"nnoremap <SPACE> <Nop>

" Misc mappings.
" -----
" Up/down by row instead of line:
nnoremap j gj
nnoremap k gk
" Toggle folds, tab like spacemacs/spacevim.
nnoremap <tab> za
" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F1> :help <C-R><C-W><CR>
" control + space in terminal hack
"map <C-@> <C-Space>
"imap <C-@> <C-Space>
nmap <F3> :grep<space>
nmap <F10> :terminal<CR>
nnoremap <leader>m :make<cr>
" FIXME: Places an error msg over cursor line until line change.
" Or hides vim until user input.
"nnoremap <silent> <F6> :!xdg-open<space><c-r><c-p><cr>
nnoremap <leader>R :<C-U>source $MYVIMRC<CR>
if exists("*strftime")
    nmap <F8> i<c-r>=strftime('%c')<cr><esc>
    imap <F8> <c-r>=strftime('%c')<cr>
endif
" Don't use Ex mode, use Q for formatting
map Q gq

" Quick yank/paste
set pastetoggle=<F2>
" Alt+y
if !has('gui_running')
    map y <A-y>
endif
"vmap <A-y> "+ygv
vnoremap <Leader>y "+ygv
vnoremap <Leader>Y "*ygv
nnoremap <M-p> "+p
nnoremap <Leader>p "+p
nnoremap <Leader>P "*p
nnoremap Y y$
nnoremap <leader>r :<C-U>registers<CR>

" \_ uses last changed or yanked text as a characterwise object
onoremap <leader>_ :<C-U>normal! `[v`]<CR>
" \% uses entire buffer as a linewise object
onoremap <leader>% :<C-U>normal! 1GVG<CR>

" Retain selection when changing indent level
xnoremap < <gv
xnoremap > >gv

" Table (column) align
vmap <leader>ca :!column -t<cr>
vmap <leader>ta :!column -to<bslash><bar> -s<bslash><bar><cr>

" Buffers, navigation
" =======
set hidden                             " Let you switch buffers without saving current.
                                       " Don't mark buffers as abandoned if hidden.
set confirm                            " Prompt to save unsaved changes when exiting
" Have ctrl+scroll move by half-page, not full.
map <C-ScrollWheelUp> <C-u>
map <C-ScrollWheelDown> <C-d>
nnoremap <space> <C-d>
"nnoremap <s-space> <C-u>
nnoremap <leader>b :b<space><c-d>

" New buffer
nnoremap <Bslash><Insert> :enew<CR>
" Delete buffer
nnoremap <Bslash><Delete> :bdel<CR>
nnoremap <leader>d :bdel<CR>
nnoremap <leader>e :e **/

" Move between panes:
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Cycle through argument list
nnoremap [a :prev<CR>
nnoremap ]a :next<CR>
" Cycle through buffers
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
" Cycle through quickfix/errors
" TODO Clobbered by gitgutter
"nnoremap [c :cprev<CR>zz
"nnoremap ]c :cnext<CR>zz
" TODO Clobbered
"nnoremap ]] :cnext<cr>zz
"nnoremap [[ :cprev<cr>zz
nnoremap [e :cprev<CR>zz
nnoremap ]e :cnext<CR>zz
" Cycle through location list items
nnoremap [l :lprev<CR>zz
nnoremap ]l :lnext<CR>zz

" Cycle through buffers, tabs:
nnoremap <C-down> :bnext<CR>
nnoremap <C-up> :bprev<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <C-left> :tabprev<CR>

" For mappings needing conditionals/dependencies.
" TODO Move to config/ or appropriate location.
source ~/.vim/mappings.vim

" Completion/Omnifunc
" ===================
" Add completion options
if exists('+completeopt')
  set completeopt+=longest             " Insert longest common substring
  set completeopt+=menuone             " Show the menu even if only one match
endif
set wildignore=*.o,*.obj,*~            " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*.png,*.jpg,*.gif,*.ico
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=node_modules/*,bower_components/*
set infercase                          " Same-case autocomplete
set autochdir                          " Set working dir to open file
set complete+=kspell

" Set up external tools.
" ======================

" Use Silver Searcher for :grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m           " :h errorformat
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use ripgrep for :grep if ag not available
if !executable('ag')
    if executable('rg')
    	set grepprg=rg\ --vimgrep
    	set grepformat^=%f:%l:%c:%m
    endif
endif

" Use ranger's rifle to open files.
" TODO: Opens links incorrectly.
"if executable('rifle')
"   let g:netrw_browsex_viewer = 'rifle'
"endif

nnoremap <silent> <leader>k :silent ! $BROWSER https://en.wiktionary.org/wiki/<cword><cr>

" Better formatting for some file types
if executable('python')
    au FileType json set equalprg=python\ -m\ json.tool
endif
if executable('autopep8')
    au FileType python set equalprg=autopep8\ -
endif
if executable('xmllint')
    au FileType html,xhtml,xml set equalprg=xmllint\ --format\ -
endif
"if executable('tidy')
"    " Tidy gives more formatting options than xmllint
"    au FileType html,xhtml,xml setl equalprg=tidy\ --indent-spaces\ 4\ --indent-attributes\ yes\ --sort-attributes\ alpha\ --drop-empty-paras\ no\ --vertical-space\ yes\ --wrap\ 80\ -i\ -xml\ 2>/dev/null
"endif
if executable('pandoc')
    au FileType markdown set equalprg=pandoc\ -t\ markdown\ --reference-links\ --atx-headers\ --wrap=preserve
endif

" ALE
let b:ale_linters = ['pyflakes', 'flake8', 'pylint']

" Vimwiki
if isdirectory($HOME . "/vimwiki/")
	source ~/vw.vim
endif

" Todo
" ----
" https://github.com/junegunn/dotfiles/blob/master/vimrc#L856
function! s:todo() abort
    let entries = []
    for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
        let lines = split(system(cmd), '\n')
        if v:shell_error != 0 | continue | endif
        for line in lines
            let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
            call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
        endfor
        break
    endfor
    if !empty(entries)
        call setqflist(entries)
        copen
    endif
endfunction
command! Todo call s:todo()
nnoremap <leader>t :Todo<space><cr>

" Vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"call plug#begin('~/.vim/plugged')
" Make sure you use single quotes.
" You can conditionally activate plugins but PlugClean will remove plugins that
" fail, which can be a prob for shared configs (eg., gvim & terminal vim).
" Workaround example:
" Plug 'airblade/vim-gitgutter', has('signs') ? {} : { 'on': [] }
" Workaround example for Gist as plugin:
" Plug 'https://gist.github.com/952560a43601cd9898f1.git',
"    \ { 'as': 'xxx', 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }
if has('win32') || has('win64')
    " For Windows users
    call plug#begin('~/vimfiles/bundle')
else
    " For Linux/Mac users
    call plug#begin('~/.vim/bundle')
    Plug 'tpope/vim-eunuch'
endif
Plug 'junegunn/vim-plug'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
"Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
"Plug 'vim-ctrlspace/vim-ctrlspace'
"Git plugins>
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter', has('signs') ? {} : { 'on': [] }
"<Git plugins
"Coding plugins>
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
" TODO: Consider removing syntastic & ale for native 'au's.
Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
"Plug 'terryma/vim-multiple-cursors'
"<Coding plugins
"Python plugins>
Plug 'davidhalter/jedi-vim'
Plug 'jmcantrell/vim-virtualenv'
"<Python plugins
call plug#end()

" Source any .vim files from ~/.vim/config
"runtime! config/*.vim
