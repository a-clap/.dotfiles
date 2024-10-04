return {
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended
  lazy = false, -- This plugin is already lazy

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
}
