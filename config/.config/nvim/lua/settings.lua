vim.o.number         = true
vim.o.rnu            = false
vim.o.compatible     = false
vim.o.showcmd        = false
vim.o.incsearch      = true
vim.o.expandtab      = true
vim.o.shiftwidth     = 2
vim.o.tabstop        = 2
vim.o.softtabstop    = 2
vim.o.termguicolors  = true
vim.o.syntax         = false
vim.o.encoding       = "utf-8"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.guioptions     = ""
vim.g.mapleader      = " "

-- Allow switching buffers without saving them
vim.o.hidden = true

-- Performance related
vim.o.timeoutlen            = 1500
vim.o.wrap                  = false
vim.o.hlsearch              = false
vim.o.foldenable            = false
vim.o.ttyfast               = true
vim.o.lazyredraw            = true
vim.o.cursorline            = true
vim.o.cursorlineopt         = "number"
vim.o.cursorcolumn          = false
vim.g.cursorhold_updatetime = 100

-- Don't load default vim plugins
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1

-- Leave these to lualine
vim.o.showmode    = false
vim.o.showtabline = false

-- Split more naturally
vim.o.splitbelow = true
vim.o.splitright = true

local autocmd = vim.api.nvim_create_autocmd

-- Start with an empty jumplist, to avoid jumps to other projects
autocmd('VimEnter', { pattern = '*', command = 'clearjumps' })

-- Prevent unwanted treatment of end in Ruby
-- https://github.com/tree-sitter/tree-sitter-ruby/issues/230
autocmd('Filetype', { pattern = { 'Ruby' }, command = 'setlocal indentkeys-=.'})
