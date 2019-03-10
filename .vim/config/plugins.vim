" Vim-plug
if executable('curl')
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
        " Check & install for Windows
        if v:progname==?'vim' || v:progname==?'vimdiff'
            if empty(glob('~/vimfiles/autoload/plug.vim'))
                silent !curl -fLo ~/vimfiles/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
            endif
        elseif v:progname==?'nvim'
            if empty(glob($HOME.'\AppData\Local\nvim\autoload'))
                silent !curl --create-dirs -fLo $HOME\AppData\Local\nvim\autoload\plug.vim 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
            endif
        endif
        call plug#begin('~/vimfiles/bundle')
    else
        " Check & install for Linux/Mac
        if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
        call plug#begin('~/.vim/bundle')
        Plug 'tpope/vim-eunuch'
    endif
    Plug 'junegunn/vim-plug'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-characterize'
    Plug 'vim-airline/vim-airline'
    "Plug 'vim-airline/vim-airline-themes'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-repeat'
    Plug 'tommcdo/vim-lion'
    Plug 'justinmk/vim-sneak', v:version >= 720 ? {} : { 'on': [] }
    Plug 'wellle/targets.vim'
    Plug 'tpope/vim-surround'
    "Plug 'mbbill/undotree'
    "Plug 'scrooloose/nerdtree'
    Plug 'vimwiki/vimwiki'
    "Plug 'vim-ctrlspace/vim-ctrlspace'
    "Git plugins>
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'rbong/vim-flog'
    Plug 'airblade/vim-gitgutter', has('signs') ? {} : { 'on': [] }
    "<Git plugins
    "Coding plugins>
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
    "<Python plugins
    call plug#end() " Does 'filetype plugin indent on' and 'syntax enable'.
else
    echomsg "Curl missing, skipping vim-plug & plugins."
endif

