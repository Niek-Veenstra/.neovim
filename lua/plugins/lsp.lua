return {
  "git@github.com:neovim/nvim-lspconfig.git",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "yioneko/nvim-vtsls" },
    { "nvim-lua/plenary.nvim" },
    { "mason-org/mason.nvim" },
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
        "cmake",
        "clangd",
        "intelephense",
        "emmet_language_server",
        "vue_ls",
        "tailwindcss",
        "eslint",
      },
      automatic_installation = {
        "html",
        "cssls",
        "svelte",
        "lua_ls",
        "cmake",
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
          location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          languages = { "vue" },
          filetypes = { "vue" },
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
    }

    local config_graphql = {
      config = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    }
    local vue_ls = {
      on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
          local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
          if #clients == 0 then
            vim.notify("Could not found `vtsls` lsp client, vue_lsp would not work without it.", vim.log.levels.ERROR)
            return
          end
          local ts_client = clients[1]

          local param = unpack(result)
          local id, command, payload = unpack(param)
          ts_client:exec_cmd({
            title = "vue_request_forward",
            command = "typescript.tsserverRequest",
            arguments = {
              command,
              payload,
            },
          }, { bufnr = context.bufnr }, function(_, r)
            local response_data = { { id, r.body } }
            ---@diagnostic disable-next-line: param-type-mismatch
            client:notify("tsserver/response", response_data)
          end)
        end
      end,
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

    vim.lsp.config("vtsls", vtsls_config)
    vim.lsp.config("vhdl_ls", config_vhdl_ls)
    vim.lsp.config("clangd", config_clangd)
    vim.lsp.config("html", config_html)
    vim.lsp.config("intelephense", config_intelephense)
    vim.lsp.config("lua_ls", config_lua_ls)
    vim.lsp.config("emmet_language_server", config_emmet_language_server)
    vim.lsp.config("graphql", config_graphql)
    vim.lsp.config("tailwindcss", config_tailwindcss)
    vim.lsp.config("svelte", config_svelte)
    vim.lsp.config("vue_ls", vue_ls)

    vim.lsp.enable("cmake")
    vim.lsp.enable("vtsls")
    vim.lsp.enable("vhdl_ls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("html")
    vim.lsp.enable("intelephense")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("emmet_language_server")
    vim.lsp.enable("graphql")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("svelte")
    vim.lsp.enable("vue_ls")
  end,
}
