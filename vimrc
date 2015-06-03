" Packages {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

"" colors
Bundle 'ScrollColors'
Bundle 'rainbow_parentheses.vim'
Bundle 'vim-scripts/Colour-Sampler-Pack'
Bundle 'w0ng/vim-hybrid'
"" tools
Bundle 'Auto-Pairs'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'godlygeek/tabular'
Bundle 'honza/vim-snippets'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'matchit.zip'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-vinegar'
" }}}
" Better defaults {{{
set encoding=utf-8
set hidden
set number
set mouse=a
set ttymouse=xterm2
set splitbelow
set splitright
set textwidth=72
set tabstop=8
set shiftwidth=4
set softtabstop=-1 " use value of shiftwidth
set backspace=2
set expandtab
set autoread
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.class
" }}}
" Formatting {{{
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
set pastetoggle=<F5>    " used for pasting in data
set ruler               " always show location information
set showmatch           " show matching paren
" }}}
" Statusline {{{
" see https://wincent.com/wiki/Set_the_Vim_statusline
set laststatus=2
set statusline=%<\ %n:\ %f\ %m%r%{fugitive#statusline()}%=%-35.(%y\ ln:\ %l/%L,\ col:\ %c%V\ (%P)%)

" }}}
" Autocmds {{{
augroup filetype_settings
  autocmd!

  " vim
  autocmd FileType vim setlocal sw=2
  autocmd FileType vim setlocal foldmethod=marker

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

" augroup auto_chdir
  " autocmd!
  " " from http://stackoverflow.com/questions/5793294/vim-cr-mapping-not-working
  " " Automatically cd into the directory that the file is in
  " autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" augroup END

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

" python-mode
let g:pymode_lint_checker = "pyflakes,mccabe" " no pep8
let g:pymode_lint = 0
let g:pymode_breakpoint = 0
let g:pymode_rope = 0
let g:pymode_options_max_line_length = 120
let g:pymode_doc = 0

" youcompleteme
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" NERDTree
let g:NERDTreeRespectWildIgnore=1
nnoremap <Leader>n :NERDTreeToggle<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" fugitive
nnoremap <Leader>g :Gstatus<CR>

" Themes
let g:solarized_termcolors=256
let g:molokai_original=1
let g:hybrid_use_Xresources=1
" }}}
" Appearance {{{
syntax on
color xoria256
set listchars=extends:»,tab:▸\ ,trail:·,extends:»
set list
set cursorline
if has('gui_running')
  set guioptions-=T " hide toolbar
  set guioptions-=r " hide scrollbar
  set guifont=Menlo\ Regular:h12
endif
" set list
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
" vim: set fdm=marker:
