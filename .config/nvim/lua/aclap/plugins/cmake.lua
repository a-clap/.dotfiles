return {
  "Civitasv/cmake-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", { desc = "CMake Generate" })
    keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "CMake Build" })
    keymap.set("n", "<leader>cp", "<cmd>CMakeSelectConfigurePreset<CR>", { desc = "CMake select configure preset" })
    keymap.set("n", "<leader>cc", "<cmd>CMakeClean<CR>", { desc = "CMake clean" })
    keymap.set("n", "<leader>ct", "<cmd>CMakeRunTest<CR>", { desc = "CMake clean" })
    keymap.set("n", "<leader>cd", "<cmd>CMakeDebugCurrentFile<CR>", { desc = "CMake debug current file" })
    keymap.set("n", "<leader>cr", "<cmd>CMakeRunCurrentFile<CR>", { desc = "CMake run current file" })

    require("cmake-tools").setup {
      cmake_command = "cmake", -- this is used to specify cmake command path
      ctest_command = "ctest", -- this is used to specify ctest command path
      cmake_use_preset = true,
      cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
      cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
      cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
      cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
      cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
      cmake_build_directory = function()
        return "build/${variant:buildType}"
      end,
      cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = false,
        console = "integratedTerminal",
      },
      cmake_executor = { -- executor to use
        name = "quickfix", -- name of the executor
        opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
        default_opts = { -- a list of default and possible values for executors
          terminal = {
            name = "Main Terminal",
            prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = "horizontal", -- "horizontal", "vertical"
            split_size = 11,

            -- Window handling
            single_terminal_per_instance = true, -- Single viewport, multiple windows
            single_terminal_per_tab = true, -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

            -- Running Tasks
            start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
            focus = false, -- Focus on terminal when cmake task is launched.
            do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
          }, -- terminal executor uses the values in cmake_terminal
        },
      },
      cmake_runner = { -- runner to use
        name = "terminal", -- name of the runner
        opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
        default_opts = { -- a list of default and possible values for runners
          terminal = {
            name = "Main Terminal",
            prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = "horizontal", -- "horizontal", "vertical"
            split_size = 11,

            -- Window handling
            single_terminal_per_instance = true, -- Single viewport, multiple windows
            single_terminal_per_tab = true, -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

            -- Running Tasks
            start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
            focus = false, -- Focus on terminal when cmake task is launched.
            do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
          },
        },
      },
      cmake_notifications = {
        runner = { enabled = true },
        executor = { enabled = true },
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
        refresh_rate_ms = 100, -- how often to iterate icons
      },
      cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
    }
  end,
}
