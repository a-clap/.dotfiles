return {
  {
    "mrcjkb/rustaceanvim",
    keys = {
      { "<leader>rr", "<cmd>RustLsp runnables<cr>", ft = "rust", desc = "Rust: Run target" },
      { "<leader>rR", "<cmd>RustLsp! runnables<cr>", ft = "rust", desc = "Rust: Repeat last run" },
      { "<leader>rd", "<cmd>RustLsp debuggables<cr>", ft = "rust", desc = "Rust: Debug target" },
      { "<leader>re", "<cmd>RustLsp explainError current<cr>", ft = "rust", desc = "Rust: Explain error" },
      { "<leader>rD", "<cmd>RustLsp renderDiagnostic current<cr>", ft = "rust", desc = "Rust: Full diagnostic" },
      { "<leader>rm", "<cmd>RustLsp expandMacro<cr>", ft = "rust", desc = "Rust: Expand macro" },
      { "<leader>rp", "<cmd>RustLsp parentModule<cr>", ft = "rust", desc = "Rust: Parent module" },
      { "<leader>ro", "<cmd>RustLsp openDocs<cr>", ft = "rust", desc = "Rust: Open documentation" },
      { "<leader>rc", "<cmd>RustLsp openCargo<cr>", ft = "rust", desc = "Rust: Open Cargo.toml" },
    },
  },
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
