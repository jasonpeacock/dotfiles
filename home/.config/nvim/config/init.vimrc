"set autoindent             " Always enable auto-indenting.
"set clipboard=unnamed      " Use system clipboard.
"set conceallevel=1         " Don't hind characters.
set cursorcolumn           " Highlight the current column.
set cursorline             " Highlight the current line.
set encoding=utf8          " Set standard file encoding.
set noerrorbells           " Be quiet.
"set nowrap                 " Stop word wrapping.
set noswapfile             " Don't use swap files.
"set scrolloff=1            " Space above cursor from screen edge.
"set sidescrolloff=5        " Space beside cursor from screen edge.
set undolevels=100         " Adjust system undo levels.
"set laststatus=2           " Always have a status bar.
set wmh=0                  " Set smallest possible window when minimizing a split window.
set showmatch              " Show matching brackets.
set lazyredraw             " Redraw only when needed, speeds up macros.

" Enable wildmenu support, which autocompletes commmands.
set wildmenu
set wildmode=list:longest,full " list all options, match to the longest

" Set tab width & convert tabs to spaces.
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Support folding.
set foldenable             " Enable folding.
"set foldcolumn=2           " Reserve space for the fold.
set foldlevelstart=99      " All folds are open by default.
set foldmethod=indent      " Use indenting to determine folds.
"set foldmethod=syntax      " Use syntax rules to determine folds.

" Searching.
set hlsearch               " Use search highlighting.
set ignorecase             " Do case insensitive searching.
set incsearch              " Perform incremental searching.
set smartcase              " Ignore case unless case is used.

" Restore cursor style on exit.
au VimLeave * set guicursor=a:hor25-blinkon0
