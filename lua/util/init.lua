local M = {}

M.auto_open_nvimtree = false
M.auto_open_toggleterm = false
M.colorscheme = "everforest"

function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

function M.notify(msg, type, opts)
  vim.schedule(function() vim.notify(msg, type, M.extend_tbl({ title = "user" }, opts)) end)
end

function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.sleep(a)
  local sec = tonumber(os.clock() + a);
  while (os.clock() < sec) do
  end
end

function M.shell(cmd, show_error)
  if type(cmd) == "string" then cmd = { cmd } end
  if vim.fn.has "win32" == 1 then cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd) end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar "shell_error" == 0
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
  end
  return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

function M.ColorMyPencils(color)
  color = color or "vscode"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function M.build_project()
  local runners = { rust = 'cargo build' }

  local buf = vim.api.nvim_buf_get_name(0)
  local ftype = vim.filetype.match({ filename = buf })
  if runners[ftype] ~= nil then
    require('toggleterm').exec(runners[ftype])
  elseif vim.fn.empty(vim.fn.glob("CMakeLists.txt")) == 0 then
    local job = require('cmake').configure()
    if job then
      job:after(vim.schedule_wrap(
        function(_, exit_code)
          if exit_code == 0 then
            vim.cmd("CMake select_target")
            vim.cmd("CMake build")
          else
            vim.notify("Target build failed", vim.log.levels.ERROR, { title = 'CMake' })
          end
        end
      ))
    end
  else
    return
  end
end

function M.run_release()
  -- Code Runner - execute commands in a floating terminal
  local interpreted = { lua = 'lua', javascript = 'node', python = 'python' }
  local compiled = { rust = 'cargo run -r', }
  local buf = vim.api.nvim_buf_get_name(0)
  local ftype = vim.filetype.match({ filename = buf })
  if compiled[ftype] ~= nil then
    require('toggleterm').exec(compiled[ftype])
  elseif interpreted[ftype] ~= nil then
    require('toggleterm').exec(interpreted[ftype] .. " " .. buf)
  end
end

return M