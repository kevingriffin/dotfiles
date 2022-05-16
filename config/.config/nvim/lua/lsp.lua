local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<CMD>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d',       '<CMD>lua vim.diagnostic.goto_prev()<CR>',  opts)
vim.api.nvim_set_keymap('n', ']d',       '<CMD>lua vim.diagnostic.goto_next()<CR>',  opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local common = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gd',      '<CMD>lua vim.lsp.buf.definition()<CR>',      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gD',      '<CMD>lua vim.lsp.buf.declaration()<CR>',     opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gr',      '<CMD>lua vim.lsp.buf.references()<CR>',      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gi',      '<CMD>lua vim.lsp.buf.implementation()<CR>',  opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>D',       '<CMD>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space><space>', '<CMD>lua vim.lsp.buf.hover()<CR>',           opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>rn',      '<CMD>lua vim.lsp.buf.rename()<CR>',          opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ca',      '<CMD>lua vim.lsp.buf.code_action()<CR>',     opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>fo',      '<CMD>lua vim.lsp.buf.formatting()<CR>',      opts)

  vim.diagnostic.config({
    virtual_text = false,
    signs        = false,
  })
end


local servers    = {}
local candidates = { 'solargraph' }
local coq        = require "coq"
local lspconfig  = require "lspconfig"

for _, candidate in pairs(candidates) do
  if vim.fn.executable(candidate) then
    table.insert(servers, candidate)
  end
end

local on_attach = function(client, bufnr)
  common(client, bufnr)
end

local ts_on_attach = function(client, bufnr)
  common(client, bufnr)
  client.resolved_capabilities.document_formatting       = false
  client.resolved_capabilities.document_range_formatting = false
end

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
  }))
end

-- Special settings for TypeScript
if vim.fn.executable('tsserver') then
  lspconfig['tsserver'].setup(coq.lsp_ensure_capabilities({
    on_attach = ts_on_attach,
  }))
end

-- null-ls
local null_ls = require('null-ls')

local null_ls_sources = {
  null_ls.builtins.code_actions.gitsigns,
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
    -- format on save
    if client.resolved_capabilities.document_formatting then
      for key, cmd in pairs(vim.api.nvim_get_autocmds({ group = group, buffer = bufnr })) do
        vim.api.nvim_del_autocmd(cmd.id)
      end
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.formatting_sync,
      })
    end
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
    jump_to_mark = ''
  }
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable                            = true,
    disable                           = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable  = false,
    disable = {},
  },
  ensure_installed = "all",
  ignore_install   = { "phpdoc" }, -- broken
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "gnn",
      node_incremental  = "grn",
      scope_incremental = "grc",
      node_decremental  = "grm",
    },
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
