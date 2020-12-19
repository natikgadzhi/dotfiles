"" Basics
"
set nocompatible
syntax on               " highlight syntax

set backspace=2         " backspace in insert mode works like normal editor
filetype plugin on
filetype indent on
set number
set autoread

let g:netrw_list_hide = '.git, .*\.swp, .DS_Store'
let g:netrw_altv = 1
let g:netrw_liststyle = 3

"" MacVim UI settings
"
if has("gui_running")
    set macligatures
    set guifont=Fira\ Code\ Retina:h15
    set linespace=2
    set guioptions=
endif


"" Performance
"
set ttyfast
set lazyredraw
set noshowcmd


"" Clipboard
"
set clipboard=unnamed
nmap <Leader>p "*p
nmap <Leader>y "*y


"" Folding
"
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2


"" Navigate Splits
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"" Searching
"
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  let g:ackprg = 'ag --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" bind K to grep word under cursor
" to look up whole project for the word
nnoremap K :Ack "<C-R><C-W>" <CR>:cw<CR>


" Jump to defenition (ctags)
" and jump to an open buffer with ctrlp
"
command! MakeTags !ctags -R . --exclude coverage --exclude .git
nnoremap <C-d> :CtrlPTag<cr>
nnoremap <C-b> :CtrlPBuffer<cr>


"" Indentations based on file types
"
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype swift setlocal ts=4 sw=4 sts=0 expandtab


"" Don't use ~, .swp and all that bullshit.
"
set nobackup
set noswapfile
set nowb
set nowrap


"" Search in file.
"  Use incremental (browser-like) search, highlight matches.
"
set hlsearch
set showmatch
set incsearch


"" Use 2 spaces for tabulation.
"
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" Vim behaves unexpectedly with fish as shell, so set sh as the default shell
" instead.
if &shell =~# 'fish$'
  set shell=sh
endif

" setup ale completion before it loads
" " Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1
" Disable vim-go completion by default and handle it with ALE
let g:go_code_completion_enabled = 0
set omnifunc=ale#completion#OmniFunc

set mouse=a
set ttymouse=xterm
let g:ale_set_balloons = 1


call plug#begin('~/.vim/plugged')

" Github integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

"Basics
Plug 'kien/ctrlp.vim'
Plug 'lokikl/vim-ctrlp-ag'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar' "Netrw
Plug 'chriskempson/base16-vim'
Plug 'tmhedberg/SimpylFold'

" Tmux integration <3
Plug 'christoomey/vim-tmux-navigator'

" Sets up path for JVM langs (like Clojure)
Plug 'tpope/vim-classpath', {'for': 'clojure' }

" Syntax
Plug 'dense-analysis/ale'

" Langs
" Ruby and Rails
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'vim-ruby/vim-ruby'

" Fish config
Plug 'dag/vim-fish'

" HTML & CSS
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'slim-template/vim-slim'
Plug 'ap/vim-css-color'

" Shell
Plug 'vim-scripts/sh.vim'

" Golang
Plug 'fatih/vim-go'
Plug 'tpope/vim-bundler'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'keith/swift.vim'

" Clojure
Plug 'guns/vim-clojure-static', {'for': 'clojure' }
Plug 'kien/rainbow_parentheses.vim', {'for': 'clojure' }
Plug 'tpope/vim-fireplace', {'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', {'for': 'clojure' }

"" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'



" Initialize plugin system
call plug#end()

" Use plugins to indent code
filetype plugin indent on

"" Search with CtrlP
"
nnoremap <C-f> :CtrlPag<cr>
vnoremap <C-f> :CtrlPagVisual<cr>
nnoremap <leader>ca :CtrlPagLocate
nnoremap <leader>cp :CtrlPagPrevious<cr>

let g:ctrlp_ag_ignores = '--ignore .git
    \ --ignore "deps/*"
    \ --ignore "_build/*"
    \ --ignore "node_modules/*"
    \ --ignore "coverage/*"'
" By default ag will search from PWD
" But you may enable one of below line to use an arbitrary directory or,
" Using the magic word 'current-file-dir' to use current file base directory
" let g:ctrlp_ag_search_base = 'current-file-dir'
" let g:ctrlp_ag_search_base = 'app/controllers' " both relative and absolute path supported

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg
let g:ctrlp_custom_ignore = 'node_modules\|\v[\/]\.(git|hg|svn)$'


"" Gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_override_sign_column_highlight = 0

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

"" vim-go config
"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"" Ale Linters
"
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '🔺'
let g:ale_sign_warning = '⚠'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_set_highlights = 1
let g:ale_python_auto_pipenv = 1

let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'go': ['gopls']
\}

let g:ale_fixers = {
\   'python': ['black', 'flake8'],
\   'swift': ['swiftformat', 'remove_trailing_lines', 'trim_whitespace'],
\   '*': ['prettier', 'remove_trailing_lines', 'trim_whitespace']
\}

nnoremap <leader>jd :ALEGoToDefinition<CR>

"" Tabs / buffers
"
let g:airline#extensions#tabline#enabled = 1

"" Colorscheme
"
set background=dark

"" Airline
" Powerline characters might cause remote machines to render weird chars
" instead of symbols, so better to just disable those.
" set laststatus=2
let g:airline_powerline_fonts = 1

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tmuxline = 1
let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

let g:airline_theme = 'powerlineish'

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'y'    : ['%I:%M %p %b %d, %a'],
      \'z'    : '#H'}


"" GitGutter
"
highlight clear SignColumn
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=black
highlight GitGutterAdd ctermbg=black ctermfg=green
highlight GitGutterChange ctermbg=black ctermfg=yellow
highlight GitGutterDelete ctermbg=black ctermfg=red
highlight GitGutterChangeDelete ctermbg=black ctermfg=red
highlight SignColumn guibg=black


"" Markdown Folding
"
let g:vim_markdown_folding_disabled = 1

"" Tmux Integration
"
" Save on switching out of pane: only this buffer (1) or all buffers (2)
let g:tmux_navigator_save_on_switch = 1

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
