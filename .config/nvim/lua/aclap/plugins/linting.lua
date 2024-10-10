return {
  "mfussenegger/nvim-lint",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      c = { "clangtidy" },
      cpp = { "clangtidy" },
      shell = { "shellcheck" },
      cmake = { "cmakelint" },
      python = { "pylint" },
      protobuf = { "buf_lint" },
    }

    local clangtidy = lint.linters.clangtidy
    clangtidy.args = {
      "-extra-arg=-ferror-limit=0",
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}