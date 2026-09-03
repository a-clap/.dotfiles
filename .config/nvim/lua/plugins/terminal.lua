return {
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
  },
  {
    "chodak166/snacks-terminal-ctl.nvim",
    dependencies = { "folke/snacks.nvim" },
    event = "VeryLazy",
    opts = {
      keys = {
        float = false, -- mapped explicitly below to support both terminal encodings
        picker = "<leader>ft", -- terminal picker
        toggle = false, -- disable bottom terminals
      },
    },
    config = function(_, opts)
      local terminal = require("snacks-terminal-ctl")
      terminal.setup(opts)

      vim.schedule(function()
        -- Depending on the terminal emulator, Ctrl-/ arrives as either of these.
        for _, key in ipairs({ "<C-/>", "<C-_>" }) do
          vim.keymap.set({ "n", "t" }, key, terminal.toggle_float, { desc = "Terminal (float)" })
        end
      end)
    end,
  },
}
