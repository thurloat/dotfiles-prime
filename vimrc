" Loadder pathogen

source ~/.vim/bundle/pathogen/autoload/pathogen.vim
set nocompatible

set guioptions=aAce
set guifont=Droid\ Sans\ Mono:h12
set linespace=-2

" Silence please
set vb
set t_vb=

" Pathogen
call pathogen#infect('bundle/{}')

" Change the leader to ,
let mapleader = ","
let maplocalleader = "\\"

" Basic Configuration {{{ 
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set expandtab
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set textwidth=79  " wrap lines at 79 characters
set relativenumber
set number
set autoread      " Reload the files if they changed on disk!
set ruler
set cursorline
set nojoinspaces
set cpoptions+=J  " Two spaces to end a sentence

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

if has('mouse')
    set mouse=a
endif

" Save on lose focus
au FocusLost * :wa

" wild menu completion {{{
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=_build                           " Sphinx build dir
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store?                      " OSX bullshitset wildignore+=.hg,.git,.svn
set wildignore+=*.CACHE                          " django-compressor cache dir
set wildignore+=*.jhw-cache                      " jasmine headless webkit cache directory
set wildignore+=htmlcov                          " code coverage report output directory
set wildignore+=build
set wildignore+=node_modules
set wildignore+=CACHE
set wildignore+=static_collected                 " django's compiled static dir
" }}}

" Abbreviations {{{ 
iabbrev CA Cloud-A
iabbrev t@ thurloat@gmail.com
iabbrev a@ adam@clouda.ca
" }}}

" Folding {{{
set foldlevelstart=0
set foldmethod=marker
nnoremap <Space> za
vnoremap <Space> za
nnoremap zO zCzO
" }}}

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

" }}}
"
" Remaps {{{

nnoremap j gj
nnoremap k gk

" Remap : to ;
nnoremap ; :
vnoremap ; :

" If I actaully ever want to use a real tab...
inoremap <S-Tab> <C-V><Tab>

" Run Python script through PEP8
map <buffer> <leader>p :w<CR>:!pep8 % <CR>

" Python Rope
noremap <C-c>r :RopeRename<CR>
noremap <C-c>i :RopeAutoImport<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Open a new split and switch to it
nnoremap <leader>w <C-w>v<C-w>1

" Simple clearing of search results
nmap <silent> ,/ :nohlsearch<CR>

" Strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>wr 078lBi<CR><ESC>0

" HTML tag folding
nnoremap <leader>ft Vatzf

" Toggle whitespace characters
nmap <leader>l :set list!<cr>
set listchars=trail:_
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.\+/

" Quick Edits 
map <leader>v :vs ~/.vimrc<CR><C-W>
map <silent> <leader>V :source ~/.vimrc<CR>
map <leader>b :vs ~/.bashrc<CR><C-W>

" }}}

" Filetype Specifics {{{
au FileType javascript setlocal tabstop=2 shiftwidth=2
let g:syntastic_javascript_checkers = ['jslint', 'gjslint']
au FileType coffee setlocal tabstop=2 shiftwidth=2

au BufNewFile,BufRead *.html setlocal filetype=htmldjango
au BufNewFile,BufRead *.soy setlocal filetype=htmldjango
au FileType htmldjango setlocal textwidth=0

au Filetype rst nnoremap <leader>1 yypVr=
au Filetype rst nnoremap <leader>2 yypVr-
au Filetype rst nnoremap <leader>3 yypVr~
au Filetype rst nnoremap <leader>4 yypVr`
au Filetype rst set spell spelllang=en_ca
au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
au Filetype markdown set spell spelllang=en_ca


" }}}
"
" Open help files in a vertical split
au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif

au BufNewFile,BufRead *.j setlocal filetype=objj

let g:syntastic_enable_signs=1
let g:snips_author="Adam Thurlow"

" Status line stuff
" set statusline=%F%m%r%h%w%=%{fugitive#statusline()}%y\[%l\/%L,%c]
set laststatus=2

set scrolloff=3

" tagbar
let g:tagbar_sort = 0
let g:tagbar_ctags_bin="/usr/bin/ctags"
nmap <leader>d :TagbarToggle<CR>
map <C-w>t 99<C-w>l

" Don't displal manual
nnoremap K <nop>

" Make vim able to edit crontab
set backupskip=/tmp/*,/private/tmp/*"
" Keep splits sized properly
au VimResized * exe "normal! \<cw>="

" Uppercase
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

" Format
nnoremap Q gqip

" Start clipboard copy
nnoremap <leader>c "+

" vagrant
au BufRead,BufNewFile Vagrantfile set ft=ruby

" Substitute
nnoremap <leader>s :%s//g<left><left>

function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

command! -nargs=* Only call CloseHiddenBuffers()

nmap \ <Plug>CommentaryLine

" ctrlp
let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cache_dir = '~/.vim/tmp/ctrlp'
nmap <leader>f :ClearCtrlPCache<cr>

" NerdTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeBookmarksFile = '~/.vim/bookmarks'
let g:NERDTreeIgnore = ['\.pyc$', '\.DS_Store']
map <leader>n :NERDTreeToggle<CR>

" Fugitive
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>

" Powerline
let g:Powerline_cache_enabled = 1

hi link coffeeObject NONE
hi link coffeeBracket NONE
hi link coffeeCurly NONE
hi link coffeeParen NONE
hi link coffeeSpecialVar Identifier

let coffee_linter = "/usr/local/bin/coffeelint"
nmap <leader><C-w>l :CoffeeLint | cwindow

syntax enable
set background=light
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 0
colorscheme badwolf
" LuciusWhite

" python-mode
let g:pymode_virtualenv = 1
let g:pymode_folding = 0 
let g:pymode_utils_whitespaces = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint_unmodified = 0
let g:pymode_lint_ignore = "E301"
let g:pymode_lint_on_fly = 1

nmap <leader>@ :PymodeLintAuto<CR>
