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
        PATH = "append",
      }

      mason_lspconfig.setup {
        -- list of servers for mason to install
        ensure_installed = {
          "asm_lsp",
          "bashls",
          "buf_ls",
          "clangd",
          "cmake",
          "dockerls",
          "esbonio",
          "ginko_ls",
          "gopls",
          "jsonls",
          "lemminx",
          "lua_ls",
          "marksman",
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
          "checkmake",
          "clang-format",
          "cmakelint",
          "codelldb",
          "cppdbg",
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
          "markdownlint",
          "mypy",
          "oelint-adv",
          "prettier",
          "rstcheck",
          "ruff",
          "shellcheck",
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
    config = function()
      require("mason-nvim-dap").setup {
        ensure_installed = { "codelldb", "cppdbg" },
        automatic_installation = true,
        handlers = {
          function(config)
            -- all sources with no handler get passed here
            -- Keep original functionality
            require("mason-nvim-dap").default_setup(config)
          end,
          cppdbg = function(config)
            config.configurations = {
              {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtEntry = true,
              },
              {
                name = "gdbserver",
                type = "cppdbg",
                request = "launch",
                MIMode = "gdb",
                miDebuggerServerAddress = function()
                  return vim.fn.input("ip address:", "192.168.1.1:1234")
                end,

                miDebuggerPath = vim.fn.exepath "gdb",
                cwd = "${workspaceFolder}",
                program = function()
                  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
              },
            }
            require("mason-nvim-dap").default_setup(config) -- don't forget this!
          end,
        },
      }
    end,
  },
}
