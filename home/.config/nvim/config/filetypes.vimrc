augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn

    " Strip trailing whitespace from all files. See the configuration in
    " plugins.vimrc for a blacklist of filetypes.
    autocmd BufEnter * EnableStripWhitespaceOnSave

    " Allow word wrapping for some filetypes.
    autocmd FileType markdown setlocal wrap

    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4

    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s

    autocmd FileType python setlocal commentstring=#\ %s

    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2

    " Map unknown files to known filetypes.
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh

    " Makefiles need to keep their tabs.
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END


