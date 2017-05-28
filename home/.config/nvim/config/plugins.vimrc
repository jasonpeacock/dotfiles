" BEGIN dein
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')

  " Don't managed dein with dein, it's a submodule of homeshick/dotfiles
  " instead.
  "call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('altercation/vim-colors-solarized')       " Solarized color theme.
  call dein#add('vim-airline/vim-airline')                " VIM status bar themes support.
  call dein#add('vim-airline/vim-airline-themes')         " VIM status bar themes.
  call dein#add('rust-lang/rust.vim')                     " Support Rust language syntax.
  call dein#add('sjl/gundo.vim')                          " Visualize the undo tree.
  call dein#add('rking/ag.vim')                           " The Silver Searcher!
  call dein#add('kien/ctrlp.vim')                         " Fuzzy file searching.
  call dein#add('ntpeters/vim-better-whitespace')         " Show & strip trailing whitespace.
  call dein#add('Yggdroot/indentLine')                    " Show indenting levels.
  call dein#add('w0rp/ale')                               " Async linting.

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

" ctrlp.vim
let g:ctrlp_match_window = 'bottom,order:ttb'   " Order matching files top-to-bottom.
let g:ctrlp_switch_buffer = 0                   " Always open files in new buffers.
let g:ctrlp_working_path_mode = 0               " Respect when working dir changes.
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " Use Ag for searching.

" vim-better-whitespace
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit'] " Filetypes to skip stripping of whitespace.

" ale
"let g:ale_line_on_text_changed = 'never'       " Only lint when saving a file (never|normal).
"let g:ale_line_on_enter = 0                    " Don't lint when opening a file.
"let g:ale_lint_on_save = 0                     " Don't lint when saving a file.

