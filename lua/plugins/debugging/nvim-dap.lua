return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dapui = require("dapui")

      require("dapui").setup()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
      })

      local map = vim.keymap.set
      map("n", "<F5>", function()
        require("dap").continue()
      end, { desc = "Continue or attach to debugger." })
      map("n", "<F10>", function()
        require("dap").step_over()
      end, { desc = "Step over." })
      map("n", "<F11>", function()
        require("dap").step_into()
      end, { desc = "Step into." })
      map("n", "<F12>", function()
        require("dap").step_out()
      end, { desc = "Step out of." })
      map("n", "<Leader>zb", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Toggle a breakpoint." })
      map("n", "<Leader>zB", function()
        require("dap").set_breakpoint()
      end, { desc = "Set a breakpoint." })
      map("n", "<Leader>zlp", function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Log a message at a point." })
      map("n", "<Leader>zdr", function()
        require("dap").repl.open()
      end, { desc = "Open the dap repl." })
      map("n", "<Leader>zdl", function()
        require("dap").run_last()
      end, { desc = "Run last." })

      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv("home") },
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
        },
      }
    end,
  },
}
