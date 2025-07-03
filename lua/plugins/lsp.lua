return {
  "git@github.com:neovim/nvim-lspconfig.git",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "yioneko/nvim-vtsls" },
    { "nvim-lua/plenary.nvim" },
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  opts = {},
  config = function()
    local utilities = require("lspconfig.util")
    local esp32 = require("esp32")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "svelte",
        "lua_ls",
        "vtsls",
        "pyright",
        "clangd",
        "intelephense",
        "emmet_language_server",
        "ts_ls",
        "tailwindcss",
        "volar",
        "eslint",
      },
      automatic_installation = {
        "html",
        "cssls",
        "svelte",
        "lua_ls",
        "pyright",
        "clangd",
        "intelephense",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", {}),
      callback = function(ev)
        local keymap = vim.keymap
        local opts = { buffer = ev.buf, silent = true }
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

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.get_prev_pos, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.get_next_pos, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    local vue_language_server_path = vim.fn.stdpath("data")
      .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
    local vtsls_config = {
      config = capabilities,
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      settings = {
        vtsls = { tsserver = { globalPlugins = {} } },
        typescript = {
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
      },
      before_init = function(_, config)
        table.insert(config.settings.vtsls.tsserver.globalPlugins, {
          name = "@vue/typescript-plugin",
          location = vim.fn.expand(vue_language_server_path),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        })
      end,
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    }
    local config_svelte = {
      config = capabilities,
      on_attach = function(client)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    }
    local config_tailwindcss = {
      config = capabilities,
      root_dir = utilities.root_pattern(".git", "package.json", "package-lock.json", "tsconfig.json", "jsconfig.json"),
    }

    local config_graphql = {
      config = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    }

    local config_emmet_language_server = {
      config = capabilities,
      filetypes = {
        "css",
        "vue",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "pug",
        "typescriptreact",
      },
      init_options = {
        ---@type table<string, string>
        includeLanguages = {},
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
        --- @type table<string, any>
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
      },
    }

    local config_lua_ls = {
      config = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }

    local config_intelephense = {
      config = capabilities,
      filetypes = { "php", "phtml" },
      root_dir = utilities.root_pattern(".git", ".exercism"),
      files = {
        associations = { "php", "phtml" },
      },
    }

    local config_html = {
      config = capabilities,
      filetypes = { "php", "phtml", "html" },
      root_dir = utilities.root_pattern(".git"),
    }

    local config_clangd = esp32.lsp_config({
      config = capabilities,
      cmd = {
        "clangd",
        "--log=verbose",
        "--pretty",
        "--background-index",
        "--header-insertion=iwyu",
        "--enable-config",
        "--query-driver=/home/niekv/.espressif/tools/**",
      },
      filetypes = { "h", "cpp", "cc", "cxx", "c" },
      root_dir = utilities.root_pattern("compile_commands.json", ".git", "Makefile", "sdkconfig", "managed_components"),
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    })

    local config_vhdl_ls = {
      config = capabilities,
      filetypes = { "vhdl" },
      root_dir = utilities.root_pattern("clash-manifest.json"),
    }

    local lspconfig = require("lspconfig")
    lspconfig["vtsls"].setup(vtsls_config)
    lspconfig["vhdl_ls"].setup(config_vhdl_ls)
    lspconfig["clangd"].setup(config_clangd)
    lspconfig["html"].setup(config_html)
    lspconfig["intelephense"].setup(config_intelephense)
    lspconfig["lua_ls"].setup(config_lua_ls)
    lspconfig["emmet_language_server"].setup(config_emmet_language_server)
    lspconfig["graphql"].setup(config_graphql)
    lspconfig["tailwindcss"].setup(config_tailwindcss)
    lspconfig["svelte"].setup(config_svelte)
  end,
}
