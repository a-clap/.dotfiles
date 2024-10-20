return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      shell = { "shellcheck" },
      cmake = { "cmakelint" },
      python = { "mypy", "ruff" },
      proto = { "buf_lint" },
      lua = { "luacheck" },
      docker = { "hadolint" },
      bitbake = { "oelint-adv" },
    }

    local clangtidy = lint.linters.clangtidy
    clangtidy.args = {
      "-extra-arg=-ferror-limit=0",
    }

    lint.linters.luacheck.args = {
      "--globals",
      "vim",
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>lt", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
