return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        bitbake = { "oelint-adv" },
        jinja = { "djlint" },
        make = { "checkmake" },
        markdown = { "markdownlint" },
        proto = { "buf" },
        rst = { "rstcheck" },
        ["*"] = { "typos" },
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
        "shfmt",
        "typos",
      },
    },
  },
}
