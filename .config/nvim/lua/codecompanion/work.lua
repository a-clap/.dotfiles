return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        acp = {
          opencode = function()
            return require("codecompanion.adapters").extend("opencode", {
              env = {
                CORTECS_API_KEY = "CORTECS_API_KEY",
              },
            })
          end,
        },
      },

      interactions = {
        chat = {
          adapter = "opencode",
        },
      },
    },
  },
}
