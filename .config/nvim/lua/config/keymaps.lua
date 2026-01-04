-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- save file
---- use `vim.keymap.set` instead
local map = vim.keymap.set
map({ "i", "x", "n", "s" }, "<leader>ww", "<cmd>w<cr><esc>", { desc = "Save File" })
