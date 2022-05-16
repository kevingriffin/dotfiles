vim.o.number         = true
vim.o.rnu            = false
vim.o.compatible     = false
vim.o.showcmd        = false
vim.o.incsearch      = true
vim.o.expandtab      = true
vim.o.shiftwidth     = 2
vim.o.tabstop        = 2
vim.o.termguicolors  = true
vim.o.syntax         = false
vim.o.encoding       = "utf-8"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.guioptions     = ""
vim.g.mapleader      = " "


vim.o.hidden = true

-- Performance related
vim.o.timeoutlen            = 500
vim.o.wrap                  = false
vim.o.hlsearch              = false
vim.o.foldenable            = false
vim.o.ttyfast               = true
vim.o.lazyredraw            = true
vim.o.cursorline            = false
vim.o.cursorcolumn          = false
vim.o.relativenumber        = false
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

-- Leave this to filetype.nvim
vim.g.did_load_filetypes = 1

-- Strip trailing whitespace on save
vim.cmd('autocmd BufWritePre * :%s/\\s\\+$//e')
