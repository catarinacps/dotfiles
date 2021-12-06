" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Here so plugins behave
filetype indent off
syntax off

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

" Rainbow delimiters
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Autoformatting using sane default tools
Plug 'Chiel92/vim-autoformat'
let g:python3_host_prog = '/usr/bin/python'
let b:formatdef_clang_format ='"clang-format --style=WebKit"'
let b:formatters_c = ['clang_format']
let b:formatters_cpp = ['clang_format']
let b:formatters_cu = ['clang_format']

" prettier syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Surround
Plug 'tpope/vim-surround'

" Repeat cool commands
Plug 'tpope/vim-repeat'

" Coerce stuff (like lots of different stuff)
Plug 'tpope/vim-abolish'

" Indent guides!
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '|'

" Multiple cursor
Plug 'mg979/vim-visual-multi'

" Somewhat smart pairing
Plug 'tmsvg/pear-tree' 

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=1

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=10

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Cursor motion
set scrolloff=10
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs

" Visualize tabs and newlines
set listchars=tab:▸\ 
set list " To enable by default

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:gruvbox_italicize_strings = 0
colorscheme gruvbox8

" Encoding
set encoding=utf-8

" Search settings
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" Keybindings
nnoremap <SPACE> <Nop>
let mapleader = " "

" Leader keybindings
nnoremap <leader>s :update<cr>
nnoremap <leader>i :Autoformat<cr>
nnoremap <leader>k :q<cr>

" Common keybindings
nnoremap Y y$
nnoremap zz :update<cr>


set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set cursorline
set cindent
set clipboard=unnamedplus
set textwidth=84
set colorcolumn=+1
