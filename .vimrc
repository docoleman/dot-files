" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
  set backupdir=~/.vimbackups//,.
  set directory=~/.vimbackups//,.
  set undodir=~/.vimundo//,.
endif

set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase          " case insensitive searching...
set smartcase           " ...unless there are caps in the search
set showmatch
set lazyredraw
set scrolloff=7
set encoding=utf8
set nowrap		" Unsure if this is good or not...
set visualbell		" Flash the screen instead of making noise
set laststatus=2

set t_vb=		" Reset the terminal code for the visual bell. If
			" visual bell is set and this line is included, vim
			" will not beep or flash

set mouse=		" Reset the terminal code for taking mouse input

let mapleader=","
let g:mapleader=","

" Don't use Ex mode, use Q for formatting
map Q gq
nmap k gk
nmap j gj
nmap <leader>w :wa<cr>
map <silent> <leader><cr> :noh<cr>

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  syntax on

  " Also switch on highlighting the last used search pattern.
  set hlsearch

  set background=dark
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " For css use short tabs
  "autocmd FileType css setlocal tabstop=2

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
