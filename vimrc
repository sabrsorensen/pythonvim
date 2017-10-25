set nocompatible              " required
filetype off                  " required

" Be careful about what you execute
set secure

" set the runtime path to include Vundle and initialize
if has('win32')
    set rtp+=$USERPROFILE/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$USERPROFILE/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'Townk/vim-autoclose'
Plugin 'ryanoasis/vim-devicons' " TODO Need to fix icons in PuTTY
Plugin 'benmills/vimux' " Use VimuxRunCommand to run shell commands in a mini-tmux pane
Plugin 'sabrsorensen/searchtasks.vim' " Search for TODO, FIXME, and XXX in comments
"Plugin 'janko-m/vim-test' " TODO launch tests from vim
"Plugin 'tpope/vim-dispatch' " TODO asynchronous compilers
"Plugin 'Shougo/deoplete.nvim' " Interesting replacement for YCM? Check out Neovim?
"Plugin 'godlygeek/tabular' " TODO autoalign text


" All of your Plugins must be added before the following line
call vundle#end()            " required

" We should autocmd available, but better to check just in case
if has('autocmd')
    " Enable detection of filetypes, loading plugins based on filetype, and
    " specific indentation rules based on type
    filetype plugin indent on
endif

" Enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" Theme settings
set background=dark
" Set terminal colors to 256
set t_Co=256
if has('gui_running')
  colorscheme solarized
else
  colorscheme zenburn
endif

" New splits will be created below or to the right of the current window
set splitbelow
set splitright

" Set encoding to UTF8 for better compatibility
set encoding=utf-8

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space><space> za

" Use <F4> to toggle Paste mode
set pastetoggle=<F4>

" Use 0 to jump to the beginning of the line
map 0 ^

" Map jj to Esc
inoremap jj <Esc>

" Set map leader to do extra key combinations
let mapleader = " "
let g:mapleader = " "
" <Space>+w will force save
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>x :wq!<cr>
nmap <leader>r :source $MYVIMRC<cr>

" Show docstrings of folded code:
let g:SimpylFold_docstring_preview=1

" Disable text wrapping for long lines
set nowrap

" Make certain characters (tab, trailing spaces, wrapped text) be more visible
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+
highlight SpecialKey ctermbg=red
"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
" Check for extra whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Ignore certain files in NERDTRee
let NERDTreeIgnore=['\.pyc$', '\~$']
" Auto-open NERDTree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Use <F7> to toggle NERDTree
map <F7> :NERDTreeToggle<CR>
" Close vim if NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Replace the default symbols with something more PuTTY friendly.
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" Show line numbers
set number
" Set <F5> to toggle line numbers
nnoremap <F5> :set nonumber!<CR>
" Enable highlighting of the current line
set cursorline
set cursorcolumn

" New lines copy the previous line's indentation
set autoindent
" Automatically indent after {, before }, and after keywords from cinwords
set smartindent

" Backspace over autoindents, line breaks, and the start of Insert mode
set backspace=indent,eol,start

" Searching options
" Incremental search, highlight matches as pattern is typed
set incsearch
" Highlight all matches of previous search pattern
set hlsearch
" Ignore case in search pattern by default
set ignorecase
" Override ignorecase if search pattern contains uppercase letters
set smartcase

" Use shiftwidth when Tab-ing at the beginning of the line, tabstop or
" softtabstop elswhere
set smarttab

" Show command mode on the last line
set showcmd

" Enhanced command-line completion
set wildmenu
" Tab-complete to longest common match, second press will list matches
set wildmode=list:longest,full
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.hi

" When a new bracket is inserted, briefly jump to the matching bracket
set showmatch
" Display matching bracket for 0.2 seconds
set matchtime=2

" Scroll when the cursor is close to the bottom line/last column
if !&scrolloff
    set scrolloff=10
endif
if !&sidescrolloff
    set sidescrolloff=10
endif

" Display as much of the last line as possible
set display+=lastline

" Read the file when it changes elsewhere
set autoread

" 4 column tabs
set tabstop=4
" 4 spaces when I hit Tab
set softtabstop=4
" (Un)indent by 4 columns when using << or >>
set shiftwidth=4
" No tabs here
set expandtab

" Highlight when the line is getting too long
set colorcolumn=110

" Set status line to include Paste status, current directory, modification
" time, etc
" vim-airline replaces the statusline
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ CWD:%r%{getcwd()}%h\ [Mod\ Time:\ %{strftime(\"%H:%M:%S\",getftime(expand(\"\%\%\")))}]
set laststatus=2

" Enable mouse usage
set mouse=a

" Tagbar configuration
nmap <F8> :TagbarToggle<CR>

" YouCompleteMe semantic completion
" Using http://www.alexeyshmalko.com/2014/youcompleteme-ultimate-autocomplete-plugin-for-vim/
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_collect_identifiers_from_tags_files = 1
" Use TAB or Down arrow to cycle through completions
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" Use Enter to close the completion window
let g:ycm_key_list_stop_completion = ['<Enter>']

" Autoclose YouCompleteMe preview window
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" <leader>g to jump to definition or declaration
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" vim-airline configuration
let g:airline_powerline_fonts = 0

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 1
let g:syntastic_aggregrate_errors = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1

" Syntastic C++ settings
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_cpp_include_dirs = [ '../inc/', '../lib/', 'inc', 'lib' ]

" Syntastic Python settings
" Disabling PyLint until the configuration can be determined
let g:syntastic_python_checkers = ['flake8']
" E501: line length greater than 79 chars
" E221: multiple spaces after operator
" E203: Whitespace preceeding :
let g:syntastic_python_flake8_args='--ignore=E501,E203,E221'
"let g:syntastic_python_pylint_args='--module-rgx="([a-z]+[A-Z]+\\w+)+"'


" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
