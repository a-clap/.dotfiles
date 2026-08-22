return {
  {
    "olimorris/codecompanion.nvim",
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
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "codex-acp" },
    },
  },
}
