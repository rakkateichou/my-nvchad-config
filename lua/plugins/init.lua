return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "gopls",
        "rust-analyzer",
        "typescript-language-server",
        "python-lsp-server",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = true, -- Auto close on trailing </
        },
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    opts = {
      inlay_hints = { enabled = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
      },
      ensure_installed = {
        "lua",
        "vimdoc",

        "go",
        "python",

        "c",
        "rust",

        "html",
        "css",
        "javascript",
        "typescript",

        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },

  -- {
  --   "nvimdev/lspsaga.nvim", -- has a bug with tabufline
  --   config = function()
  --     require("lspsaga").setup {
  --       symbol_in_winbar = {
  --         enable = false,
  --       },
  --       lightbulb = {
  --         enable = false,
  --       },
  --       code_action = {
  --         keys = {
  --           quit = "<esc>",
  --         },
  --       },
  --     }
  --   end,
  --   event = "LspAttach",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter", -- optional
  --     "nvim-tree/nvim-web-devicons", -- optional
  --   },
  -- },

  -- replaced with fzf-lua

  { "junegunn/fzf", build = "./install --bin" },

  {
    "ibhagwan/fzf-lua", -- replace telescope with this it the future?
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons", "junegunn/fzf" },
    config = function()
      -- calling `setup` is optional for customization
      -- require("fzf-lua").setup {}
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup {
        hint_enable = false,
      }
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4", -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },
}
