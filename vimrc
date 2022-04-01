" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

" Personal Settings
inoremap jk <Esc>
set laststatus=2
set hidden
set number
set t_Co=256
let mapleader="\<Space>"
let maplocalleader="\<Space>"
set mouse=n
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set term=screen-256color
set incsearch
set omnifunc=syntaxcomplete#Complete
set encoding=utf-8

" adding spaces in insert mode
nnoremap [<Space> O<Esc>
nnoremap ]<Space> o<Esc>

" Automatically install vim-plug if not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'tpope/vim-surround'
Plug 'Valloric/ListToggle'
" Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'maralla/completor.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'vim/killersheep'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Valloric/ListToggle'
Plug 'eigenfoo/stan-vim'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
call plug#end()

" Vim Airline Settings
let g:airline_powerline_fonts = 1

" ALE settings
let g:ale_set_quickfix = 1
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_linters = {
\   'rust': ['analyzer', 'cargo'],
\   'python': ['flake8'],
\}

" yarp settings
let g:python3_host_prog = "/usr/bin/python3"

" ListToggle settings
let g:lt_location_list_toggle_map = '<leader>e'
let g:lt_quickfix_list_toggle_map = '<leader>e'
let g:lt_height = 5

"" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" ALE Rust settings
let g:ale_rust_cargo_use_check = 1

" Ultisnips settings
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-l>"

" Toggle Errors
function! ToggleErrors()
  let old_last_winnr = winnr('$')
  lclose
  if old_last_winnr == winnr('$')
    Errors
  endif
endfunction
nnoremap <silent> <leader>e :<C-u>call ToggleErrors()<CR>

" Colorscheme settings
colorscheme seoul256
let g:airline_theme='bubblegum'

"Completor settings
let g:completor_python_binary='/usr/bin/python3'
let g:completor_racer_binary='~/.cargo/bin/racer'

"Vimtex settings
let g:tex_flavor="latex"
