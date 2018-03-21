set nocompatible               " be eMproved
filetype off                   " required!

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Language Support
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'keith/swift.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'plasticboy/vim-markdown'
Plugin 'rust-lang/rust.vim'
Plugin 'HerringtonDarkholme/yats.vim'

" Misc
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rizzatti/dash.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'

" Color Schemes
Plugin 'altercation/vim-colors-solarized'
call vundle#end()

set number
set shell=/bin/zsh\ -l
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set noswapfile
set nocursorline
set nocursorcolumn
set background=dark
set smartcase
set lazyredraw
let mapleader = ' '
colorscheme solarized
set list
set listchars=eol:¬

" Remap
vnoremap . :norm.<CR>
inoremap jk <ESC>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>z :wq<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap <Leader>s :sv<CR>
nnoremap <Leader>v :vs<CR>

" Windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffers
set hidden

" Navigation
nnoremap <leader>] :YcmCompleter GoTo<CR>

set ruler
set colorcolumn=120

" Python
let g:loaded_python_provider = 1
let g:python3_host_prog = '/Users/hugotunius/Envs/nvim/bin/python'

" vim-airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_theme = 'powerlineish'
set laststatus=2
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>bb :Buffer<cr>
nmap <C-P> :Files<CR>
nmap <C-I> :Tags<CR>

" You complete me
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_keep_logfiles=1

" Strip whitespace on save
autocmd BufWritePre * :%s/\s\+$//e


" Ignores for NERDTree
let NERDTreeIgnore = ['\.pyc$']
nnoremap <silent> <F8> :NERDTreeToggle<CR>

" Dash
nmap <silent> <leader>d <Plug>DashSearch

" vim-jsx
let g:jsx_ext_required = 0

let g:ycm_filetype_specific_completion_to_disable = {
  \'ruby': 1
  \}
let g:javascript_plugin_flow = 1


" Ale
"let g:ale_python_flake8_args="flake8"
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint', 'flow'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error='✘'
let g:ale_sign_warning='▲'

let g:ale_echo_msg_error_str = '✘'
let g:ale_echo_msg_warning_str = '▲'
let g:ale_echo_msg_format = '%severity% [%linter%] %s'

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_open_list = 0
nmap <silent> <C-a> :ALEDetail<CR>

let g:vim_markdown_folding_disabled = 1

" Fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gl :Gpull<CR>
nmap <leader>gh :Gbrowse<CR>

augroup ft_rb
    au!
    " fix the SLOOOW syntax highlighting
    au FileType ruby setlocal re=1 foldmethod=manual nocursorline
augroup END

" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_command = "cargo fmt -- "

" From https://statico.github.io/vim3.html
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  if !has('gui_running')
    let g:solarized_termcolors=256
  endif
  colors solarized
endfunction

command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>

" Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

