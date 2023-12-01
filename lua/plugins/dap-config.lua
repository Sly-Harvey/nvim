local dap, dapui = require("dap"), require("dapui")

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- default rust debug code:
--program = function()
--  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
--end,

--$CWD_FULL/target/debug/$CWD

local function sleep(a) 
  local sec = tonumber(os.clock() + a); 
  while (os.clock() < sec) do 
  end 
end


-- backup code for build function
--local function build()
--  -- Code Runner - execute commands in a floating terminal
--  local interpreted = { lua = 'lua', javascript = 'node', python = 'python' }
--  local compiled = { rust = 'cargo build' }
--
--  local buf = vim.api.nvim_buf_get_name(0)
--  local ftype = vim.filetype.match({ filename = buf })
--  local exec = nil
--  if compiled[ftype] ~= nil then
--    require('FTerm').run({ compiled[ftype] })
--  elseif interpreted[ftype] ~= nil then
--    require('FTerm').run({ interpreted[ftype], buf })
--  else return end
--end


dap.configurations.rust= {
  {
    name = "Debug",
    type = "codelldb",
    request = "launch",
    program = function()
      require("nvim-tree.api").tree.close()
      vim.cmd('startinsert')
      require('FTerm').close()
      sleep(0.1)
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
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    name = "Debug";
    request = 'launch';

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = function()
      require("nvim-tree.api").tree.close()
      vim.cmd('startinsert')
      require('FTerm').close()
      sleep(0.1)
      return "${file}";
    end; -- This configuration will launch the current file if used.
    pythonPath = 'python';
    cwd = "${workspaceFolder}";
    console = 'integratedTerminal'
  },
}

--vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
--vim.keymap.set("n", "<Leader>dx", function() dap.terminate() end)
vim.keymap.set({'n', 'i', 'v', 'x'}, '<F17>', function()
  vim.cmd('stopinsert')
  dap.terminate()
end)

vim.keymap.set('n', '<C-b>', build_project)
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<F5>', function()
  require('FTerm').close()
  dap.continue() end)
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<F6>', run_release)
vim.keymap.set('n', '<Leader>dt', function() dapui.toggle() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('i', '<F10>', function() dap.step_over() end)
vim.keymap.set('i', '<F11>', function() dap.step_into() end)
vim.keymap.set('i', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
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
