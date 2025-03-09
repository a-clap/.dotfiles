return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }

      vim.cmd "colorscheme gruvbox"
    end,
  },
  {
    {
      "f4z3r/gruvbox-material.nvim",
      enabled = false,
      config = function()
        require("gruvbox-material").setup {
          -- contrast = "low",
          -- contrast = "low",
          contrast = "medium",
          -- contrast = "high",
          vim.cmd "colorscheme gruvbox-material",
        }
      end,
    },
  },
  {
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

          vim.cmd.colorscheme "gruvbox-material"
        end,
      },
    },
  },
}
