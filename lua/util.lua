function build_project()
    runners = { rust = 'cargo build', cpp = 'cmake build' }
  
    buf = vim.api.nvim_buf_get_name(0)
    ftype = vim.filetype.match({ filename = buf })
    if runners[ftype] ~= nil then
      require('FTerm').run({ runners[ftype] })
    else return end
  end
  
function run_release()
-- Code Runner - execute commands in a floating terminal
interpreted = { lua = 'lua', javascript = 'node', python = 'python' }
compiled = { rust = 'cargo run -r' }

buf = vim.api.nvim_buf_get_name(0)
ftype = vim.filetype.match({ filename = buf })
exec = nil
if compiled[ftype] ~= nil then
    require('FTerm').run({ compiled[ftype] })
elseif interpreted[ftype] ~= nil then
    require('FTerm').run({ interpreted[ftype], buf })
else return end
end  