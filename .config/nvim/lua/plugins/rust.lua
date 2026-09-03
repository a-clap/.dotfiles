return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "bacon" },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    keys = {
      {
        "<leader>ce",
        function()
          Snacks.terminal("cargo run", {
            cwd = LazyVim.root(),
            auto_close = false,
          })
        end,
        desc = "Cargo Run",
      },
      {
        "<leader>cb",
        function()
          Snacks.terminal("cargo build", {
            cwd = LazyVim.root(),
            auto_close = false,
          })
        end,
        desc = "Cargo Build",
      },
      -- {
      --   "<leader>Rc",
      --   function()
      --     Snacks.terminal("cargo check", {
      --       cwd = LazyVim.root(),
      --     })
      --   end,
      --   desc = "Cargo Check",
      -- },
      -- {
      --   "<leader>Rl",
      --   function()
      --     Snacks.terminal("cargo clippy", {
      --       cwd = LazyVim.root(),
      --     })
      --   end,
      --   desc = "Cargo Clippy",
      -- },
    },
  },
}
