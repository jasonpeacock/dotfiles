"set autoindent             " Always enable auto-indenting.
"set clipboard=unnamed      " Use system clipboard.
"set laststatus=2           " Always have a status bar.
"set nowrap                 " Stop word wrapping.
"set scrolloff=1            " Space above cursor from screen edge.
"set sidescrolloff=5        " Space beside cursor from screen edge.
"set cursorcolumn           " Highlight the current column.
"set cursorline             " Highlight the current line.
"set lazyredraw             " Redraw only when needed, speeds up macros.
"set conceallevel=0         " Don't hide characters.
set encoding=utf8          " Set standard file encoding.
set mouse=a                " Enable the mouse.
set nobackup               " Don't keep a backup file
set noerrorbells           " Be quiet.
set noswapfile             " Don't use swap files.
set showmatch              " Show matching brackets.
set undolevels=100         " Adjust system undo levels.
set wmh=0                  " Set smallest possible window when minimizing a split window.
set number                 " Turn on line numbers.
set relativenumber         " Show the line numbers as relative.

set spell                  " Enable spell check.
set spellcapcheck=         " Disable capitalization check.

" Fix behavior to continue comments on new lines, default is: tcqj
" :help fo-table
set formatoptions=tcrq

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

" Move up/down over wrapped lines in a nice manner.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$

" Restore cursor style on exit.
au VimLeave * set guicursor=a:hor25-blinkon0
