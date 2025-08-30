return {
  "mfussenegger/nvim-dap",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    {
      'jay-babu/mason-nvim-dap.nvim',
      -- event = { "BufReadPost", "BufAdd", "BufNewFile" },
      cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
      -- dependencies = {
      --   { "folke/neodev.nvim", opts = {} },
      -- },
      config = function()
        require("mason-nvim-dap").setup({
          -- Automatically install debuggers
          automatic_installation = true,
          -- Ensure these debuggers are always installed
          ensure_installed = { "codelldb", "debugpy", },
          -- Automatic setup for all handlers
          handlers = {},
        })
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap",
      },
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup({
          enabled = true,
          enabled_commands = true,
          highlight_changed_variables = true,
          highlight_new_as_changed = false,
          show_stop_reason = true,
          commented = false,
          only_first_definition = true,
          all_references = false,
          clear_on_continue = false,
          display_callback = function(variable, buf, stackframe, node, options)
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value
            else
              return variable.name .. ' = ' .. variable.value
            end
          end,
          virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
          all_frames = false,
          virt_lines = false,
          virt_text_win_col = nil
        })
      end,
    },
    {
      'Weissle/persistent-breakpoints.nvim',
      config = function()
        require('persistent-breakpoints').setup({
          save_dir = vim.fn.stdpath('data') .. '/breakpoints',
          load_breakpoints_event = { "BufReadPost" }
        })
      end
    },
    { "dnlhc/glance.nvim", cmd = "Glance" },
    'tpope/vim-sleuth',
  },

  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local util = require("util")

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
      dap.repl.close()
    end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    --   dap.repl.close()
    -- end

    -- default rust debug code:
    --program = function()
    --  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    --end,

    --$CWD_FULL/target/debug/$CWD


    dap.configurations.rust = {
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
    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
          type = 'server',
          port = assert(port, '`connect.port` is required for a python `attach` configuration'),
          host = host,
          options = {
            source_filetype = 'python',
          },
        })
      else
        cb({
          type = 'executable',
          command = 'python',
          args = { '-m', 'debugpy.adapter' },
          options = {
            source_filetype = 'python',
          },
        })
      end
    end
    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        name = "Debug",
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = function()
          util.sleep(0.1)
          return "${file}";
        end, -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
          elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
          else
            return 'python'
          end
        end,
        cwd = "${workspaceFolder}",
        console = 'integratedTerminal',
      },
    }

    --vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
    --vim.keymap.set("n", "<Leader>dx", function() dap.terminate() end)
    vim.keymap.set({ 'n', 'i', 'v', 't', 'x' }, '<F17>', function()
      vim.cmd('stopinsert')
      if dap.session() ~= nil then
        dap.terminate()
      end
      dapui.close()
      if vim.g.auto_open_nvimtree and vim.g.auto_open_toggleterm then
        util.toggle_nvimtree_and_toggleterm()
        vim.cmd('stopinsert')
      elseif vim.g.auto_open_toggleterm and not vim.g.auto_open_nvimtree then
        util.open_terminal()
        vim.cmd('wincmd k')
      elseif vim.g.auto_open_nvimtree and not vim.g.auto_open_toggleterm then
        -- require("nvim-tree.api").tree.find_file({ open = true, focus = false })
      end
      --dap.repl.close()
    end)

    vim.keymap.set({ 'n', 'i', 'v', 't', 'x' }, '<S-F5>', function()
      vim.cmd('stopinsert')
      if dap.session() ~= nil then
        dap.terminate()
      end
      dapui.close()
      if vim.g.auto_open_nvimtree and vim.g.auto_open_toggleterm then
        util.toggle_nvimtree_and_toggleterm()
        vim.cmd('stopinsert')
      elseif vim.g.auto_open_toggleterm and not vim.g.auto_open_nvimtree then
        util.open_terminal()
        vim.cmd('wincmd k')
      elseif vim.g.auto_open_nvimtree and not vim.g.auto_open_toggleterm then
        -- require("nvim-tree.api").tree.find_file({ open = true, focus = false })
      end
      --dap.repl.close()
    end)

    vim.keymap.set('n', '<C-b>', util.build_project)

    vim.keymap.set({ 'n', 'i', 'v', 'x', 't' }, '<F5>', function()
      if vim.fn.empty(vim.fn.glob("CMakeLists.txt")) == 0 then
        local job = require('cmake').configure()
        if job then
          job:after(vim.schedule_wrap(
            function(_, exit_code)
              if exit_code == 0 then
                vim.cmd("CMake select_target")
                -- require('FTerm').close()
                require("nvim-tree.api").tree.close()
                util.close_all_terminals()
                vim.cmd('startinsert')
                vim.cmd("CMake build_and_debug")
                dap.repl.close()
              else
                vim.notify("Target debug failed", vim.log.levels.ERROR, { title = 'CMake' })
              end
            end
          ))
        end
      else
        -- require("toggleterm").exec('exit')
        -- require('FTerm').close()
        require("nvim-tree.api").tree.close()
        util.close_all_terminals()
        vim.cmd('startinsert')
        dap.continue()
      end
    end)
    vim.keymap.set({ 'n', 'i', 'v', 'x', 't' }, '<F6>', util.run_release)
    -- vim.keymap.set('t', '<C-c>', '<C-c><CMD>lua require("toggleterm").close()<CR>', opts)
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
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
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
