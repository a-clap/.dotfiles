return {
  "dense-analysis/ale",
  enabled = false,
  config = function()
    vim.g.ale_lint_on_text_changed = "never"
    vim.g.ale_lint_on_insert_leave = 0

    vim.g.ale_linters = {
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      c = { "clangtidy" },
      cpp = { "clangtidy" },
    }

    vim.g.ale_fixers = {
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      c = { "clangtidy" },
      cpp = { "clangtidy" },
    }
  end,
}
