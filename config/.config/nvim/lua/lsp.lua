local coq        = require('coq')
local lspconfig  = require('lspconfig')
local lsp_status = require('lsp-status')

local dynamic_workspace_symbols = function()
  local telescope_builtin = require('telescope.builtin')
  telescope_builtin.lsp_dynamic_workspace_symbols({
    symbols = { 'constant', 'class', 'interface', 'function', 'method' },
  })
end

local wk = require('which-key')

lsp_status.config({
  diagnostics   = false,
  status_symbol = ''
})

local common = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  wk.register(
    {
      name = 'LSP',
      d = { '<CMD>lua vim.lsp.buf.definition()<CR>', 'Show definition' },
      e = { '<CMD>lua vim.diagnostic.open_float<CR>', 'Diagnostics float' },
      f = { '<CMD>lua vim.lsp.buf.format()<CR>', 'Format' },
      h = { '<CMD>lua vim.lsp.buf.hover()<CR>', 'Hover' },
      i = { '<CMD>lua vim.lsp.buf.implementation()<CR>', 'Show implementation' },
      n = { '<CMD>lua vim.lsp.buf.rename()<CR>', 'Rename' },
      r = { '<CMD>lua vim.lsp.buf.references()<CR>', 'Find references' },
      s = { '<CMD>Telescope lsp_document_symbols<CR>', 'Document symbols' },
      w = { dynamic_workspace_symbols, 'Workspace symbols' },
      [';'] = { '<CMD>lua vim.lsp.buf.code_action()<CR>', 'Code actions' }
    },
    {
      prefix = ';',
      buffer = bufnr,
      mode   = 'n'
    }
  )

  vim.diagnostic.config({
    virtual_text = false,
    signs        = false,
    underline    = false
  })
end


local on_attach = function(client, bufnr)
  common(client, bufnr)
  lsp_status.on_attach(client)
end

local servers = {
  ['solargraph'] = {
    enable = (vim.fn.executable('solargraph') == 1),
    on_attach = on_attach,
  },
  ['sourcekit-lsp'] = {
    enable = (vim.fn.executable('sourcekit') == 1),
    on_attach = on_attach,
  },
  ['nil_ls'] = {
    enable = (vim.fn.executable('nil') == 1 and vim.fn.executable('nixpkgs-fmt') == 1),
    on_attach = on_attach,
    settings = {
      ['nil'] = {
        formatting = {
          command = { 'nixpkgs-fmt' }
        }
      }
    }
  },
  ['lua_ls'] = {
    enable = (vim.fn.executable('lua-language-server') == 1),
    on_attach = on_attach,
    cmd = {'lua-language-server',
      '--logpath',
      '$HOME/.cache/lua-language-server/',
      '--metapath',
      '$HOME/.cache/lua-language-server/meta/'
    }
  },

}

for lsp, settings in pairs(servers) do
  local enable    = settings.enable
  settings.enable = nil

  if enable then
    lspconfig[lsp].setup(coq.lsp_ensure_capabilities(settings))
  end
end

-- TypeScript --
if (vim.fn.executable('tsserver') == 1 and vim.fn.executable('node_modules/.bin/tsc') == 1) then
  require('typescript').setup({
    disable_commands = false,
    debug            = false,
    server           = coq.lsp_ensure_capabilities(
      {
        on_attach = function(client, bufnr)
          common(client, bufnr)
          client.server_capabilities.documentFormattingProvider       = false
          client.server_capabilities.documentRangeFormattingProvider  = false
          lsp_status.on_attach(client)
        end
      }
    )
  })
end

-- null-ls --
local null_ls = require('null-ls')

local null_ls_sources = {
  null_ls.builtins.code_actions.gitsigns,
}

if vim.fn.executable('node_modules/.bin/eslint') == 1 then
  table.insert(null_ls_sources, null_ls.builtins.formatting.eslint_d)
  table.insert(null_ls_sources, null_ls.builtins.diagnostics.eslint_d)
  table.insert(null_ls_sources, null_ls.builtins.code_actions.eslint_d)
end


if (vim.fn.executable('tsserver') == 1 and vim.fn.executable('node_modules/.bin/tsc') == 1) then
  table.insert(null_ls_sources, require('typescript.extensions.null-ls.code-actions'))
end

null_ls.setup({
  sources = null_ls_sources,
  on_attach = function(client, bufnr)
    lsp_status.on_attach(client)
  end
});
