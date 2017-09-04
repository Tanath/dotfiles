" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

"set shell=/bin/zsh\ -i
set shcf=-c

" Misc essentials {{{
" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
set encoding=utf-8
set nocompatible	            " Use vim mode, not vi mode.
set cm=blowfish2
set spell spelllang=en_ca
if filereadable("/usr/sbin/rg")
	set grepprg=rg\ --vimgrep
	set grepformat^=%f:%l:%c:%m
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" Up/down by row instead of line:
nnoremap j gj
nnoremap k gk

" Automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =

" Enable file type detection. {{{2
if has("autocmd")
  " Only do this part when compiled with support for autocommands.
  " Use the default filetype settings, s, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent                    " always set autoindenting on
endif " has("autocmd")
" }}}

set nosol                           " No start of line jump when selecting.
set ttyfast
set modelines=0                     " Prevent some security issues
" retain selection when changing indent level
vnoremap < <gv
vnoremap > >gv
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
"}}}

" Status/Command line {{{
set showcmd                         " Show (partial) command in status line.
set showmode
set wildmenu
set wildmode=longest,list,full      " complete longest common string, then list alternatives, then select the sortest first
set laststatus=2                    " Always show status line
set cmdheight=2                     " Prevent "Press Enter" messages
" Show detailed information in status line:
set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]
let g:airline_powerline_fonts = 1
"let g:airline#extensions#bufferline#enabled " Buffer line. not working?
"}}}

" Backup and Swap files {{{
set backup
set undofile
if !isdirectory($HOME . ".vim")     " Create vim dirs if missing
	silent !mkdir -p ~/.vim/{backup,view} > /dev/null 2>&1
	silent !mkdir -p ~/.vim/pack/plugins/{start,opt} > /dev/null 2>&1
endif
set backupdir=$HOME/.vim/backup     " for backup files
set directory=$HOME/.vim/backup     " for .swp files
set backupskip=/tmp/*
set history=1000
set undodir=$HOME/.vim/undo         " where to save undo histories
set undolevels=1000                 " how many undos
set undoreload=10000                " number of lines to save for undo
" }}}

" Wrapping {{{
set textwidth=78
"set colorcolumn=79                 " Colour column to know when wrapping is needed.
set wrap linebreak nolist           " Linebreaks at word boundaries.
"}}}

" Searching {{{
set ignorecase						" do case insensitive matching
set smartcase						" overrides ignorecase if uppercase used in search string
set incsearch						" incremental search
set wrapscan						" jumps to the beginning if reaching end, and viceversa
" Toggle search highlight:
let hlstate=0
nnoremap <C-BSlash> :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<cr>
" }}}

" Buffers {{{
set hidden                          " Let you switch buffers without saving current. Don't mark buffers as abandoned if hidden.
set confirm                         " Prompt to save unsaved changes when exiting
nnoremap <leader>N :enew<CR>
nnoremap <leader>D :bd<CR>
" use tab key to cycle through the buffers:
nnoremap <leader><Tab>   :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>
"}}}

" Markdown {{{
set suffixesadd+='.md'
set suffixesadd+='.wiki'
" }}}

" Insert mode {{{
set backspace=2                     " Influences the working of <BS>, <Del>, CTRL-W
                                    " and CTRL-U in Insert mode. This is a list of items,
                                    " separated by commas. Each item allows a way to backspace
                                    " over something.
"set backspace=indent,eol,start     " Better handling of <BS>
set smartindent
set autoindent                      " Copy indent from current line when starting a new line
                                    " (typing <CR> in Insert mode or when using the "o" or "O"
                                    " command).
"set nostartofline                  " Emulate typical editor navigation behaviour
" }}}

" Tabbing {{{
set tabstop=4                       " Number of spaces that a <Tab> in the file counts for.
set softtabstop=4	
set shiftwidth=4                    " Number of spaces to use for each step of (auto)indent.
"set expandtab                      " Use the appropriate number of spaces to insert a <Tab>.
                                    " Spaces are used in indents with the '>' and '<' commands
                                    " and when 'autoindent' is on. To insert a real tab when
                                    " 'expandtab' is on, use CTRL-V <Tab>.
set smarttab                        " When on, a <Tab> in front of a line inserts blanks
                                    " according to 'shiftwidth'. 'tabstop' is used in other
                                    " places. A <BS> will delete a 'shiftwidth' worth of space
                                    " at the start of the line.
"}}}

" Interface {{{
" Set both for relative and absolute on cursor line:
set scrolloff=3                     " Keep cursor # lines from top/bottom.
set number                          " Show line numbers.
set relativenumber                  " Show relative line numbers.
" Toggle line numbering types:
nnoremap <leader>n :exe 'set nu!' &nu ? 'rnu!' : ''<cr>
if has('mouse')
	set mouse=a                     " Enable the use of the mouse (all modes).
endif
set visualbell                      " Flash instead of beep
"set t_vb=                          " And then disable even the flashing
set cursorline                      " Underline line with cursor
set ruler                           " Show the line and column number of the cursor position,
                                    " separated by a comma.
set splitright                      " vertical splits use right half of screen
set splitbelow                      " horizontal splits use bottom half of screen
"}}}

" Folding {{{
set foldenable
set foldmethod=syntax
""Indent w/manual folds:
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
""
"set foldcolumn=3
let g:vimwiki_folding='syntax'
set foldlevel=99
set foldnestmax=10		" max 10 depth
set foldlevelstart=1	" start with fold level of 1
nnoremap <space> za
" Save fold state and cursor {{{2
set viewoptions=folds,cursor
au BufRead * loadview
au BufWrite * mkview
"}}}
"}}}

" GUI options {{{
set guioptions=
set guioptions+=a         " Automatically make visual selection available in system clipboard
set guioptions+=A         " Same for modeless selection
set guioptions+=e         " GUI tabs
set guioptions+=g         " Grayed-out menu items that aren't active
set guioptions+=i         " Use a Vim icon
set guioptions+=m         " Show the menu bar
set guicursor+=a:blinkon0 " Don't blink the cursor
set mousehide             " Hide the mouse while typing
set winaltkeys=no         " Don't use ALT to access the menu
"}}}

" Theme/colours {{{
set background=dark " If using a dark background, for syntax highlighting. Opts: light/dark 
colors elflord
"}}}

" Mappings {{{
"" Quick yank/paste {{{2
set pastetoggle=<F2>
vmap <A-y> "+y
vmap <Leader>y "+y
vmap <Leader>Y "*y
nmap <A-p> "+p
nmap <Leader>p "+p
nmap <Leader>P "*p
"}}}

" :w!! 
" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null
" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F1> :help <C-R><C-W><CR>
" Save if needed. Requires for terminal: alias vim="stty stop '' -ixoff ; vim"
" If terminal freezes, hit <c-q> to resume.
nmap <c-s> :update<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <c-o><c-s>
" Save session
"nmap <c-S> :mks! session.vim<CR>
"vmap <c-S> <Esc><c-S>gv
"imap <c-S> <c-o><c-S>
"
map Y y$
" Don't use Ex mode, use Q for formatting
map Q gq
" switch to previous buffer
nnoremap <leader><leader> <C-^>
"
map <leader>td <Plug>TaskList
let g:pep8_map='<leader>8'
"}}}

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
 
" Formatting {{{
set formatoptions=croqnlj
"set formatoptions=croqanlj     " This is a sequence of letters which describes how
                                " automatic formatting works. See :h fo-table
"set formatoptions=want         " Attempt markdown list behaviour
" }}}

" Completion/Omnifunc {{{
set wildignore=*.o,*.obj,*~                       "stuff to ignore when tab completing
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
set infercase                                     " Same-case autocomplete
set autochdir                                     " Set working dir to open file

" Not needed:
"au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
"au FileType css setl ofu=csscomplete#CompleteCSS
"au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"au FileType python setlocal et sta sw=4 sts=4
"au FileType python set omnifunc=pythoncomplete#Complete
"au FileType ruby,eruby setl ofu=rubycomplete#Complete
"if has("autocmd") && exists("+omnifunc")
"     autocmd Filetype *
"   \ if &omnifunc == "" |
"   \   setlocal omnifunc=syntaxcomplete#Complete |
"   \ endif
"endif
"}}}

if isdirectory($HOME . "/vimwiki/")
	source ~/.vw.vim
endif
