set nocompatible
filetype off
set shell=/bin/bash " for fish

" VUNDLE {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"" colors
Bundle 'vim-scripts/Colour-Sampler-Pack'
Bundle 'ScrollColors'
Bundle 'rainbow_parentheses.vim'
"" tools
Bundle 'SirVer/ultisnips'
Bundle 'klen/python-mode'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-surround'
"" misc
Bundle 'kien/ctrlp.vim'
" }}}
" plugin settings {{{

" load filetype plugins
filetype plugin on
filetype plugin indent on

" NERDcommenter
let g:NERDRemoveExtraSpaces=1
let g:NERDSpaceDelims=1

" Ctrl-p
" from https://gist.github.com/67de417c5c38f0ff8093
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
    \ 'file': '\.exe$\|\.so$\|\.dat$'
    \ }

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Solarized
let g:solarized_termcolors=256
" }}}
" appearance {{{
set encoding=utf-8
syntax on
if has('gui_running')
    if has("mac")
        set guifont=Envy\ Code\ R:h14
    elseif has("unix")
        set guifont=Envy\ Code\ R\ 11
    endif
    let g:molokai_original=1
    color twilight
else
    color vimbrant
endif
" set listchars=eol:¬,extends:»,tab:▸\ ,trail:›
" set list

" }}}
" basic {{{
set hidden
set number
set mouse=a
set guioptions-=T " hide toolbar
set guioptions-=r " hide scrollbar
set splitbelow
set textwidth=72
set scrolloff=5
set autoindent
set expandtab
set shiftwidth=4
set tabstop=8
set softtabstop=4
set backspace=2
set cinkeys=0{,0},0),0#,;,:,o,O,e
set indentkeys=o,O,:,0#,e
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.class
set pumheight=15
" }}}
" statusline {{{
" see https://wincent.com/wiki/Set_the_Vim_statusline
set laststatus=2
set statusline=%<\ %n:\ %f\ %m%r%{fugitive#statusline()}%=%-35.(%y\ ln:\ %l/%L,\ col:\ %c%V\ (%P)%)

" }}}
" formatting {{{
set cinoptions+=g0   " do not indent access modifiers
set formatoptions+=c " Auto-wrap text using textwidth
set formatoptions+=r " Auto-insert current comment leader on next line
set formatoptions+=o " Same as above, but when you hit o/O
set formatoptions+=q " Lets you format comments with gq
set formatoptions+=n " recognizes numbered lists when formatting text
set formatoptions+=2 " keeps indenting on different lines
"set equalprg=indent\ -kr\ -nut "\ -prs " '=' command uses 'indent' unix prog to format code
" }}}
" folding {{{
nnoremap <Space> za
vnoremap <Space> za
set foldmethod=syntax
set foldnestmax=1
nnoremap <Leader><Space> zMzvzz
set nofoldenable
" }}}
" searching {{{
set ignorecase          " search without caring of case
set smartcase           " only ignore case when lowercase
set incsearch           " show matches as they occur
set pastetoggle=<F5>    " used for pasting in data
set ruler               " always show location information
set showmatch           " show matching paren

" better highlighting
nnoremap / :set nohlsearch<CR>/
nnoremap ? :set nohlsearch<CR>?
vnoremap / :set nohlsearch<CR>/
vnoremap ? :set nohlsearch<CR>?

nnoremap n :set hlsearch<CR>n
nnoremap N :set hlsearch<CR>N
vnoremap n :set hlsearch<CR>n
vnoremap N :set hlsearch<CR>N

nnoremap i :set nohlsearch<CR>i
nnoremap I :set nohlsearch<CR>I
nnoremap a :set nohlsearch<CR>a
nnoremap A :set nohlsearch<CR>A
nnoremap o :set nohlsearch<CR>o
nnoremap O :set nohlsearch<CR>O
" }}}
" remaps {{{
let mapleader=","
" easier defaults {{{
inoremap kj <Esc>
inoremap jk <Esc>

nnoremap ; :
vnoremap ; :

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
nnoremap Y y$
nnoremap j gj
nnoremap k gk
" }}}
" leader macros {{{
nnoremap <Leader>; ;
nnoremap <Leader>g :Gstatus<CR>
map <Leader>cc <plug>NERDCommenterToggle
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
" }}}
" }}}
" autocmds {{{

" reload .vimrc whenever saved -- from https://gist.github.com/1988620
augroup AutoReloadVimRC
    autocmd!
    " automatically reload vimrc when it's saved
    autocmd BufWritePost $MYVIMRC so $MYVIMRC
    autocmd BufWritePost $MYVIMRC execute "syntax on"
    " autocmd BufWritePost $MYVIMRC PowerlineReloadColorscheme
augroup END

" compiling
augroup compilation
    autocmd!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
    autocmd Filetype java setlocal makeprg=javac\ %
augroup END

" lets me have man pages in their own window and syntax colored
" augroup doc
    " autocmd!
    " autocmd BufRead,BufEnter *.{c,cpp,h} source ~/.vim_macros/manpages-functions.vim
" augroup END

" http://blog.fluther.com/django-vim/
" augroup python
    " autocmd!
    " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " always use case-sensitive comparison, but don't screw up ==?
    autocmd Filetype vim setlocal iskeyword+=?
    autocmd FileType vim iabbrev <buffer> == ==#
    " autocmd FileType vim iabbrev <buffer> > >#
    " autocmd FileType vim iabbrev <buffer> < <#
augroup END

augroup auto_chdir
    autocmd!
    " from http://stackoverflow.com/questions/5793294/vim-cr-mapping-not-working
    " Automatically cd into the directory that the file is in
    autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
augroup END

" }}}
" misc {{{

" no beeping, please
" set visualbell

" insert current path into command prompt
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>

" quick-fix window
" ----------------
nnoremap <Leader>v :e ~/.vimrc<CR>

" }}}
" Ben Kuperman -- mostly macros {{{

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

set dictionary=/usr/share/dict/words
if v:version >= 700
    " Stuff for tabs
    " hi TabLineSel ctermbg=blue ctermfg=white cterm=bold
    " hi TabLine    cterm=reverse ctermfg=darkgray ctermbg=white
    " hi TabLineFill ctermbg=darkgray ctermfg=darkgray

    " color fixes
    " highlight MatchParen ctermbg=blue
    "highlight PmenuSel ctermfg=black ctermbg=lightgray 
endif

if has("spell")
    " set spell
    set spelllang=en_us
    set sps=best,10
    
    autocmd BufRead mutt-* setlocal spell
    autocmd BufRead .article.* setlocal spell
    autocmd BufEnter,BufNewFile,BufRead *.tex setlocal spell

    autocmd BufNewFile,BufRead,BufCreate */classes/*/Lectures/* setlocal spc=""
    autocmd BufNewFile,BufRead,BufCreate /manual\ page setlocal nospell
    autocmd BufNewFile,BufRead,BufCreate /dictionary\ page setlocal nospell
    autocmd BufNewFile,BufRead,BufCreate /thesaurus\ page setlocal nospell

endif

"""
" autocommands

" for C programs
autocmd BufRead *.c source ~/.vim_macros/c.vim
autocmd BufNewFile,BufCreate *.c source ~/.vim_macros/c.vim
autocmd BufRead *.h source ~/.vim_macros/c.vim
autocmd BufNewFile,BufCreate *.h source ~/.vim_macros/c.vim
autocmd BufRead Makefile setlocal noexpandtab
autocmd BufNewFile,BufCreate Makefile setlocal noexpandtab
autocmd FileType make setlocal noexpandtab

" use cscope if available
if has("cscope")
        set csprg=/usr/bin/cscope
        set csto=0
        set cst
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        " else add database pointed to by environment
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb
endif

" }}}
" vim: set fdm=marker:
