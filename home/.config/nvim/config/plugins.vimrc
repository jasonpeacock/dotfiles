" BEGIN dein
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')

  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('altercation/vim-colors-solarized')       " Solarized color theme.
  call dein#add('bkad/CamelCaseMotion')                   " Apply motion commands to CamelCase text.
  call dein#add('cespare/vim-toml')                       " TOML filetype support.
  call dein#add('elmcast/elm-vim')                        " Elm language support.
  call dein#add('euclio/vim-markdown-composer')           " An asynchronous markdown preview plugin for Vim and Neovim.
  call dein#add('joereynolds/place.vim')                  " Enter pieces of text without moving.
  call dein#add('ntpeters/vim-better-whitespace')         " Show & strip trailing whitespace.
  call dein#add('rust-lang/rust.vim')                     " Support Rust language syntax.
  call dein#add('sjl/gundo.vim')                          " Visualize the undo tree.
  call dein#add('tpope/vim-abolish')                      " Easily search for, substitute, and abbreviate multiple variants of a word.
  call dein#add('tpope/vim-commentary')                   " Comment stuff out.
  call dein#add('tpope/vim-eunuch')                       " helpers for Unix.
  call dein#add('tpope/vim-repeat')                       " Enable repeating supported plugin maps with '.'
  call dein#add('tpope/vim-sleuth')                       " Heuristically set buffer options.
  call dein#add('tpope/vim-surround')                     " Quoting/parenthesizing made simple.
  call dein#add('vim-airline/vim-airline')                " VIM status bar themes support.
  call dein#add('vim-airline/vim-airline-themes')         " VIM status bar themes.
  call dein#add('w0rp/ale')                               " Async linting.
  call dein#add('RRethy/vim-illuminate')                  " Highlight matching words under cursor automatically.

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
" END dein

" vim-airline
let g:airline_theme = "bubblegum"

" vim-colors-solarized
colorscheme solarized
set background=dark

" vim-better-whitespace
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit'] " Filetypes to skip stripping of whitespace.

" ale - this is how to disable it.
"let g:ale_lint_on_text_changed = 'always'        " When to lint if text changes (always (default)|insert|normal|never).
"let g:ale_lint_on_enter = 0                    " Don't lint when opening a file.
"let g:ale_lint_on_save = 0                     " Don't lint when saving a file.
let g:ale_sign_error = '>>'                     " Error sigil in gutter.
let g:ale_sign_warning = '--'                   " Warning sigil in gutter.
let g:ale_sign_column_always = 1                " Always show the gutter.
let g:ale_python_flake8_executable = 'python3'  " Use Python3 linter:
let g:ale_python_flake8_options = '-m flake8'   " https://github.com/w0rp/ale/blob/master/doc/ale-python.txt
let g:ale_sh_shell_default_shell = 'bash'       " We use non-standard #! for Bash, assume all shell files are Bash.
let g:ale_sh_shellcheck_options = '-s bash -e SC1008' " Force shellcheck to always assume Bash, and ignore warning about unsupported #!.

" camelcasemotion
call camelcasemotion#CreateMotionMappings('<leader>')

" Disable vim-sleuth
let g:sleuth_automatic = 0

hi illuminatedWord cterm=underline gui=underline
"hi link illuminatedWord Visual

" Elm-vim
let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_syntastic_show_warnings = 0
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 1
