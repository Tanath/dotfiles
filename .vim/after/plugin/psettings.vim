" Gitgutter
if g:gitgutter_enabled
    let g:gitgutter_max_signs = 1300
endif

" ALE
let b:ale_linters = ['pyflakes', 'flake8', 'pylint']

" Vimwiki
if isdirectory($HOME.'/vimwiki/')
    let g:vimwiki_folding = 'syntax'
    source ~/vw.vim
    if has('folding')
        let g:vimwiki_folding='syntax'
    endif
endif

" Use Silver Searcher for :grep
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" TODO: Test md fenced code block syntax:
"let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let b:lion_squeeze_spaces = 1

