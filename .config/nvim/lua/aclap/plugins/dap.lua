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
    end,
  },
  {
    "leoluz/nvim-dap-go",
    event = "VeryLazy",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
}
