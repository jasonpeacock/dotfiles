" Use spacebar for leader key, instead of '\'.
let mapleader="\<SPACE>"

" Turn off the search highlight.
nnoremap <leader><space> :nohlsearch<CR>

" Map ctrl-h/j/k/l to move between split windows.
map <c-h> <c-w>j<c-w>_
map <c-j> <c-w>j<c-w>_
map <c-k> <c-w>k<c-w>_
map <c-l> <c-w>l<c-w>_

" Delete a selection w/o updating the buffer.
vnoremap x "_x
vnoremap X "_X

" Toggle 'slf/gundo.vim'
nnoremap <leader>u :GundoToggle<CR>

" Toggle 'rking/ag.vim'
nnoremap <leader>a :Ag

" Navigate between Ale warnings & errors.
"nmap <silent> <C-K> <Plug>(ale_previous_wrap)
"nmap <silent> <C-J> <Plug>(ale_next_wrap)
