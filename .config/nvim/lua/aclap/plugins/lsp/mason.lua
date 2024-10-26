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
          "bufls",
          "cmake",
          "dockerls",
          "gopls",
          "jsonls",
          "lemminx",
          "lua_ls",
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
          "black",
          "buf",
          "cmakelint",
          "codelldb",
          "debugpy",
          "flake8",
          "go-debug-adapter",
          "gofumpt",
          "goimports-reviser",
          "golangci-lint",
          "golines",
          "hadolint",
          "isort",
          "jsonlint",
          "luacheck",
          "mypy",
          "oelint-adv",
          "prettier",
          "ruff",
          "shfmt",
          "stylua",
          "xmlformatter",
          "yamlfmt",
          "yamllint",
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
