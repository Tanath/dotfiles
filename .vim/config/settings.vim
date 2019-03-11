" Misc
" ====
" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
" Use UTF-8 if we can and env LANG didn't tell us not to
if has('multi_byte') && !exists('$LANG') && &encoding ==# 'latin1'
    set encoding=utf-8
    scriptencoding utf-8
endif
set shellcmdflag=-c
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
set suffixesadd+='.md','.wiki'         " Add suffixes to check for gf.
set confirm                            " Prompt instead of just rejecting risky :write, :saveas
                                       " In vim-tiny but not NeoVim, so just suppress errors
set include=                           " Don't assume editing C; let the filetype set this
set nrformats-=octal                   " Treat numbers with leading 0 as decimal, not octal
set path+=**                           " Search under cwd.
set shortmess=aToO

" Language, spelling.
" Set language from user's environment.
" TODO: Support multiple comma-separated langs.
if has('syntax')
    let g:lang=tolower(split(expand(v:lang), '\.')[0])
    let &spelllang=g:lang
    let &langmenu=g:lang
    autocmd VimEnter * set spell spellsuggest=best
    " FIXME
    "autocmd FileType vim set nospell
endif

" Remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
" Put viminfo file in $VIMDIR
if has('viminfo')
    set viminfo='20,\"100,:40,%
    silent! execute 'set viminfo+=n'.$VIMDIR.'/viminfo'
    execute 'set viminfofile='.$VIMDIR.'/viminfo'
endif
" TODO Saving/restoring folds not working.
set viewoptions=folds,cursor           " Save fold state and cursor
au BufRead * loadview
au BufWrite * mkview

" :h sessionoptions
"if exists('+sessionoptions')
"    set sessionoptions-=blank,buffers,options,localoptions
"endif

" Searching
set ignorecase                         " Do case insensitive matching
set smartcase                          " Overrides ignorecase if uppercase used in search string
if has('extra_search')
    set hlsearch                       " Highlight the last used search pattern.
    set incsearch                      " Incremental search as you type.
endif
set wrapscan                           " Jumps to the beginning if reaching end, and viceversa
" Open folds with incsearch
try
    autocmd cmdlinechanged * if expand('<afile>') =~ '[/?]' |
    \	silent execute 'normal! zv' |
    \endif
catch '^Vim\%((\a\+)\)\=:E216'
endtry

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
let b:lion_squeeze_spaces = 1

" Whitespace characters.
set listchars=trail:~,tab:>\ ,nbsp:~
silent! set listchars+=trail:·
silent! set listchars+=tab:›
silent! set listchars+=nbsp:○

" Wrapping
set textwidth=80
set wrap linebreak                    " Linebreaks at word boundaries.

" Indenting.
set autoindent                         " Copy indent from current line when starting a new line
set shiftround                         " Round indents to multiple of shiftwidth.
set copyindent                         " Don't change indent type (spaces/tabs).
"set nostartofline                     " Emulate typical editor navigation behaviour
if exists('+breakindent') && exists('&breakindent')
	set breakindent
endif

" Tabbing, backspace
set tabstop=4 softtabstop=4 shiftwidth=4
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
if has('syntax')
    " Vim-plug enables syntax highlighting.
    if (!&loadplugins)
        if !exists('g:syntax_on')
            " Keeps current colour settings. 'on' overrules with defaults.
            syntax enable
        endif
    endif
    if !exists('g:colors_name')
        set background=dark
        " Of the dark themes available by default, elflord has best syntax highlighting.
        colors elflord
    endif
endif

" Status/Command line
if exists('+showcmd')
    set showcmd                        " Show (partial) command in status line.
endif
set showmode
set wildmenu
"set wildmode=longest,list,full         " Complete longest common string, then list alternatives, then select the sortest first
set wildmode=list:longest,list:full    " Complete longest common string, then list alternatives, then select the sortest first
silent! set wildignorecase             " Case insensitive, if supported
set wildcharm=<c-z>
"set tildeop
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
set number                            " Show line numbers.
set relativenumber                    " Show relative line numbers.
set cursorline                        " Underline line with cursor
set ruler                             " Show the line and column number of the cursor position, separated by a comma.
set scrolloff=2                       " Keep cursor # lines from top/bottom.
" To toggle keeping cursor centered:
if !exists('*VCenterCursor')
  augroup VCenterCursor
  au!
  au OptionSet *,*.*
    \ if and( expand("<amatch>")=='scrolloff' ,
    \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
    \   au! VCenterCursor WinEnter,WinNew,VimResized|
    \ endif
  augroup END
  function VCenterCursor()
    if !exists('#VCenterCursor#WinEnter,WinNew,VimResized')
      let s:default_scrolloff=&scrolloff
      let &scrolloff=winheight(win_getid())/2
      au VCenterCursor WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
    else
      au! VCenterCursor WinEnter,WinNew,VimResized
      let &scrolloff=s:default_scrolloff
    endif
  endfunction
endif

" Folding
" Fold based on indent, but only when I ask
if has('folding')
    set foldenable
    set foldlevel=99
    set foldlevelstart=1               " Start with folds open/closed/some, 99/0/1
    set foldnestmax=10                 " Max depth 10
    "set foldmethod=syntax
    " Allow conceal, but not if the cursor is on the line
    set conceallevel=2
    set concealcursor=
    let g:vimwiki_folding='syntax'
endif
"Indent w/manual folds:
"augroup vimrc
"  au BufReadPre * setl foldmethod=indent
"  au BufWinEnter * if &fdm ==# 'indent' | setl foldmethod=manual | endif
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
if has('diff')
	set diffopt+=vertical              " Vertical split diffs
	if has('win32')
		set showbreak=+
	else
		set showbreak=↪
	endif
endif

" Buffers, navigation
set hidden                             " Let you switch buffers without saving current.
                                       " Don't mark buffers as abandoned if hidden.
set confirm                            " Prompt to save unsaved changes when exiting

" Completion/Omnifunc
" ===================
" Add completion options
if exists('+completeopt')
    set completeopt+=longest           " Insert longest common substring
    set completeopt+=menuone           " Show the menu even if only one match
endif
if exists('+omnifunc')
    autocmd FileType * set omnifunc=syntaxcomplete#Complete
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

if executable('chmod')
    autocmd FileType sh autocmd BufWritePost * silent !chmod u+x %
endif

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
if isdirectory($HOME.'/vimwiki/')
    let g:vimwiki_folding = 'syntax'
    source ~/vw.vim
endif

