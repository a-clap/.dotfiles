return {
  "Civitasv/cmake-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/overseer.nvim",
  },
  config = function()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "CMake Build" })
    keymap.set("n", "<leader>cp", "<cmd>CMakeSelectBuildPreset<CR>", { desc = "CMake select build preset" })
    keymap.set("n", "<leader>cx", "<cmd>CMakeClean<CR>", { desc = "CMake clean" })
    keymap.set("n", "<leader>cr", "<cmd>CMakeRun<CR>", { desc = "CMake run" })
    keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<CR>", { desc = "CMake debug" })
    keymap.set("n", "<leader>ct", "<cmd>CMakeRunTest<CR>", { desc = "CMake run test" })
    keymap.set("n", "<leader>cfd", "<cmd>CMakeDebugCurrentFile<CR>", { desc = "CMake debug current file" })
    keymap.set("n", "<leader>cfr", "<cmd>CMakeRunCurrentFile<CR>", { desc = "CMake run current file" })
    keymap.set("n", "<leader>csb", "<cmd>CMakeSelectBuildTarget<CR>", { desc = "Select build target" })
    keymap.set("n", "<leader>csl", "<cmd>CMakeSelectLaunchTarget<CR>", { desc = "Select launch target" })
    keymap.set("n", "<leader>csa", function()
      local args
      vim.ui.input({
        prompt = "Set arguments",
      }, function(input)
        args = input
      end)
      if args == nil then
        return
      end

      vim.cmd.CMakeLaunchArgs { args }
    end, { desc = "Set launch args" })

    require("cmake-tools").setup {
      cmake_executor = {
        name = "quickfix",
        opts = {
          auto_close_when_success = false,
        },
      },
      cmake_runner = {
        name = "terminal",
      },
    }
  end,
}
