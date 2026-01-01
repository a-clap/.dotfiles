return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = true,
    ft = "rust",

    config = function()
      local keymap = vim.keymap

      -- keymap.set("n", "<leader>k", rc.hover_actions.hover_actions, { desc = "Hover action" })
      -- p  vim.keymap.set("n", "K", function() vim.cmd.RustLsp { "hover", "actions" } end, { buffer = bufnr })
      keymap.set("n", "K", function()
        vim.cmd.RustLsp { "hover", "actions" }
        vim.cmd.RustLsp { "hover", "actions" }
      end, { desc = "hover action" })

      keymap.set("n", "T", function()
        vim.cmd.RustLsp { "testables" }
      end, { desc = "list testables" })
      keymap.set("n", "R", function()
        vim.cmd.RustLsp { "runnables" }
      end, { desc = "list runnables" })
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust", "ron" } },
  },
}
