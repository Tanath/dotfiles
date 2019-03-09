" Source config
" =============
" Set up vim dirs.
" Backup, swap, undo files
if has('win32') || has('win64')
    " Create vim dirs if missing
    if !isdirectory($HOME.'/vimfiles')
        silent !md ~/vimfiles/cache/backup
        silent !md ~/vimfiles/cache/view
        silent !md ~/vimfiles/cache/undo
        silent !md ~/vimfiles/pack/plugins/start
        silent !md ~/vimfiles/pack/plugins/opt
        silent !md ~/vimfiles/config/
    endif
else
    " Create vim dirs if missing
    if !isdirectory($HOME.'/.vim')
        silent !mkdir -p ~/.vim/cache/{backup,view} > /dev/null 2>&1
        silent !mkdir -p ~/.vim/cache/undo > /dev/null 2>&1
        silent !mkdir -p ~/.vim/pack/plugins/{start,opt} > /dev/null 2>&1
        silent !mkdir -p ~/.vim/config/ > /dev/null 2>&1
    endif
endif
set backup
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/cache/undo/
    if has('win32') || has('win64')
        set undodir-=~/.vim/cache/undo/
        set undodir^=~/vimfiles/cache/undo/
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
set undoreload=8000                    " Number of lines to save for undo

" Source any .vim files from config dir.
if has('win32') || has('win64')
    runtime! config/*.vim
    " ~/vimfiles/config/settings.vim
    " ~/vimfiles/config/plugins.vim
    " ~/vimfiles/config/mappings.vim
else
    runtime! config/*.vim
    " ~/.vim/config/settings.vim
    " ~/.vim/config/plugins.vim
    " ~/.vim/config/mappings.vim
endif

" Todo
" ====
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
