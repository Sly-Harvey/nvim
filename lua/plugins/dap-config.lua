return {
  'rcarriga/nvim-dap-ui',
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      'jay-babu/mason-nvim-dap.nvim',
      event = { "BufReadPost", "BufAdd", "BufNewFile" },
      cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
      dependencies = {
        { "folke/neodev.nvim", opts = {} },
        'williamboman/mason.nvim',
      },
      opts = {
        automatic_setup = false,
        ensure_installed = { "codelldb" },
        handlers = {},
      }
    },
    {
      'Weissle/persistent-breakpoints.nvim',
      config = function ()
        require('persistent-breakpoints').setup({
          save_dir = vim.fn.stdpath('data') .. '/breakpoints',
          load_breakpoints_event = { "BufReadPost" } 
        })
      end
    },
    {"dnlhc/glance.nvim", cmd = "Glance"},
    'tpope/vim-sleuth',
    { "folke/neodev.nvim", opts = {} },
    'mfussenegger/nvim-dap',
    {
      "theHamsta/nvim-dap-virtual-text",
      config = true
    },
  },
    
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
      dap.repl.close()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
      dap.repl.close()
    end
    
    -- default rust debug code:
    --program = function()
    --  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    --end,
    
    --$CWD_FULL/target/debug/$CWD
    
    
    dap.configurations.rust= {
      {
        name = "Debug",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.getcwd() .. '/target/debug/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        showDisassembly = "never"
      },
    }
    
    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        name = "Debug";
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
    
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    
        program = function()
          sleep(0.1)
          return "${file}";
        end, -- This configuration will launch the current file if used.
        pythonPath = 'python',
        cwd = "${workspaceFolder}",
        console = 'integratedTerminal'
      },
    }
    
    --vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
    --vim.keymap.set("n", "<Leader>dx", function() dap.terminate() end)
    vim.keymap.set({'n', 'i', 'v', 'x'}, '<F17>', function()
      vim.cmd('stopinsert')
      dap.terminate()
      --dap.repl.close()
    end)

    vim.keymap.set({'n', 'i', 'v', 'x'}, '<S-F5>', function()
      vim.cmd('stopinsert')
      dap.terminate()
      --dap.repl.close()
    end)
    
    vim.keymap.set('n', '<C-b>', build_project)

    vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<F5>', function()
      if vim.fn.empty(vim.fn.glob("CMakeLists.txt")) == 0 then
        local job = require('cmake').configure()
        if job then
          job:after(vim.schedule_wrap(
            function(_, exit_code)
              if exit_code == 0 then
                vim.cmd("CMake select_target")
                require('FTerm').close()
                require("nvim-tree.api").tree.close()
                vim.cmd('startinsert')
                sleep(0.05)
                vim.cmd("CMake build_and_debug")
                dap.repl.close()
              else
                vim.notify("Target debug failed", vim.log.levels.ERROR, { title = 'CMake' })
              end
            end
          ))
        end
      else
        require('FTerm').close()
        require("nvim-tree.api").tree.close()
        vim.cmd('startinsert')
        sleep(0.05)
        dap.continue()
      end
    end)
    --vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<F6>', run_release)
    vim.keymap.set('t', '<C-c>', '<C-c><CMD>lua require("FTerm").close()<CR>', opts)
    vim.keymap.set('n', '<Leader>dt', function() dapui.toggle() end)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    vim.keymap.set('i', '<F10>', function() dap.step_over() end)
    vim.keymap.set('i', '<F11>', function() dap.step_into() end)
    vim.keymap.set('i', '<F12>', function() dap.step_out() end)
    vim.keymap.set('n', '<Leader>b', function() require('persistent-breakpoints.api').toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() require('persistent-breakpoints.api').set_conditional_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)
  end
}
