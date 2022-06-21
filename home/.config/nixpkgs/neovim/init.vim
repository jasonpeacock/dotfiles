" Vim configuration for Neovim
"
" Move up/down over wrapped lines in a nice manner.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" ale - this is how to disable it.
"let g:ale_lint_on_text_changed = 'always'       " When to lint if text changes (always (default)|insert|normal|never).
"let g:ale_lint_on_enter = 0                    " Don't lint when opening a file.
"let g:ale_lint_on_save = 0                     " Don't lint when saving a file.
let g:ale_fix_on_save = 1                       " Apply fixers (formatters) to files on save.
let g:ale_sign_error = '>>'                     " Error sigil in gutter.
let g:ale_sign_warning = '--'                   " Warning sigil in gutter.
let g:ale_sign_column_always = 1                " Always show the gutter.
"let g:ale_ruby_rubocop_options = ''            " https://rubocop.readthedocs.io/en/latest/configuration/
let g:ale_python_flake8_executable = 'flake8'   " Use Python3 linter:
let g:ale_python_flake8_options = '--max-line-length 88'   " https://github.com/w0rp/ale/blob/master/doc/ale-python.txt
"let g:ale_python_flake8_executable = 'python3'  " Use Python3 linter:
"let g:ale_python_flake8_options = '-m flake8 --max-line-length 88'   " https://github.com/w0rp/ale/blob/master/doc/ale-python.txt
let g:ale_sh_shell_default_shell = 'bash'       " We use non-standard #! for Bash, assume all shell files are Bash.
let g:ale_sh_shellcheck_options = '-s bash -e SC1008' " Force shellcheck to always assume Bash, and ignore warning about unsupported #!.
let g:ale_sh_shfmt_options = "-i 2 -ci -sr -kp" " Make `shfmt` pretty.
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_rls_toolchain = "stable"
" Make the errors more legible
let g:ale_echo_msg_format = "[%linter%] %s"
"let g:ale_cursor_detail = 1
"let g:ale_echo_cursor = 1
"let g:ale_close_preview_on_insert = 1
"let g:ale_echo_delay = 10  " Default is 10ms
let g:ale_python_mypy_ignore_invalid_syntax = 1 " Speed things up by ignore Mypy syntax errors
let g:ale_python_mypy_show_notes = 1

" \ 'rust': ['analyzer', 'rls', 'cargo'],
let g:ale_linters = {
\ 'rust': ['analyzer'],
\}

let g:ale_fixers = {
\ 'python': ['black'],
\ 'rust': ['rustfmt'],
\ 'sh': ['shfmt'],
\}

highlight ALEWarning ctermfg=13
highlight ALEError ctermfg=5
