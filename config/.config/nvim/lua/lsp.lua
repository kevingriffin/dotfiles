local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<Space>e', '<CMD>lua vim.diagnostic.open_float()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local lsp_status = require('lsp-status')
lsp_status.config({
  diagnostics = false,
  status_symbol = ''
})

local common = function(client, bufnr)
  local dynamic_workspace_symbols = function()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.lsp_dynamic_workspace_symbols({ symbols = { "constant", "class", "interface", "function", "method" } })
  end

  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gd',      '<CMD>lua vim.lsp.buf.definition()<CR>',      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gD',      '<CMD>lua vim.lsp.buf.declaration()<CR>',     opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gr',      '<CMD>lua vim.lsp.buf.references()<CR>',      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gi',      '<CMD>lua vim.lsp.buf.implementation()<CR>',  opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>D',       '<CMD>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space><Space>', '<CMD>lua vim.lsp.buf.hover()<CR>',           opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>rn',      '<CMD>lua vim.lsp.buf.rename()<CR>',          opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ca',      '<CMD>lua vim.lsp.buf.code_action()<CR>',     opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>fo',      '<CMD>lua vim.lsp.buf.format()<CR>',          opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>fs',     '<CMD>Telescope lsp_document_symbols<CR>',    opts)
  vim.keymap.set('n', '<Leader>fa', dynamic_workspace_symbols, bufopts)

  vim.diagnostic.config({
    virtual_text = false,
    signs        = false,
    underline    = false
  })
end


local servers    = {}
local candidates = { ["solargraph"] = 'solargraph', ["sourcekit-lsp"] = 'sourcekit' }
local coq        = require "coq"
local lspconfig  = require "lspconfig"

for executable, candidate in pairs(candidates) do
  if vim.fn.executable(executable) == 1 then
    table.insert(servers, candidate)
  end
end

local on_attach = function(client, bufnr)
  common(client, bufnr)
  lsp_status.on_attach(client)
end

local ts_on_attach = function(client, bufnr)
  common(client, bufnr)
  client.server_capabilities.documentFormattingProvider       = false
  client.server_capabilities.documentRangeFormattingProvider  = false
  lsp_status.on_attach(client)
end

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
  }))
end

-- Special settings for TypeScript
if vim.fn.executable('tsserver') == 1 and vim.fn.executable('node_modules/.bin/tsc') == 1 then
  require("typescript").setup({
      disable_commands = false,
      debug            = false,
      server           = coq.lsp_ensure_capabilities({on_attach = ts_on_attach})
  })
end

-- null-ls
local null_ls = require('null-ls')

local null_ls_sources = {
  null_ls.builtins.code_actions.gitsigns,
  require("typescript.extensions.null-ls.code-actions")
}

if vim.fn.executable("node_modules/.bin/eslint") == 1 then
  table.insert(null_ls_sources, null_ls.builtins.formatting.eslint_d)
  table.insert(null_ls_sources, null_ls.builtins.diagnostics.eslint_d)
  table.insert(null_ls_sources, null_ls.builtins.code_actions.eslint_d)
end

local group = vim.api.nvim_create_augroup('LspFormatting', { clear = false })

null_ls.setup({
  sources = null_ls_sources,

  on_attach = function(client, bufnr)
    lsp_status.on_attach(client)
  end,
});

vim.g.coq_settings = {
  clients = {
    snippets = {
      warn = {}
    }
  },
  display = {
    pum = {
      y_ratio   = 0.4,
      x_max_len = 88
    },
    preview = {
      x_max_len = 160
    }
  },
-- Don't overrwrite my binds for moving between splits
  keymap = {
    recommended = false,
    jump_to_mark = ''
  }
}
