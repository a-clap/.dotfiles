return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },

  config = function()
    vim.lsp.set_log_level "off"
    -- import lspconfig plugin
    local lspconfig = require "lspconfig"

    -- import mason_lspconfig plugin
    local mason_lspconfig = require "mason-lspconfig"

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require "cmp_nvim_lsp"

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "<C-q>", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

        -- inlay hints
        vim.lsp.inlay_hint.enable(true, { 0 })
        -- signature helper
        require("lsp_signature").on_attach({}, ev.buf)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- qmlls setup
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("qmlls", {
      cmd = { "qmlls", "-E" },
      capabilities = capabilities,
      filetypes = { "qmljs", "qml" },
    })

    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--j=8",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--malloc-trim",
        "--pch-storage=memory",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      single_file_support = true,

      on_attach = function()
        vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header (C/C++)" })
      end,
    })

    vim.lsp.config("ginko_ls", {
      filetypes = { "dts", "dtsi", "dtso" },
    })

    --  python setup based on: https://github.com/Jaehaks/nvim_config/blob/03db5c43394a7ee5c5900e79908f31fced4a5b3e/lua/jaehak/core/lsp.lua
    --  -- ###### 6) python language server configuration ###########
    -- a) ruff : use code_action(but cannot all fix) / use Formatting / fast type check inherited
    -- b) pyright : no code_action / no Formatting / fast type check inherited
    -- c) pylsp : no code action / use Formatting / slow type check disinherited
    -- flake8 is also fast, but I found that pyright / ruff are faster a more little bit
    -- 		but not big differences, I understand that type checking of pyright is more accurate than ruff/flake8
    -- 		pyright has more accuracy about unused variable, linter's error is shadowed by other error when it detects multiple error
    -- 		organizeImports is applied to both pyright and ruff / buf ruff has code action to this
    -- 		linter is not type checker... it helps code convention as formatting rule, and better style of code
    --      it detects some trivial error like undefined , but it cannot detect type checking error
    --      On the other hand, pyright does not support linting(better style checker)
    --      but for trivial error, ruff / flake8 / pyright detect in the same time
    -- (241117) : ruff_lsp is deprecated
    -- cmp_nvim_lsp default_configuration add completionProvider. ruff_lsp don't use completion
    -- #############################################################
    -- ####### ruff : linter
    -- #############################################################
    -- main purpose is fast linting diagnostics
    local root_dir_ruff = function(bufnr, cb)
      local root = vim.fs.root(bufnr, {
        "pyproject.toml",
        "ruff.toml",
        ".ruff.toml",
        ".git",
      }) or vim.fn.expand "%:p:h"
      cb(root)
    end
    vim.lsp.config("ruff", {
      cmd = { "ruff", "server" },
      filetypes = { "python" },
      root_dir = root_dir_ruff,
      on_attach = function(client, _)
        -- lsp use ruff to formatter
        client.server_capabilities.documentFormattingProvider = false -- enable vim.lsp.buf.format()
        client.server_capabilities.documentRangeFormattingProvider = false -- formatting will be used by confirm.nvim
        client.server_capabilities.hoverProvider = false -- use basedpyrigt
      end,
      init_options = {
        settings = {
          -- configuration = require("jaehak.core.paths").lsp.ruff.config_path,
          -- logFile = require("jaehak.core.paths").lsp.ruff.log_path,
          logLevel = "warn",
          organizeImports = true, -- use code action for organizeImports
          showSyntaxErrors = true, -- show syntax error diagnostics
          codeAction = {
            disableRuleComment = { enable = false }, -- show code action about rule disabling
            fixViolation = { enable = false }, -- show code action for autofix violation
          },
          format = { -- use conform.nvim
            preview = false,
          },
          lint = { -- it links with ruff, but lint.args are different with ruff configuration
            enable = true,
          },
        },
      },
      single_file_support = false,
    })

    -- #############################################################
    -- ####### basedpyright
    -- #############################################################
    -- main purpose is exact type checking diagnostics
    -- It has very slow lsp completion to use
    local root_dir_basedpyright = function(bufnr, cb)
      local root = vim.fs.root(bufnr, {
        "pyproject.toml",
        "pyrightconfig.json",
        ".git",
      }) or vim.fn.expand "%:p:h"
      cb(root)
    end
    vim.lsp.config("basedpyright", {
      cmd = { "basedpyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_dir = root_dir_basedpyright,
      on_attach = function(client, _)
        client.server_capabilities.completionProvider = false -- use pyrefly for fast response
        client.server_capabilities.definitionProvider = false -- use pyrefly for fast response
        client.server_capabilities.documentHighlightProvider = false -- use pyrefly for fast response
        client.server_capabilities.renameProvider = false -- use pyrefly as I think it is stable
        client.server_capabilities.semanticTokensProvider = false -- use pyrefly it is more rich
      end,
      settings = { -- see https://docs.basedpyright.com/latest/configuration/language-server-settings/
        basedpyright = {
          disableOrganizeImports = true, -- use ruff instead of it
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true, -- auto serach command paths like 'src'
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportUnknownMemberType = "none", -- ignore warning : cannot infer member type of object like matplot
            },
          },
        },
      },
    })

    -- #############################################################
    -- ####### pyrefly
    -- #############################################################
    -- main purpose is fast completion/semanticTokens
    -- the alternative of it is ty, but it is experimental yet
    local root_dir_pyrefly = function(bufnr, cb)
      local root = vim.fs.root(bufnr, {
        "pyproject.toml",
        "pyrefly.roml",
        ".git",
      }) or vim.fn.expand "%:p:h"
      cb(root)
    end
    vim.lsp.config("pyrefly", {
      cmd = { "pyrefly", "lsp" },
      filetypes = { "python" },
      root_dir = root_dir_pyrefly,
      on_attach = function(client, _)
        client.server_capabilities.codeActionProvider = false -- basedpyright has more kinds
        client.server_capabilities.documentSymbolProvider = false -- basedpyright has more kinds
        client.server_capabilities.hoverProvider = false -- basedpyright has more kinds
        client.server_capabilities.inlayHintProvider = false -- basedpyright has more kinds
        client.server_capabilities.referenceProvider = false -- basedpyright has more kinds
        client.server_capabilities.signatureHelpProvider = false -- basedpyright has more kinds
      end,
      settings = {},
    })

    vim.api.nvim_create_augroup("PyreflyKill", { clear = true })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = "PyreflyKill",
    })
    --  end
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedParams = true,
          },
        },
      },
    })

    -- configure lua server (with special settings)
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
}
