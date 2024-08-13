return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "🔴" })

      -- Debugger
      vim.api.nvim_create_user_command("DapUiToggle", function()
        require("dapui").toggle()
      end, { nargs = 0 })

      vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F11>", ":DapStepInto<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })
      -- vim.api.nvim_set_keymap("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      require("nvim-dap-virtual-text").setup {}
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
