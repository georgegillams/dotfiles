set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Language
Plugin 'fatih/vim-go'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'keith/swift.vim'
Plugin 'msanders/cocoa.vim'

" Linting
Plugin 'scrooloose/syntastic'
Plugin 'tokorom/syntastic-swiftlint.vim'
Plugin 'prettier/vim-prettier'
Plugin 'rhysd/clever-f.vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'w0rp/ale'

" Misc
Plugin 'RRethy/vim-illuminate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vimwiki/vimwiki'
Plugin 'wakatime/vim-wakatime'
"requires different colour scheme https://github.com/aseom/dotfiles/blob/master/osx/iterm2/iceberg.itermcolors
Plugin 'cocopon/iceberg.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'gorodinskiy/vim-coloresque'

call vundle#end()            " required
filetype plugin indent on    " required

colorscheme nord
set number
set shell=/bin/zsh\ -l
syntax on
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

"Nerdtree"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"AutoClose NerdTree if last file is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

" Check if NERDTree is open or active
 function! IsNERDTreeOpen()
   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
   endfunction

" Pins NERDTree to the left hand side
"
augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()
augroup END

function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
   function! SyncTree()
     if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
         NERDTreeFind
             wincmd p
               endif
               endfunction

               " Highlight currently open buffer in NERDTree
               autocmd BufEnter * call SyncTree()
"Prettier
let g:prettier#autoformat = 0

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.m,*.h,*.swift Prettier
autocmd BufWritePre *.m,*.h ClangFormat

let g:syntastic_swift_checkers = ['swiftlint']

" vim-airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
set laststatus=2

" Fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gl :Gpull<CR>
nmap <leader>gh :Gbrowse<CR>

"Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!

" Ale
"let g:ale_python_flake8_args="flake8"
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'go': ['gofmt'],
\   'python': ['flake8'],
\}
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

let g:vim_markdown_folding_disabled = 1

"Js
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1


"misc
set backspace=indent,eol,start
set number

" From https://statico.github.io/vim3.html
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
endfunction

command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>

"Custom Mapping
inoremap jj <Esc>

nnoremap <Leader>s :sv<CR>
nnoremap <Leader>v :vs<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>z :wq<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nmap <C-P> :GFiles<CR>
nmap <C-I> :Tags<CR>
nmap <Leader>c :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nmap <Leader>th :set hlsearch!<CR>
nmap <Leader>m :marks<CR>
nmap <Leader>r :reg<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>a :Ack!<Space>

" Movement
nnoremap J 6j
nnoremap K 6k
nnoremap H 6h
nnoremap L 6l
nnoremap B 6b
nnoremap W 6w

" Buffers
set hidden
nmap <leader>bb :Buffer<cr>
nmap <leader>T :enew<CR>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bl :ls<CR>
nmap <leader>bd :bd<CR>

:set mouse=a
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
