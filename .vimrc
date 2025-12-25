set nocompatible
let mapleader = " "

set encoding=utf-8
set fileencoding=utf-8
set number relativenumber
set hidden
set ruler
set backspace=indent,eol,start

set numberwidth=4
set signcolumn=auto
set cursorline

highlight LineNr ctermfg=241 guifg=#665c54
highlight CursorLineNr ctermfg=214 cterm=bold guifg=#fabd2f gui=bold
highlight CursorLine cterm=none gui=none ctermbg=236 guibg=#303030  " subtle background on current line

set wildmenu
set wildmode=full

set nobackup
set nowritebackup

" characters for displaying non-printable characters
set listchars=eol:$,tab:>-,trail:.,nbsp:_,extends:+,precedes:+

" Better display for messages
set cmdheight=2

set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

set background=dark
set t_Co=256

" incremental search and highlight all matches
set incsearch hlsearch
set ignorecase smartcase

" natural split opening
set splitright

" keep lines visible above/below cursor
set scrolloff=5

" reload files changed outside vim
set autoread

" persistent undo
set undofile
set undodir=~/.vim/undodir

" system clipboard
set clipboard=unnamedplus

" default indentation
set tabstop=4 shiftwidth=4 expandtab

inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" replace %:h with %% to expand active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" map buffer list navigation
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" map FZF to <C-p> for files, leader-c for commands, leader-b for buffers
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>rg :RG<CR>

" map hexdump to leader-h
nnoremap <silent> <leader>h :Hexmode<CR>

" map json prettify to leader-jj
nnoremap <silent> <leader>jj :%!jq .<CR>

" prettify xml
command! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap <leader>fx :FormatXML<CR>

augroup filetypes
  autocmd!
  autocmd FileType javascript,json,yaml setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType proto,vue setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

if empty(glob('~/.vim/autoload/plug.vim'))

  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

if &diff

    highlight! link DiffText MatchParen

endif

call plug#begin('~/.vim/plugged')

Plug 'cespare/vim-toml'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'branch': 'master' }
Plug 'fidian/hexmode'
Plug 'https://github.com/adelarsq/vim-devicons-emoji'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'inkarkat/vim-AdvancedSorters'
Plug 'inkarkat/vim-ingo-library'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'NoahTheDuke/vim-just'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'sukima/xmledit'
Plug 'terrastruct/d2-vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'ziglang/zig.vim'

call plug#end()

packadd! matchit

let g:airline_powerline_fonts = 1
let g:markdown_fenced_languages = ['javascript', 'ruby', 'sh', 'yaml', 'html', 'css', 'vim', 'json', 'diff', 'go', 'python']


" -------------------------------------------------------------------------------------------------
" Tagbar default settings
" -------------------------------------------------------------------------------------------------

nmap <leader>tt :TagbarToggle<CR>


" -------------------------------------------------------------------------------------------------
" fugitive default settings
" -------------------------------------------------------------------------------------------------

map <leader>gp :Git push<CR>


" -------------------------------------------------------------------------------------------------
" nerdtree default settings
" -------------------------------------------------------------------------------------------------

let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.swp$']

" shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>

augroup nerdtree
  autocmd!
  " close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END


" -------------------------------------------------------------------------------------------------
" vim-go default settings
" -------------------------------------------------------------------------------------------------

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0
let g:go_diagnostics_level = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_updatetime = 300

let g:go_debug_address = '127.0.0.1:2345'

let g:go_debug_mappings = {
  \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
  \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
  \ '(go-debug-step)': {'key': 's'},
  \ '(go-debug-print)': {'key': 'p'},
\}

map <leader>ds :GoDebugStart<CR>
map <leader>dt :GoDebugStop<CR>
map <leader>db :GoDebugBreakpoint<CR>
map <leader>dc :GoDebugContinue<CR>
map <leader>dn :GoDebugNext<CR>
map <leader>di :GoDebugStep<CR>
map <leader>dp :GoDebugPrint<CR>

map <leader>gd :GoDecls<CR>
map <leader>gc :GoCoverage<CR>
map <leader>gcc :GoCoverageClear<CR>


" -------------------------------------------------------------------------------------------------
" rust.vim default settings
" -------------------------------------------------------------------------------------------------

syntax enable
filetype plugin indent on

" enable rustfmt on every save
let g:rustfmt_autosave = 1


" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

"Use <tab> and <S-tab> to navigate completion list:
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rr <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Scroll documentation pop-ups
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"


" -------------------------------------------------------------------------------------------------
" undotree default settings
" -------------------------------------------------------------------------------------------------

nnoremap <F5> :UndotreeToggle<CR>
