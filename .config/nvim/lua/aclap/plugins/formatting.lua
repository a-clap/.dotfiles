return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require "conform"

    conform.setup {
      formatters_by_ft = {
        asm = { "asmfmt" },
        c = { "clang-format" },
        cmake = { "cmake_format" },
        cpp = { "clang-format" },
        go = { "gofumpt", "golines", "goimports-reviser" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        proto = { "buf" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        xml = { "xmlformat" },
        yaml = { "yamlfmt" },
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000,
      },
    }

    conform.formatters.yamlfmt = {
      prepend_args = { "-formatter", "retain_line_breaks_single=true" },
    }

    conform.formatters.xmlformat = {
      prepend_args = { "--blanks", "--selfclose" },
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
