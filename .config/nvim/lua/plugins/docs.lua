return {
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    config = function()
      vim.keymap.set("n", "<leader>dd", "<cmd>DogeGenerate<CR>", { desc = "Generate docs" })
      -- -- Interactive mode comment todo-jumping
      vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
      vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
      vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
      vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
      vim.keymap.set("x", "<TAB>", "<Plug>(doge-comment-jump-forward)")
      vim.keymap.set("x", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
      vim.g.doge_doc_standard_cpp = "doxygen_cpp_comment_slash"
      vim.g.doge_doc_standard_c = "doxygen_cpp_comment_slash"
      vim.g.doge_doxygen_settings = {
        char = "\\",
      }
    end,
  },
}
