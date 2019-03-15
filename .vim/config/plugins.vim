" Vim-plug
" Make sure you use single quotes.
" You can conditionally activate plugins but PlugClean will remove plugins that fail, which can be a prob for shared configs (eg., gvim & terminal vim).
" Workaround example:
" Plug 'airblade/vim-gitgutter', has('signs') ? {} : { 'on': [] }
" Workaround example for Gist as plugin:
" Plug 'https://gist.github.com/952560a43601cd9898f1.git',
"    \ { 'as': 'xxx', 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }

" If --noplugin flag used, exit
if (!&loadplugins)
	finish
endif

" Auto-create autoload directory
if !isdirectory($VIMDIR.'/autoload')
	call mkdir($VIMDIR.'/autoload', 'p')
endif
" If plug.vim not in autoload directory...
if empty(glob($VIMDIR.'/autoload/plug.vim'))
	function! s:plugWarnSetup()
		echohl WarningMsg
		if (! executable('curl'))
			" Warn of missing curl and notify about :PlugDownload
			echon 'Curl not installed. Install it, then run :PlugDownload'
			echohl None
		else
			" Warn of missing vim-plug and notify about :PlugDownload
			echon 'Vim-plug is not installed. Run :PlugDownload to install it'
		endif
		echohl None
		" Create :PlugDownload
		command! -nargs=0 -bar PlugDownload
		\ call s:plugCurl() <bar> redraw! <bar>
		\ PlugInstall --sync
	endfunction
	function! s:plugCurl()
		execute 'silent !curl -NsfLo '.$VIMDIR.'/autoload/plug.vim --create-dirs'
		\ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	endfunction
	augroup PlugDownload
		autocmd!
		" Warn about vim-plug when not installed
		autocmd VimEnter * call s:plugWarnSetup()
	augroup end
	" Exit if vim-plug is not installed
	finish
endif

call plug#begin($VIMDIR.'/bundle')
if exists(':PlugInstall')
    Plug 'junegunn/vim-plug'
    if has('unix')
        Plug 'tpope/vim-eunuch'
    endif
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-characterize'
    Plug 'vim-airline/vim-airline'
    "Plug 'vim-airline/vim-airline-themes'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-repeat'
    Plug 'tommcdo/vim-lion'
    Plug 'unblevable/quick-scope'
    Plug 'junegunn/vim-peekaboo'
    " Highlight when pressing these keys:
    " Off for quicker vim-sneaking.
    "let g:qs_highlight_on_keys = ['f', 'F', 't', 'T', 's', 'S']
    Plug 'justinmk/vim-sneak', v:version >= 720 ? {} : { 'on': [] }
    Plug 'wellle/targets.vim'
    Plug 'tpope/vim-surround'
    "Plug 'mbbill/undotree'
    " Load on first use.
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'vimwiki/vimwiki'
    Plug 'plasticboy/vim-markdown'
    Plug 'vim-ctrlspace/vim-ctrlspace'
    "Git plugins>
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'rbong/vim-flog'
    Plug 'airblade/vim-gitgutter', has('signs') ? {} : { 'on': [] }
    "<Git plugins
    "Coding plugins>
    Plug 'romainl/vim-devdocs'
    Plug 'tpope/vim-commentary'
    Plug 'mattn/emmet-vim'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'tpope/vim-dispatch'
    Plug 'janko/vim-test'
    " TODO: Consider removing syntastic & ale for native 'au's.
    Plug 'vim-syntastic/syntastic'
    Plug 'w0rp/ale'
    "Plug 'terryma/vim-multiple-cursors'
    "<Coding plugins
    "Python plugins>
    Plug 'davidhalter/jedi-vim'
    Plug 'jmcantrell/vim-virtualenv'
    if v:version >= 730
        " TODO: Test this. Clobbers lots of shortcuts.
        "Plug 'python-mode/python-mode', { 'branch': 'develop' }
    endif
    "<Python plugins
    call plug#end() " Does 'filetype plugin indent on' and 'syntax enable'.
endif

