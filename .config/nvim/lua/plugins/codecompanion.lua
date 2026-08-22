local profile = vim.env.ACLAP_DOTFILES_PROFILE or "home"
local profiles = {
  home = true,
  work = true,
}

if not profiles[profile] then
  error("Unknown ACLAP_DOTFILES_PROFILE profile: " .. profile)
end

local specs = {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "AI Chat",
      },
      {
        "<leader>aa",
        "<cmd>CodeCompanionActions<cr>",
        desc = "AI Actions",
      },
      {
        "<leader>as",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = "v",
        desc = "Add selection to AI chat",
      },
    },
  },
}

return vim.list_extend(specs, require("codecompanion." .. profile))
