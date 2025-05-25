function set_key_binds(opts)
  local keymap = vim.keymap
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
  keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

  opts.desc = "Restart LSP"
  keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
end

return {
  "git@github.com:neovim/nvim-lspconfig.git",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local utilities = require("lspconfig.util")
    local mason_lspconfig = require("mason-lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        set_key_binds(opts)
        opts.desc = "Show LSP references"
      end,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local capabilities = require('blink.cmp').get_lsp_capabilities();
    mason_lspconfig.setup_handlers({
      ["svelte"] = function()
        lspconfig["svelte"].setup({
          on_attach = function(client)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,
      -- ["ts_ls"] = function()
      --   local mason_registry = require('mason-registry')
      --   local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
      --   lspconfig["ts_ls"].setup({
      --     capabilities = capabilities,
      --     init_options = {
      --       plugins = {
      --         {
      --           name = "@vue/typescript-plugin",
      --           location = vue_language_server_path,
      --           languages = {  "vue" },
      --         },
      --       },
      --     }
      --   })
      -- end,
      
      ["volar"] = function()
        lspconfig["volar"].setup({
          capabilities = capabilities,
          init_options = {
            vue = {
              hybridMode = false
            }
          }
        })
      end,
      ["tailwindcss"] = function()
        lspconfig["tailwindcss"].setup({
          capabilities = capabilities,
          root_dir = utilities.root_pattern(".git","package.json","package-lock.json","tsconfig.json","jsconfig.json")
        })
      end,
      ["graphql"] = function()
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_language_server"] = function()
        lspconfig["emmet_language_server"].setup({
          filetypes = { "css","vue", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
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
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
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
        })
      end,
      -- ["gopls"] = function()
      --   lspconfig["gopls"].setup({
      --     filetypes = { "go", "gomod", "gowork", "gotmpl" },
      --     cmd = { "gopls" },
      --     root_dir = utilities.root_pattern("go.work", "go.mod", ".git"),
      --     settings = {
      --       gopls = {
      --         completeUnimported = true,
      --       },
      --     },
      --   })
      -- end,
      ["intelephense"] = function()
        lspconfig["intelephense"].setup({
          capabilities = capabilities,
          filetypes = { "php", "phtml" },
          root_dir = utilities.root_pattern(".git", ".exercism"),
          files = {
            associations = { "php", "phtml" },
          },
        })
      end,
      ["html"] = function()
        lspconfig["html"].setup({
          capabilities = capabilities,
          filetypes = { "php", "phtml", "html" },
          root_dir = utilities.root_pattern(".git"),
        })
      end,
      ["clangd"] = function()
        lspconfig["clangd"].setup({
          capabilities = capabilities,
          cmd = {
            "clangd",
            "--log=verbose",
            "--pretty",
            "--background-index",
            "--header-insertion=iwyu",
          },
          filetypes = { "h", "cpp", "cc", "cxx" },
          root_dir = utilities.root_pattern("compile_commands.json", ".git", "Makefile"),
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        })
      end,
      ["vhdl_ls"] = function()
        lspconfig["vhdl_ls"].setup({
          capabilities = capabilities,
          filetypes = { "vhdl" },
          root_dir = utilities.root_pattern("clash-manifest.json"),
        })
      end,
    })
  end,
}
