return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "bacon", "rust-analyzer" },
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
}
