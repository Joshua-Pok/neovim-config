return {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      -- DAP UI for a better debugging experience
      {
        'rcarriga/nvim-dap-ui',
        lazy = true,
        dependencies = { 'nvim-neotest/nvim-nio' },
        opts = {
          layouts = {
            {
              elements = {
                { id = 'scopes', size = 0.25 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
                { id = 'watches', size = 0.25 },
              },
              size = 40,
              position = 'left',
            },
            {
              elements = { 'repl', 'console' },
              size = 10,
              position = 'bottom',
            },
          },
        },
        config = function(_, opts)
          local dap = require 'dap'
          local dapui = require 'dapui'
          dapui.setup(opts)
          -- Auto-open/close DAP UI
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open {}
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close {}
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close {}
          end
        end,
      },
      -- Virtual text for variable values
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
          enabled = true,
          enabled_commands = true,
          highlight_changed_variables = true,
        },
      },
      -- Mason integration for DAP
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
          ensure_installed = { 'python', 'js-debug-adapter' },
          automatic_installation = true,
          handlers = {
            python = function(config)
              -- Handled by nvim-dap-python below
              require('mason-nvim-dap').default_setup(config)
            end,
            -- JavaScript/TypeScript handler
            js_debug_adapter = function(config)
              config.adapters = {
                type = 'executable',
                command = vim.fn.stdpath 'data' .. '\\mason\\bin\\js-debug-adapter.cmd',
                args = {},
              }
              require('mason-nvim-dap').default_setup(config)
            end,
          },
        },
      },
      -- Python DAP extension
      {
        'mfussenegger/nvim-dap-python',
        lazy = true,
        ft = 'python',
        config = function()
          local python_path = vim.fn.stdpath 'data' .. '\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe'
          require('dap-python').setup(python_path)
          -- Optional: Add custom Python configurations
          table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Launch file with custom args',
            program = '${file}',
            args = function()
              local args_string = vim.fn.input 'Arguments: '
              return vim.split(args_string, ' ')
            end,
            pythonPath = function()
              -- Use project-specific virtualenv if available
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. '\\venv\\Scripts\\python.exe') == 1 then
                return cwd .. '\\venv\\Scripts\\python.exe'
              elseif vim.fn.executable(cwd .. '\\.venv\\Scripts\\python.exe') == 1 then
                return cwd .. '\\venv\\Scripts\\python.exe'
              else
                return python_path
              end
            end,
          })
        end,
      },
      -- JavaScript/TypeScript DAP extension
      {
        'mxsdev/nvim-dap-vscode-js',
        lazy = true,
        dependencies = {
          {
            'microsoft/vscode-js-debug',
            build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && move dist out',
          },
        },
        config = function()
          require('dap-vscode-js').setup {
            debugger_path = vim.fn.stdpath 'data' .. '\\lazy\\vscode-js-debug',
            adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
          }
          for _, language in ipairs { 'javascript', 'typescript' } do
            require('dap').configurations[language] = {
              {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch file',
                program = '${file}',
                cwd = '${workspaceFolder}',
                sourceMaps = true,
                protocol = 'inspector',
                console = 'integratedTerminal',
              },
              {
                type = 'pwa-node',
                request = 'attach',
                name = 'Attach to process',
                processId = require('dap.utils').pick_process,
                cwd = '${workspaceFolder}',
                sourceMaps = true,
              },
              {
                type = 'pwa-chrome',
                request = 'launch',
                name = 'Launch Chrome',
                url = 'http://localhost:3000',
                webRoot = '${workspaceFolder}',
                sourceMaps = true,
              },
            }
          end
        end,
      },
    },
    -- Keybindings for DAP
    keys = {
      { '<leader>dc', "<cmd>lua require('dap').continue()<CR>", desc = 'Continue' },
      { '<leader>db', "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = 'Toggle Breakpoint' },
      { '<leader>dB', "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = 'Conditional Breakpoint' },
      { '<leader>do', "<cmd>lua require('dap').step_over()<CR>", desc = 'Step Over' },
      { '<leader>di', "<cmd>lua require('dap').step_into()<CR>", desc = 'Step Into' },
      { '<leader>dO', "<cmd>lua require('dap').step_out()<CR>", desc = 'Step Out' },
      { '<leader>dr', "<cmd>lua require('dap').repl.toggle()<CR>", desc = 'Toggle REPL' },
      { '<leader>du', "<cmd>lua require('dapui').toggle()<CR>", desc = 'Toggle DAP UI' },
      { '<leader>dPt', "<cmd>lua require('dap-python').test_method()<CR>", desc = 'Debug Python Method', ft = 'python' },
      { '<leader>dPc', "<cmd>lua require('dap-python').test_class()<CR>", desc = 'Debug Python Class', ft = 'python' },
    },
    config = function()
      -- Set log level for debugging issues
      require('dap').set_log_level 'INFO'
    end,
  }