return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require "conform"

    conform.setup {
      formatters_by_ft = {
        asm = { "asmfmt" },
        json = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        bash = { "shfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        rust = { "rustfmt" },
        yaml = { "yamlfmt" },
        go = { "gofumpt", "golines", "goimports-reviser" },
        proto = { "buf" },
        xml = { "xmlformat" },
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000,
      },
    }

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
