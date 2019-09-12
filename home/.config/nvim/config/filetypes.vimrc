augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn

    " Strip trailing whitespace from all files. See the configuration in
    " plugins.vimrc for a blacklist of filetypes.
    autocmd BufEnter * EnableStripWhitespaceOnSave

    " Allow word wrapping for some filetypes.
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal conceallevel=0

    " YAML style is 2-space indenting.
    autocmd FileType yaml setlocal tabstop=2
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd FileType yaml setlocal commentstring=#\ %s

    " Bash style is 2-space indenting.
    autocmd FileType sh setlocal tabstop=2
    autocmd FileType sh setlocal shiftwidth=2
    autocmd FileType sh setlocal softtabstop=2
    autocmd FileType sh setlocal commentstring=#\ %s

    " Ruby style is 2-space indenting.
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s

    autocmd FileType python setlocal commentstring=#\ %s

    " Map unknown files to known filetypes.
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter *.launch setlocal filetype=xml " ROS .launch files are XML
    autocmd BufEnter *.bats set filetype=sh

    " Makefiles need to keep their tabs.
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END
