return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "fredrikaverpil/neotest-golang",
      "alfaix/neotest-gtest",
    },
    config = function()
      require("neotest").setup {
        -- default_strategy = "dap",
        status = { virtual_text = true },
        adapters = {
          require "neotest-python" {
            runner = "pytest",
            dap = { justMyCode = false },
            pytest_discover_instances = true,
          },
          require "neotest-golang",
          require("neotest-gtest").setup {
            is_test_file = function(file_path)
              local lib = require "neotest.lib"
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
                  and (vim.startswith(filename, "test_") or vim.endswith(fname_last_part, "_test") or vim.endswith(fname_last_part, "_tests"))
                or false
              return result
            end,
          },
        },
        output = {
          enabled = true,
          open_on_run = true,
        },
      }
    end,
    -- stylua: ignore
    keys = {
        { "<leader>t", "", desc = "+test"},
        { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach" },
        { "<leader>tt", "<cmd>Neotest run file<CR>", desc = "Run File" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },

        { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
        { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
        { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
        { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
  },
  },
}
