return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      bitbake = { "oelint-adv" },
      make = { "checkmake" },
      cmake = { "cmakelint" },
      docker = { "hadolint" },
      lua = { "luacheck" },
      proto = { "buf_lint" },
      python = { "mypy", "ruff" },
      shell = { "shellcheck" },
      markdown = { "markdownlint" },
      rst = { "rstcheck" },
    }

    local clangtidy = lint.linters.clangtidy
    clangtidy.args = {
      "-extra-arg=-ferror-limit=0",
    }

    lint.linters.luacheck.args = {
      "--globals",
      "vim",
    }

    lint.linters.markdownlint.args = {
      "--stdin",
      "--disable MD013",
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
