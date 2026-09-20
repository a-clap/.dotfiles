return {
  {
    "mfussenegger/nvim-dap",

    opts = function()
      local dap = require("dap")

      ----------------------------------------------------------------------
      -- GDB
      ----------------------------------------------------------------------

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = {
          "-i",
          "dap",
        },
      }

      ----------------------------------------------------------------------
      -- CodeLLDB
      --
      -- Zostawiamy jako alternatywę. Jeśli używasz LazyVim lang.clangd,
      -- CodeLLDB powinien być dostępny przez Mason.
      ----------------------------------------------------------------------

      dap.adapters.codelldb = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",

        executable = {
          command = "codelldb",
          args = {
            "--port",
            "${port}",
          },
        },
      }

      ----------------------------------------------------------------------
      -- Helpers
      ----------------------------------------------------------------------

      local function pick_executable()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end

      ----------------------------------------------------------------------
      -- C / C++
      ----------------------------------------------------------------------

      local configurations = {
        --------------------------------------------------------------------
        -- GDB
        --------------------------------------------------------------------

        {
          name = "C/C++: GDB launch",
          type = "gdb",
          request = "launch",

          program = pick_executable,
          cwd = "${workspaceFolder}",

          stopAtBeginningOfMainSubprogram = false,
        },

        {
          name = "C/C++: GDB attach",
          type = "gdb",
          request = "attach",

          program = pick_executable,

          pid = function()
            return require("dap.utils").pick_process()
          end,

          cwd = "${workspaceFolder}",
        },

        --------------------------------------------------------------------
        -- CodeLLDB
        --------------------------------------------------------------------

        {
          name = "C/C++: CodeLLDB launch",
          type = "codelldb",
          request = "launch",

          program = pick_executable,
          cwd = "${workspaceFolder}",

          stopOnEntry = false,
        },

        {
          name = "C/C++: CodeLLDB attach",
          type = "codelldb",
          request = "attach",

          pid = function()
            return require("dap.utils").pick_process()
          end,

          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.c = vim.deepcopy(configurations)
      dap.configurations.cpp = vim.deepcopy(configurations)
    end,
  },

  ------------------------------------------------------------------------
  -- DAP UI
  ------------------------------------------------------------------------

  {
    "rcarriga/nvim-dap-ui",

    opts = function(_, opts)
      opts.render = opts.render or {}

      -- GDB DAP zwraca bardzo długie nazwy typów.
      -- Nie naprawia to type-printerów w DAP, ale utrzymuje UI czytelne.
      opts.render.max_type_length = 40
      opts.render.max_value_lines = 20
    end,
  },
}
