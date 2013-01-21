set nocompatible

" VUNDLE {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sbl/scvim'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'SirVer/ultisnips'
" snipmate
" Bundle 'gmarik/vundle'
" Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'
" Bundle 'honza/snipmate-snippets'
" Bundle 'garbas/vim-snipmate'

" }}}

" plugin settings {{{

" load filetype plugins
filetype plugin on

let NERDTreeIgnore = ['\.class$', '\~$', '\.o$', '\.obj$', '\.pyc$', '\.wav$']

" make powerline use solarized colors
set encoding=utf-8
let g:Powerline_symbols = 'fancy'
" let g:Powerline_colorscheme = 'solarized256'

" Syntastic
let g:syntastic_python_checker = 'flake8'

" NERDcommenter
let g:NERDRemoveExtraSpaces=1
let g:NERDSpaceDelims=1

" Ctrl-p
" from https://gist.github.com/67de417c5c38f0ff8093
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
    \ 'file': '\.exe$\|\.so$\|\.dat$'
    \ }
let g:solarized_termcolors=256

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
    endif
else
    " set bg=dark
    colorscheme Tomorrow-Night
endif
" set listchars=eol:¬,extends:»,tab:▸\ ,trail:›
" set list

" }}}

" editing {{{
set number " line numbers
set mouse=a " can use mouse
set go-=T " hide MacVim toolbar
set splitbelow " split windows open below current window
set textwidth=79 " max. width of text being inserted
set scrolloff=5 " scrolling starts 5 lines from top or bottom of page
set laststatus=2 " always show status bar
set cursorline " get line highlighted
set autoindent                      " always set autoindenting on
set expandtab                       " This makes them all spaces.
set shiftwidth=4                    " autoindent n spaces (not 8) (shiftwidth)
set softtabstop=4                   " Let's have better tabbing (never change tab size!)
set backspace=2                     " allow backspacing over everything in insert mode
set cinkeys=0{,0},0),0#,;,:,o,O,e   " when to re-indent the current line in C languages
set indentkeys=o,O,:,0#,e           " when to re-indent the current line in non-C languages
filetype plugin indent on           " sets indentation based on file type
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
set laststatus=2        " always show the status bar
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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-l> :tabnext<CR>
nnoremap <S-h> :tabprevious<CR>
inoremap kj <Esc>
inoremap jk <Esc>
nnoremap ; :
vnoremap ; :
nnoremap <Space> za
vnoremap <Space> za
nnoremap <Tab> ==
vnoremap <Tab> =
map Y y$ " makes Y yank till end of line
nnoremap j gj
nnoremap k gk
inoremap <C-@> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>
nnoremap <Leader>s :w<CR>
" PLUGIN remaps
map <Leader>n :NERDTreeToggle<CR>
map <Leader>cc <plug>NERDCommenterToggle " TODO: why isn't this working?
nnoremap <Leader>t :TagbarToggle<CR>
map <Leader>hc :r ~/.vim/honorcode.txt<CR>
" }}}

" autocmds, filetype options {{{

" reload .vimrc whenever saved -- from https://gist.github.com/1988620
augroup AutoReloadVimRC
  au!
  " automatically reload vimrc when it's saved
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" compiling
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" lets me have man pages in their own window and syntax colored
autocmd BufRead,BufEnter *.{c,cpp,h} source ~/.vim_macros/manpages-functions.vim
" autocmd BufRead,BufEnter *.py source ~/.vim_macros/pydoc-functions.vim

" good for editing text files - Auto-formats paragraphs as they're changed
"autocmd BufRead,BufEnter,BufNewFile *.txt set formatoptions+=a autocmd
"BufRead,BufEnter,BufNewFile README set formatoptions+=a

" OMNICOMPLETION
" from http://blog.fluther.com/django-vim/
" must run "DJANGO_SETTINGS_FILE=myapp.settings vim" to work
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType python setlocal omnifunc=pysmell#Complete

" COMPILING
autocmd FIletype java setlocal makeprg=javac\ %

" }}}

" misc {{{

" make autocomplete AWESOME
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.class

" no beeping, please
set visualbell t_vb=
set novisualbell

" from http://stackoverflow.com/questions/5793294/vim-cr-mapping-not-working
" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" insert current path into command prompt
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>

" quick-fix window
" ----------------
set pumheight=5         " max number of things to show in pop-up-menu
" avoid "press enter to continue" screens
"set cmdheight=2
nnoremap <Leader>v :tabnew ~/.vim/vimrc<CR>

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
    hi TabLineSel ctermbg=blue ctermfg=white cterm=bold
    hi TabLine    cterm=reverse ctermfg=darkgray ctermbg=white
    hi TabLineFill ctermbg=darkgray ctermfg=darkgray

    " color fixes
    highlight MatchParen ctermbg=blue
    "highlight PmenuSel ctermfg=black ctermbg=lightgray 
endif

if has("spell")
    "set spell
    set spelllang=en_us
   "set spellfile=~/.vim/spell/en.latin1.add,~/.vim/spell/cs.latin1.add,~/.vim/spell/latex.latin1.add
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
