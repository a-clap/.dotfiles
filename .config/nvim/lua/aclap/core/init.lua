vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.diagnostic.config {
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  float = {
    border = "rounded",
    format = function(d)
      return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
    end,
  },
  underline = true,
  jump = {
    float = true,
  },
}

vim.g.doge_enable_mappings = false

require "aclap.core.options"
require "aclap.core.keymaps"
