return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        acp = {
          codex_chatgpt = function()
            return require("codecompanion.adapters").extend("codex", {
              name = "codex_chatgpt",
              formatted_name = "Codex via ChatGPT",
              defaults = {
                auth_method = "chat-gpt",
              },
            })
          end,
          codex_openrouter = function()
            return require("codecompanion.adapters").extend("codex", {
              name = "codex_openrouter",
              formatted_name = "Codex via OpenRouter",

              commands = {
                default = {
                  "codex-acp",
                },
              },
              env = {
                MODEL_PROVIDER = "openrouter",
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
          adapter = "codex_openrouter",
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
