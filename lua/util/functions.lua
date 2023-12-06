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

function shell(args)
  local output = vim.fn.system(args)
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

function ColorMyPencils(color)
	color = color or "vscode"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

--ColorMyPencils()

function build_project()
    local runners = { rust = 'cargo build' }
  
    local buf = vim.api.nvim_buf_get_name(0)
    local ftype = vim.filetype.match({ filename = buf })
    if runners[ftype] ~= nil then
      require('FTerm').run({ runners[ftype] })
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
    else return end
  end
  
function run_release()
-- Code Runner - execute commands in a floating terminal
local interpreted = { lua = 'lua', javascript = 'node', python = 'python' }
local compiled = { rust = 'cargo run -r', }

local buf = vim.api.nvim_buf_get_name(0)
local ftype = vim.filetype.match({ filename = buf })
local exec = nil
if compiled[ftype] ~= nil then
    require('FTerm').run({ compiled[ftype] })
elseif interpreted[ftype] ~= nil then
    require('FTerm').run({ interpreted[ftype], buf })
else return end
end  

function sleep(a) 
  local sec = tonumber(os.clock() + a); 
  while (os.clock() < sec) do 
  end 
end
