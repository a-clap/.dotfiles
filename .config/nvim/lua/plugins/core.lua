return {
  {
    "LazyVim/LazyVim",
    dependencies = "sainnhe/gruvbox-material",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,

    init = function()
      vim.opt.background = "dark"

      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_ui_contrast = "high"

      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_enable_bold = 1

      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_better_performance = 1

      local group = vim.api.nvim_create_augroup("GruvboxMaterialCustom", { clear = true })

      -- Theme overrides
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        pattern = "gruvbox-material",

        callback = function()
          vim.api.nvim_set_hl(0, "Comment", {
            fg = "#a89984",
            italic = false,
          })

          -- Callable variables:
          -- lambdas, std::function, function objects, function pointers, etc.
          vim.api.nvim_set_hl(0, "CppCallableVariable", {
            fg = "#a9b665",
            bold = true,
          })
        end,
      })

      -- clangd sees a lambda stored in a variable as "variable".
      --
      -- Tree-sitter, however, knows that:
      --
      --   callback();
      --   ^^^^^^^^
      --
      -- is a function call. Combine both pieces of information and
      -- give callable variables their own color.
      vim.api.nvim_create_autocmd("LspTokenUpdate", {
        group = group,

        callback = function(ev)
          if vim.bo[ev.buf].filetype ~= "cpp" then
            return
          end

          local token = ev.data.token

          if token.type ~= "variable" then
            return
          end

          local captures = vim.treesitter.get_captures_at_pos(ev.buf, token.line, token.start_col)

          for _, capture in ipairs(captures) do
            if capture.capture == "function.call" then
              vim.lsp.semantic_tokens.highlight_token(token, ev.buf, ev.data.client_id, "CppCallableVariable", {
                priority = 200,
              })

              return
            end
          end
        end,
      })
    end,
  },
}
