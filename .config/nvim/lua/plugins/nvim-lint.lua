return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        bitbake = { "oelint-adv" },
        jinja = { "djlint" },
        make = { "checkmake", "mbake" },
        markdown = { "markdownlint" },
        proto = { "buf" },
        rst = { "rstcheck" },
        ["*"] = { "typos" },
      },
      linters = {

        clangtidy = {
          args = {
            "-extra-arg=-ferror-limit=0",
          },
        },

        -- .luacheck.args = {
        --   "--globals",
        --   "vim",
        -- }
        --
        markdownlint = {
          args = {
            "--stdin",
            "--disable MD013",
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "buf",
        "checkmake",
        "djlint",
        "markdownlint",
        "oelint-adv",
        "rstcheck",
        "typos",
      },
    },
  },
}
