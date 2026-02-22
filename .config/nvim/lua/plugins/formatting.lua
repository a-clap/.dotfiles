return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        asm = { "asmfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        go = { "gofumpt", "golines", "goimports-reviser" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        proto = { "buf" },
        python = { "ruff_format" },
        qml = { "qmlformat" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        toml = { "taplo" },
        xml = { "xmlformatter" },
        yaml = { "yamlfmt" },
      },

      formatters = {
        yamlfmt = {
          prepend_args = { "-formatter", "retain_line_breaks_single=true" },
        },
        xmlformat = {
          prepend_args = { "--blanks", "--selfclose" },
        },
        qmlformat = {
          command = "qmlformat6",
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "asmfmt",
        "black",
        "buf",
        "clang-format",
        "gofumpt",
        "goimports-reviser",
        "golines",
        "isort",
        "prettier",
        "rustfmt",
        "shfmt",
        "stylua",
        "taplo",
        "xmlformatter",
        "yamlfmt",
      },
    },
  },
}
