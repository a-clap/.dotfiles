-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.g.doge_enable_mappings = 0

kupka_parser_dir = vim.fn.expand("~/tree-sitter-kupka")

is_kupka_parser_available = function()
  return vim.fn.isdirectory(kupka_parser_dir) == 1
end

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    if is_kupka_parser_available() then
      require("nvim-treesitter.parsers").kupka = {
        install_info = {
          path = kupka_parser_dir,
          -- optional entries
          -- location = "parser",
          generate = true,
          generate_from_json = false,
          queries = "queries",
        },
      }
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "kupka" },
  callback = function()
    if is_kupka_parser_available() then
      vim.treesitter.start()
    end
  end,
})
