-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "tsserver",
  "gopls",
}

-- vim.g.rustaceanvim = {
--   server = {
--     cmd = function()
--       local mason_registry = require "mason-registry"
--       local ra_binary = mason_registry.is_installed "rust_analyzer"
--           -- This may need to be tweaked, depending on the operating system.
--           and mason_registry.get_package("rust_analyzer"):get_install_path() .. "/rust-analyzer"
--         or "rust_analyzer"
--       return { ra_binary } -- You can add args to the list, such as '--log-file'
--     end,
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--   },
-- }

vim.highlight.priorities.semantic_tokens = 95

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig["rust_analyzer"].setup {
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate",
      },
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      inlayHints = { locationLinks = false },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
    },
  },
}
