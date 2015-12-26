" NeoBundle {{{
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins:
NeoBundle 'Auto-Pairs'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'matchit.zip'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/unite.vim'

" Cosmetic:
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'brendonrapp/smyck-vim'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'rainbow_parentheses.vim'
NeoBundle 'vim-scripts/xoria256.vim'

" Tools:
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'linux' : 'make',
            \     'mac' : 'make',
            \    },
            \ }

" Required:
call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
" NeoBundle }}}
" Better defaults {{{
set encoding=utf-8
set hidden
set number
set mouse=a
" set ttymouse=xterm2
set splitbelow
set splitright
set autoread
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.class
set laststatus=2
" }}}
" Formatting {{{
set textwidth=80
set backspace=2
set expandtab
set cinkeys=0{,0},0),0#,;,:,o,O,e
set indentkeys=o,O,:,0#,e
set cinoptions+=(0   " indent parenthetical function arguments correctly
set cinoptions+=g0   " do not indent access modifiers
set formatoptions+=c " Auto-wrap text using textwidth
set formatoptions+=r " Auto-insert current comment leader on next line
set formatoptions+=o " Same as above, but when you hit o/O
set formatoptions+=q " Lets you format comments with gq
set formatoptions+=n " recognizes numbered lists when formatting text
set formatoptions+=2 " keeps indenting on different lines
"set equalprg=indent\ -kr\ -nut "\ -prs " '=' command uses 'indent' unix prog to format code
" }}}
" Folding {{{
nnoremap <Space> za
vnoremap <Space> za
set foldmethod=syntax
set foldnestmax=2
set nofoldenable
nnoremap <Leader><Space> zMzvzz
" }}}
" Remaps {{{
let mapleader=","
" easier defaults {{{
nnoremap Y y$
inoremap kj <Esc>
inoremap jk <Esc>

nnoremap ; :
vnoremap ; :
nnoremap <Leader>; ;

nnoremap <Leader>k :bp\|bd #<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" }}}
" Searching {{{
set ignorecase          " search without caring of case
set smartcase           " only ignore case when lowercase
set incsearch           " show matches as they occur
set hlsearch
set pastetoggle=<F5>    " used for pasting in data
set ruler               " always show location information
set showmatch           " show matching paren
" }}}
" Autocmds {{{
augroup filetype_settings
  autocmd!

  " vim
  autocmd FileType vim setlocal sw=2
  autocmd FileType vim setlocal foldmethod=marker

  " python
  autocmd FileType vim setlocal sw=2
  setlocal keywordprg=pydoc

  " ruby
  autocmd FileType ruby setlocal sw=2
  autocmd FileType eruby setlocal sw=2

  " js
  autocmd FileType javascript setlocal sw=4
  autocmd FileType javascript setlocal fo-=c " Don't auto-wrap

  " html
  autocmd FileType html setlocal sw=4
  autocmd FileType htmldjango setlocal sw=4

  " css
  autocmd Filetype css setlocal sw=4
  autocmd Filetype scss setlocal sw=4

  " c/c++
  autocmd FileType c,cpp setlocal sw=4

  " java
  autocmd FileType java setlocal sw=4
augroup END

augroup delete_whitespace
  " Always delete trailing whitespace before saving
  autocmd!
  autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

augroup AutoReloadVimRC
  " reload .vimrc whenever saved -- from https://gist.github.com/1988620
  autocmd!
  " automatically reload vimrc when it's saved
  autocmd BufWritePost $MYVIMRC so $MYVIMRC
  autocmd BufWritePost $MYVIMRC execute "syntax on"
augroup END

" compiling
augroup compilation
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
  autocmd Filetype java setlocal makeprg=javac\ %
augroup END

" }}}
" Helper Macros/functions{{{
" global file replace on inner word
nnoremap <leader>R yiw:%s/<C-r>"//g<Left><Left>
" }}}
" Plugin settings {{{
filetype plugin on
filetype plugin indent on

" ctrlp
nnoremap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_extensions = ['buffertag']

" python-mode
let g:pymode_lint_checker = "pyflakes,mccabe" " no pep8
let g:pymode_lint = 0
let g:pymode_breakpoint = 0
let g:pymode_rope = 0
let g:pymode_options_max_line_length = 120
let g:pymode_doc = 0

" NERDTree
let g:NERDTreeRespectWildIgnore=1
nnoremap <Leader>n :NERDTreeToggle<CR>

" fugitive
nnoremap <Leader>g :Gstatus<CR>

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
" }}}
" Appearance {{{
syntax on
set listchars=extends:»,tab:▸\ ,trail:·,extends:»
set list
set cursorline
if has('gui_running')
  set guioptions-=T " hide toolbar
  set guioptions-=r " hide scrollbar
  set guifont=Menlo\ Regular:h12
endif
color Tomorrow-Night
" }}}
" Stuff from Ben {{{
" I Make a bunch of text headlines
map! <Leader>ul <esc>:let @h=@/<cr>yypV:s/^[ ]*//<CR>V:s/./-/g<cr>:let @/=@h<CR>kJi<CR><esc>o
map  <Leader>ul :let @h=@/<cr>yypV:s/^[ ]*//<CR>V:s/./-/g<cr>:let @/=@h<CR>kJi<CR><esc>
vmap <Leader>ul <esc>:let @h=@/<cr>yyPj:s/./ /g<CR>gvr-:let @/=@h<CR>k$
map! <Leader>hl <cr><esc>079A-<esc>o
map  <Leader>hl o<esc>079A-<esc>

" The date
nmap <Leader>ldate :r!date<cr>
map! <Leader>ldate <esc>:r!date<cr>
nmap <Leader>date i<cr><esc>k:r!date +"\%d \%B \%Y"<cr>kJJ
map! <Leader>date <cr><esc>k:r!date +"\%d \%B \%Y"<cr>kJJi
nmap <Leader>sdate i<cr><esc>k:r!date +"\%m/\%d/\%y"<cr>kJJ
map! <Leader>sdate <cr><esc>k:r!date +"\%m/\%d/\%y"<cr>kJJi
" }}}
" Misc {{{
" insert current path into command prompt
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>
nnoremap <Leader>v :e ~/.vimrc<CR>
" }}}
