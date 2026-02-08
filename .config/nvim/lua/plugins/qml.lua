return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      qmlls = {
        cmd = { "qmlls6", "--no-cmake-calls", "-v" },
      },
    },
  },
}
