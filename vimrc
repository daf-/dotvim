set nocompatible
filetype off

" VUNDLE {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'


" FuzzyFinder for locating distant files, ctrlp for projects and buffers
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'kien/ctrlp.vim'
" colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'inkpot'
Bundle 'nanotech/jellybeans.vim'
" programming
Bundle 'SirVer/ultisnips'
Bundle 'majutsushi/tagbar'
Bundle 'sbl/scvim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-surround'

" }}}

" plugin settings {{{

" load filetype plugins
filetype plugin on
filetype plugin indent on

" Powerline
set encoding=utf-8
" let g:Powerline_symbols = 'fancy'
" let g:Powerline_stl_path_style = 'short'

" Syntastic
let g:syntastic_python_checker = 'flake8'
let g:syntastic_error_symbol='✗'    " from syntastic manual
let g:syntastic_warning_symbol='⚠'  " from syntastic manual

" NERDcommenter
let g:NERDRemoveExtraSpaces=1
let g:NERDSpaceDelims=1

" Ctrl-p
" from https://gist.github.com/67de417c5c38f0ff8093
" Sane Ignore For ctrlp
" let g:ctrlp_custom_ignore = {
    " \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
    " \ 'file': '\.exe$\|\.so$\|\.dat$'
    " \ }
" let g:solarized_termcolors=256

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}

" color, font {{{
syntax on
if has('gui_running')
    set bg=dark
    colorscheme solarized
    if has("mac")
        set guifont=Menlo\ for\ Powerline\:h11
    elseif has("unix")
        set guifont=Ubuntu\ Mono\ for\ Powerline\ 13
    endif
else
    " set bg=dark
    colorscheme jellybeans
endif
" set listchars=eol:¬,extends:»,tab:▸\ ,trail:›
" set list

" }}}

" statusline {{{

" see https://wincent.com/wiki/Set_the_Vim_statusline
set laststatus=2        " always show the status bar
set statusline=%<\ %n:\ %f\ %m%r%{fugitive#statusline()}%=%-35.(%y\ ln:\ %l/%L,\ col:\ %c%V\ (%P)%)

" }}}

" editing {{{
set hidden
set number " line numbers
set mouse=a " can use mouse
set go-=T " hide MacVim toolbar
set splitbelow " split windows open below current window
set textwidth=79 " max. width of text being inserted
set scrolloff=5 " scrolling starts 5 lines from top or bottom of page
set cursorline " get line highlighted
set autoindent                      " always set autoindenting on
set expandtab                       " This makes them all spaces.
set shiftwidth=4                    " autoindent n spaces (not 8) (shiftwidth)
set tabstop=4                   " Let's have better tabbing (never change tab size!)
set softtabstop=4                   " Let's have better tabbing (never change tab size!)
set backspace=2                     " allow backspacing over everything in insert mode
set cinkeys=0{,0},0),0#,;,:,o,O,e   " when to re-indent the current line in C languages
set indentkeys=o,O,:,0#,e           " when to re-indent the current line in non-C languages
" }}}

" formatting {{{
set formatoptions+=c " Auto-wrap text using textwidth
set formatoptions+=r " Auto-insert current comment leader on next line
set formatoptions+=o " Same as above, but when you hit o/O
set formatoptions+=q " Lets you format comments with gq
set formatoptions+=n " recognizes numbered lists when formatting text
set formatoptions+=2 " keeps indenting on different lines
set foldmethod=syntax
set foldnestmax=1
"set nofoldenable
"set equalprg=indent\ -kr\ -nut "\ -prs " '=' command uses 'indent' unix prog to format code
" }}}

" searching {{{
set ignorecase          " search without caring of case
set smartcase           " only ignore case when lowercase
set incsearch           " show matches as they occur
set pastetoggle=<F5>    " used for pasting in data
set ruler               " always show location information
set showmatch           " show matching paren

" better highlighting
" nnoremap / :set nohlsearch<CR>/
" nnoremap ? :set nohlsearch<CR>?
" vnoremap / :set nohlsearch<CR>/
" vnoremap ? :set nohlsearch<CR>?

" nnoremap n :set hlsearch<CR>n
" nnoremap N :set hlsearch<CR>N
" vnoremap n :set hlsearch<CR>n
" vnoremap N :set hlsearch<CR>N

" nnoremap i :set nohlsearch<CR>i
" nnoremap I :set nohlsearch<CR>I
" nnoremap a :set nohlsearch<CR>a
" nnoremap A :set nohlsearch<CR>A
" nnoremap o :set nohlsearch<CR>o
" nnoremap O :set nohlsearch<CR>O
" }}}

" remaps {{{
let mapleader=","
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-l> :tabnext<CR>
nnoremap <S-h> :tabprevious<CR>
inoremap kj <Esc>
inoremap jk <Esc>
nnoremap <Space> za
vnoremap <Space> za
map Y y$ " makes Y yank till end of line
nnoremap j gj
nnoremap k gk
inoremap <C-@> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>
nnoremap <Leader>s :w<CR>
" PLUGIN remaps
map <Leader>cc <plug>NERDCommenterToggle
nnoremap <Leader>t :TagbarToggle<CR>
map <Leader>hc :r ~/.vim/honorcode.txt<CR>
nnoremap <Leader>f :FufFile<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
" leader macros
nnoremap <Leader>s :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>g :Gstatus<CR>
" }}}

" autocmds, filetype options {{{

" reload .vimrc whenever saved -- from https://gist.github.com/1988620
augroup AutoReloadVimRC
  au!
  " automatically reload vimrc when it's saved
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" compiling
augroup compilation
    autocmd!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
    autocmd Filetype java setlocal makeprg=javac\ %
augroup END

" lets me have man pages in their own window and syntax colored
augroup doc
    autocmd!
    autocmd BufRead,BufEnter *.{c,cpp,h} source ~/.vim_macros/manpages-functions.vim
augroup END

" http://blog.fluther.com/django-vim/
augroup python
    autocmd!
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " always use case-sensitive comparison, but don't screw up ==?
    autocmd Filetype vim setlocal iskeyword+=?
    autocmd FileType vim iabbrev <buffer> == ==#
    autocmd FileType vim iabbrev <buffer> > >#
    autocmd FileType vim iabbrev <buffer> < <#
augroup END

augroup auto_chdir
    autocmd!
    " from http://stackoverflow.com/questions/5793294/vim-cr-mapping-not-working
    " Automatically cd into the directory that the file is in
    autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
augroup END

" }}}

" misc {{{

" make autocomplete AWESOME
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.class

" no beeping, please
set visualbell t_vb=
set novisualbell

" insert current path into command prompt
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>

" quick-fix window
" ----------------
set pumheight=15         " max number of things to show in pop-up-menu
" avoid "press enter to continue" screens
"set cmdheight=2
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
