call plug#begin('~/.local/share/nvim/plugged')

""" Language and syntax
Plug 'leafgarland/typescript-vim'
Plug 'chr4/nginx.vim'
Plug 'LnL7/vim-nix'
Plug 'bumaociyuan/vim-swift'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'slim-template/vim-slim'
Plug 'dense-analysis/ale'

""" Movement
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'

""" Text editing augmentation
Plug 'ddollar/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'maxbrunsfeld/vim-emacs-bindings'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/sideways.vim'
Plug 'tpope/vim-tbone'
Plug 'junegunn/vim-peekaboo'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mbbill/undotree'

""" Buffer window and file management
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'moll/vim-bbye'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'mileszs/ack.vim'
Plug 'Valloric/ListToggle'

""" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

""" Appearence
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'morhetz/gruvbox'

""" Test runners and external enviornment
Plug 'tpope/vim-dispatch'

set inccommand=nosplit

call plug#end()

set nocompatible
set ttyfast
set lazyredraw
set nornu
set encoding=utf-8
filetype plugin on
filetype indent on
syntax on
set nowrap
set number
set nohlsearch
set showcmd                          " Display info known about the command being edited (eg number of lines highlighted in visual mode)
set incsearch
set expandtab                        " When tab is pressed, insert spaces instead
set shiftwidth=2                     " Specifically, insert 2 spaces
set tabstop=2
set mouse=a
set noshowcmd                        " Don't show ^U etc in the status bar

let g:mapleader=" "

""" Richer colors in supporting terminal emulators
if $TERM_PROGRAM == "iTerm.app"
  set termguicolors
endif

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

if has("autocmd")
  filetype indent plugin on
endif

" Using buffers like tabs in most editors
set hidden
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

nnoremap <leader>pp "0p<CR>
nnoremap <leader>PP "0P<CR>

nnoremap <leader>"" vi""0p
nnoremap <leader>'' vi'"0p


""" Appearence
colorscheme gruvbox
set background=dark
set t_ut=

""" Use ripgrep
if executable('rg')
 set grepprg=rg\ --nogroup\ --nocolor
 let g:ackprg = 'rg --vimgrep'
endif

""" fzf
nmap <C-p> :Files<CR>
" rg word under cursor
noremap <Leader>a :Rg <C-R><C-W><CR>

" Pass text right through to rg, but I'm not sure I like it yet
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, <bang>0)

nnoremap <leader><CR> :Buffers<CR>
nnoremap <leader>m    :Marks<CR>
nnoremap <leader>wi   :Windows<CR>
nnoremap <leader>/    :History/<CR>
nnoremap <leader>:    :History:<CR>


"" Load things into quickfix (like with :Rg)
"" and then open each one in a new tab,
"" split vertically or horizontally

function! QuickFixOpenAll(orientation)
  if empty(getqflist())
    return
  endif
  let modifier = "tabe"
  let s:prev_val = ""
  for d in getqflist()
    let s:curr_val = bufname(d.bufnr)
    if (s:curr_val != s:prev_val)
      exec modifier." " . s:curr_val
      let modifier = a:orientation . ' sb'
    endif
    let s:prev_val = s:curr_val
  endfor
endfunction

command! QuickFixOpenAllVertical call QuickFixOpenAll('vert')
command! QuickFixOpenAllHorizontal call QuickFixOpenAll('')
nnoremap <leader>oav :QuickFixOpenAllVertical<cr>
nnoremap <leader>oah :QuickFixOpenAllHorizontal<cr>

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
  \ }))

""" Tab key
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

" Push selection to file for copy elsewhere (via ssh)
vmap <Leader>z :w! /tmp/clip<CR>

""" Nerd Tree
let NERDTreeQuitOnOpen = 1
nnoremap <leader>n :NERDTreeToggle<CR>

""" Multi cursor
" Stay in multiple cursor mode until canceled, for better movement
let g:multi_cursor_exit_from_insert_mode=0

""" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""" JSON
let g:vim_json_syntax_conceal = 0

""" Sideways.vim
nnoremap <, :SidewaysLeft<cr>
nnoremap >, :SidewaysRight<cr>

""" JSX highlighting
let g:jsx_ext_required = 0

""" Terminal colors for neovim
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

""" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

nmap <leader>f <Plug>(easymotion-overwin-f)
nmap <leader>F <Plug>(easymotion-overwin-f2)

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

""" Quick previous file toggle
nnoremap <leader><leader> <c-^>

""" More natural split opening
set splitbelow
set splitright

""" Lightline customization
set showtabline=2
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
set noshowmode

""" Buffers as tabs
let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [[]] }
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
