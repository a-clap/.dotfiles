return {
  "Exafunction/codeium.vim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = "InsertEnter",
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set("i", "<C-e>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-n>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-p>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, silent = true })
  end,
}
