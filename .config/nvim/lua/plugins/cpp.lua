return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/overseer.nvim",
    },
    cond = function()
      local cwd = vim.loop.cwd()
      return vim.loop.fs_stat(cwd .. "/CMakeLists.txt") ~= nil
    end,
    config = function()
      local keymap = vim.keymap

      keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "CMake Build" })
      keymap.set("n", "<leader>cp", "<cmd>CMakeSelectBuildPreset<CR>", { desc = "CMake select build preset" })
      keymap.set("n", "<leader>cc", "<cmd>CMakeClean<CR>", { desc = "CMake clean" })
      keymap.set("n", "<leader>cx", "<cmd>CMakeStopExecutor<CR><cmd>CMakeStopRunner<CR>", { desc = "CMake stop" })
      keymap.set("n", "<leader>ce", "<cmd>CMakeRun<CR>", { desc = "CMake execute" })
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

        vim.cmd.CMakeLaunchArgs({ args })
      end, { desc = "Set launch args" })

      require("cmake-tools").setup({
        cmake_executor = {
          name = "quickfix",
          opts = {
            auto_close_when_success = false,
          },
        },
        cmake_runner = {
          name = "terminal",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--j=8",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--malloc-trim",
            "--pch-storage=memory",
          },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "alfaix/neotest-gtest",
    },
    opts = {
      adapters = {
        ["neotest-gtest"] = {
          is_test_file = function(file_path)
            local lib = require("neotest.lib")
            local _test_extensions = {
              ["cpp"] = true,
              ["cppm"] = true,
              ["cc"] = true,
              ["cxx"] = true,
              ["c++"] = true,
            }

            local elems = vim.split(file_path, lib.files.sep, { plain = true })

            local filename = elems[#elems]
            if filename == "" then -- directory
              return false
            end
            local extsplit = vim.split(filename, ".", { plain = true })
            local extension = extsplit[#extsplit]
            local fname_last_part = extsplit[#extsplit - 1]
            local result = _test_extensions[extension]
                and (vim.startswith(filename, "test_") or vim.endswith(fname_last_part, "_test") or vim.endswith(
                  fname_last_part,
                  "_tests"
                ))
              or false
            return result
          end,
        },
      },
    },
  },
}
