set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set mouse=a
call vundle#begin()

" All of your Plugins must be added before the following line
Plugin 'bling/vim-airline'
Plugin 'mxw/vim-jsx'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'christoomey/vim-sort-motion'
Plugin 'mjbrownie/browser.vim'
Plugin 'w0rp/ale'
Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plugin 'pangloss/vim-javascript'
Plugin 'kien/ctrlp.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'rakr/vim-one'
Plugin 'joshdick/onedark.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'tpope/vim-commentary'
Plugin 'stephenmckinney/vim-solarized-powerline'
Plugin 'lifepillar/vim-solarized8'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'shougo/neocomplete.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ruanyl/vim-fixmyjs'
Plugin 'moll/vim-node'
Plugin 'beautify-web/js-beautify'
Plugin 'mitermayer/vim-prettier'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'gcorne/vim-sass-lint'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'easymotion/vim-easymotion'
Plugin 'davidhalter/jedi-vim'
Plugin 'cloudhead/neovim-fuzzy'
Plugin 'flowtype/vim-flow'
Plugin 'lervag/vimtex'
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

autocmd vimenter * NERDTree
filetype plugin on
syntax on
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark
colorscheme solarized8_flat

set statusline+=%#warningmsg#
set statusline+=%*

"Fix my js"
 let g:fixmyjs_rc_path = '/Users/georgegillams/Documents/projects/backpack/.eslintrc'
 " let g:fixmyjs_engine = 'fixmyjs'

set number
set expandtab ts=4 sw=4 ai
set guifont=Fira\ Mono\ for\ Powerline

"vim-airline"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline_theme='one'

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs :Fixmyjs
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql Prettier

let g:sass_lint_config ='/Users/georgegillams/Documents/projects/backpack/.stylelintrc.json'

nnoremap <C-p> :FuzzyOpen<CR>

" Use deoplete.
let g:deoplete#enable_at_startup = 1
