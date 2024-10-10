return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- import mason
      local mason = require "mason"

      -- import mason-lspconfig
      local mason_lspconfig = require "mason-lspconfig"

      local mason_tool_installer = require "mason-tool-installer"

      -- enable mason and configure icons
      mason.setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }

      mason_lspconfig.setup {
        -- list of servers for mason to install
        ensure_installed = {
          "asm_lsp",
          "bashls",
          "dockerls",
          "cmake",
          "gopls",
          "prismals",
          "pyright",
          "yamlls",
          "zls",
        },
      }

      mason_tool_installer.setup {
        ensure_installed = {
          "asmfmt",
          "bacon",
          "stylua", -- lua formatter
          "isort", -- python formatter
          "black", -- python formatter
          "prettier",
          "mypy",
          "debugpy",
          "ruff",
          "shfmt",
          "codelldb",
          "hadolint",
          "oelint-adv",
          "cmakelint",
          "yamlfmt",
          "yamllint",
          "golangci-lint",
          "gofumpt",
          "golines",
          "goimports-reviser",
          "go-debug-adapter",
        },
      }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
}
