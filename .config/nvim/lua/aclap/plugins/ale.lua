return {
  "dense-analysis/ale",
  config = function()
    -- Configuration goes here.
    local g = vim.g

    g.ale_ruby_rubocop_auto_correct_all = 1

    g.ale_linters = {
      lua = { "lua_language_server" },
      cpp = { "clangtidy" },
    }

    local keymap = vim.keymap
    keymap.set("n", "<F8>", "<Plug>(ale_fix)", { desc = "Toggle file explorer" }) -- toggle file explorer
  end,
}