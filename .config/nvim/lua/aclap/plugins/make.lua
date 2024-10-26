return {
  {
    "Zeioth/makeit.nvim",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
    keys = {
      { "<leader>mo", "<cmd>MakeitOpen<CR>", desc = "Makefile: open tasks" },
      { "<leader>ms", "<cmd>MakeitToggleResults<CR>", desc = "Makefile: toggle results" },
      { "<leader>mr", "<cmd>MakeitRedo<CR>", desc = "Makefile: redo" },
    },
  },
  {
    "stevearc/overseer.nvim",
    commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
