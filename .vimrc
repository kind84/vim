set nu
set hidden

" Better display for messages
set cmdheight=2

set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

if empty(glob('~/.vim/autoload/plug.vim'))

  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

if &diff

    highlight! link DiffText MatchParen

endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'

call plug#end()
