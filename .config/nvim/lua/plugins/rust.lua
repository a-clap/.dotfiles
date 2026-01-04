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
}
