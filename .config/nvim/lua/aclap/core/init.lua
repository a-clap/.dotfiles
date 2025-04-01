require "aclap.core.options"
require "aclap.core.keymaps"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})
