return {
  {
    "LazyVim/LazyVim",
    dependencies = "sainnhe/gruvbox-material",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  {
    {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        --gruvbox_material_background
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_foreground = "mix"
        vim.g.gruvbox_material_enable_italic = false
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

        -- vim.cmd.colorscheme("gruvbox-material")
      end,
    },
  },
}
