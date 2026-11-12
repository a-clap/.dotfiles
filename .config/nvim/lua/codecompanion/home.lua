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
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                ANTHROPIC_BASE_URL = "https://openrouter.ai/api",
                ANTHROPIC_API_KEY = "OPENROUTER_API_KEY",
                CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY = "1",
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
      ensure_installed = { "codex-acp", "claude-agent-acp" },
    },
  },
}
