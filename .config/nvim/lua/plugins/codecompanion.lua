return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    opts = {
      adapters = {
        acp = {
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = {
                auth_method = "chat-gpt",
              },
            })
          end,
        },
      },

      interactions = {
        chat = {
          adapter = "codex",
        },
      },
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
  {

    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "codex-acp",
      },
    },
  },
}
