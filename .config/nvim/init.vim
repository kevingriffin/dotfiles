call plug#begin('~/.local/share/nvim/plugged')

""" Language and syntax
Plug 'leafgarland/typescript-vim'
Plug 'chr4/nginx.vim'
Plug 'LnL7/vim-nix'
Plug 'bumaociyuan/vim-swift'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'

""" Movement
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'

""" Text editing augmentation
Plug 'ddollar/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'maxbrunsfeld/vim-emacs-bindings'
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-user'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-surround'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/sideways.vim'

""" Buffer window and file management
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'wesQ3/vim-windowswap'
Plug 'moll/vim-bbye'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'mileszs/ack.vim'

""" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

""" Appearence
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'morhetz/gruvbox'


if has("nvim")
  Plug 'davidmh/nvim-terminal-runner'
  set inccommand=nosplit
endif

call plug#end()

set nocompatible
set encoding=utf-8                   " Format of the text in our files (prob not necessary, but should prevent weird errors)
filetype plugin on                   " Load code that configures vim to work better with whatever we're editing
filetype indent on                   " Load code that lets vim know when to indent our cursor
syntax on
set nowrap                           " Display long lines as truncated instead of wrapped onto the next line
set number                           " Show line numbers
set nohlsearch                         " Highlight all search matches that are on the screen
set showcmd                          " Display info known about the command being edited (eg number of lines highlighted in visual mode)
set incsearch
set expandtab                        " When I press tab, insert spaces instead
set shiftwidth=2                     " Specifically, insert 2 spaces
set tabstop=2
set mouse=a
set noshowcmd                        " Don't show ^U etc in the status bar

if has('nvim') && $TERM_PROGRAM == "iTerm.app"
  set termguicolors
endif

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

if has("autocmd")
  filetype indent plugin on
endif

call expand_region#custom_text_objects({
\ 'ii' :0,
\ 'ai' :0,
\ })
call expand_region#custom_text_objects('ruby', {
\ 'ib' :0,
\ 'ab' :0,
\ 'im' :0,
\ 'am' :0,
\ 'iM' :0,
\ 'aM' :0,
\ })

" Using buffers like tabs in a GUI editor
set hidden
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

nnoremap <leader>pp "0p<CR>
nnoremap <leader>PP "0P<CR>

nnoremap <leader>"" vi""0p
nnoremap <leader>'' vi'"0p

""" Appearence and terminal settings
" Dark themes are cool
colorscheme gruvbox
set background=dark
set t_ut=

""" Use ripgrep
if executable('rg')
 " Use rg over grep
 set grepprg=rg\ --nogroup\ --nocolor

 " Use rg in CtrlP for listing files.
 let g:ctrlp_user_command = 'rg --files --hidden -g="!.git" --color never '

 " rg is fast enough that CtrlP doesn't need to cache
 let g:ctrlp_use_caching = 0

 let g:ackprg = 'rg --vimgrep'
endif


noremap <Leader>a :Ack <cword><cr>
xnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>

""" CtrlP
let g:ctrlp_max_history = 0
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_max_files=0
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

""" Keybinds
nnoremap <leader>q :Bdelete<CR>

""""""" MULTIPURPOSE TAB KEY

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

""""""""

"""""" Toggle quickfix faster

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! BufferIsOpen(bufname)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      return 1
    endif
  endfor
  return 0
endfunction

function! ToggleQuickfix()
  if BufferIsOpen("Quickfix List")
    cclose
  else
    cope
  endif
endfunction


nnoremap <leader>q :call ToggleQuickfix()<cr>

map <leader>m :w<CR><Plug>TermRunnerCmd be rspec<CR>

""" Nerd Tree
let NERDTreeQuitOnOpen = 1
nnoremap <leader>n :NERDTreeToggle<CR>

""" Multi cursor
" Stay in multiple cursor mode until canceled, for better movement
let g:multi_cursor_exit_from_insert_mode=0

""" Tabularize
if exists(":Tabularize")
  nmap <Leader>b= :Tabularize /=<CR>
  vmap <Leader>b= :Tabularize /=<CR>
  nmap <Leader>b: :Tabularize /:\zs<CR>
  vmap <Leader>b: :Tabularize /:\zs<CR>
endif

""" JSON
let g:vim_json_syntax_conceal = 0

""" Sideways.vim
nnoremap <, :SidewaysLeft<cr>
nnoremap >, :SidewaysRight<cr>

""" JSX highlighting
let g:jsx_ext_required = 0

""" Terminal colors for neovim

if has('nvim')
  " dark0 + gray
  let g:terminal_color_0 = "#282828"
  let g:terminal_color_8 = "#928374"

  " neurtral_red + bright_red
  let g:terminal_color_1 = "#cc241d"
  let g:terminal_color_9 = "#fb4934"

  " neutral_green + bright_green
  let g:terminal_color_2 = "#98971a"
  let g:terminal_color_10 = "#b8bb26"

  " neutral_yellow + bright_yellow
  let g:terminal_color_3 = "#d79921"
  let g:terminal_color_11 = "#fabd2f"

  " neutral_blue + bright_blue
  let g:terminal_color_4 = "#458588"
  let g:terminal_color_12 = "#83a598"

  " neutral_purple + bright_purple
  let g:terminal_color_5 = "#b16286"
  let g:terminal_color_13 = "#d3869b"

  " neutral_aqua + faded_aqua
  let g:terminal_color_6 = "#689d6a"
  let g:terminal_color_14 = "#8ec07c"

  " light4 + light1
  let g:terminal_color_7 = "#a89984"
  let g:terminal_color_15 = "#ebdbb2"
endif

""" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

nmap <Space> <Plug>(easymotion-overwin-f)
nmap <C-Space> <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

""" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Tab> <C-W><C-W>
nnoremap <S-Tab> <C-W>W

""" GUI options
set guioptions=

""" neomake
" Run eslint for JavaScript files.
"let g:neomake_javascript_enabled_makers = ['eslint']
" Prefer local eslint install over global binary.
" Copied from https://github.com/benjie/neomake-local-eslint.vim/blob/master/ftplugin/javascript.vim
"let s:eslint_path = system('set -gx PATH (npm bin) $PATH ; and which eslint')
"let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" Run Neomake on save.
"autocmd BufWritePost * Neomake

""" For TouchBar, but can also be used from Fkeys
nnoremap <F8> <C-w><C-=>
if exists(":Tabularize")
  nmap <F9> :Tabularize /=<CR>
  vmap <F9> :Tabularize /=<CR>
  nmap <F10> :Tabularize /:\zs<CR>
  vmap <F10> :Tabularize /:\zs<CR>
endif

nnoremap <F11> :vs<CR>
nnoremap <F12> :sp<CR>

nnoremap <F5> :call WindowSwap#EasyWindowSwap()<CR><C-W><C-H> :call WindowSwap#EasyWindowSwap()<CR>
nnoremap <F6> :call WindowSwap#EasyWindowSwap()<CR><C-W><C-J> :call WindowSwap#EasyWindowSwap()<CR>
nnoremap <F7> :call WindowSwap#EasyWindowSwap()<CR><C-W><C-K> :call WindowSwap#EasyWindowSwap()<CR>
nnoremap <F8> :call WindowSwap#EasyWindowSwap()<CR><C-W><C-L> :call WindowSwap#EasyWindowSwap()<CR>

set splitbelow
set splitright

""" Lightline customization
set showtabline=2
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
" No need with lightline
set noshowmode

""" Buffers as tabs
let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [[]] }
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
