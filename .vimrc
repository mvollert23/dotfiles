" VIM Configuration mvollert23.
" A lot of the content is taken from https://github.com/nilsonholger/dotfiles
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Plugin 'junegunn/fzf', {'do': './install --all'}
Plugin 'junegunn/fzf.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" General config

"
" SETTINGS
"
" basic
colorscheme industry							" so our eyes won't hurt
syntax on										" psychedelic rainbow
set background=dark								" so our eyes won't explode
set backspace=indent,eol,start					" allow backspacing over #args
set completeopt=menuone,menu,longest			" completion menu settings
set hidden										" if (hidden) do not unload abandoned buffer
set laststatus=2								" always display status line
set nomodeline									" dis-allow vim modelines
set modelines=0									" process #lines of modeline commands
set mouse=n										" clicketyclick
let &path = &path .. ",**;" .. getcwd()			" fallback search up/down all the way to current working directory
"set scrolloff=3									" always display #lines context
set showcmd										" display partial commands
set whichwrap=<,>,[,],h,l						" can move to next/previous line

" display
set conceallevel=2		" simply because
set fileformats+=mac	" cause we workin' on the fruity stuff
set foldmethod=syntax	" yes, we like folds, especially intelligent ones
set linebreak			" wrap looooooong lines
set list				" show listchars (see below)
set listchars=tab:\.\ ,trail:_,extends:>,precedes:<
set number				" show line numbers as default
set showbreak=_			" if (linebreaks) prepend to wrapped line
set splitbelow			" do it latin style
set splitright			" even more latin style

set autoindent		" indent current line -> indent new line
set encoding=utf-8	" character encoding
set fixendofline	" add newline to end of file(s)
set shiftwidth=4	" # of (auto)indent spaces
set smartindent		" smarter than cindent
set smarttab		" use shiftwidth for ^line tabs
set softtabstop=4	" while (editing) tab = width of # spaces
set tabstop=4		" tab = width of # spaces
set updatetime=100  " update window (and swap)



set gdefault	" default to global substitution
set hlsearch	" if (previous search pattern) highlight all matches
set ignorecase	" if (captain obvious is here) ignore comment
set incsearch	" while (typing search pattern) jump to first match
set magic		" magic chars in search pattern
set smartcase	" if (pattern has upper case char) ignore ignorecase


set statusline=%<%{FugitiveStatusline()}						" git status from fugitive
set statusline+=\ 												" space
set statusline+=%f\ %h%m%r%w									" file [help][modify][readonly][preview]
set statusline+=%=(%{&ft},%{strlen(&fenc)?&fenc:&enc},%{&ff})	" (filetype,encoding,fileformat)
set statusline+=\ 												" space
set statusline+=%-14.(%L,%l-%c%V%)\ %P							" numberOfLines,line-column-virtualColumn ruler

" Setup global undo directory
if !isdirectory($HOME."/.vim")
	    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
	    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile



let mapleader=' ' "

" Keymaps vim-fugitive
map <leader>gb :Git blame<cr>
map <leader>gc :Git commit<cr>
map <leader>gds :Gdiffsplit<cr>
map <leader>gdi :term git di<cr>
map <leader>ge :Gedit HEAD<cr>
map <leader>gf :Git fetch<cr>
map <silent> <leader>gg :GitGutterQuickFix<cr><cr><cr>:QFix<cr>
map <leader>gl :Gclog<cr><cr><cr>:QFix<cr>
map <leader>gp :Git push<cr>
map <leader>gr :Gread<cr>
map <leader>gs :Git<cr>
map <leader>gw :Gwrite<cr>

