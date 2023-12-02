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


function build_project()
    local runners = { rust = 'cargo build' }
  
    local buf = vim.api.nvim_buf_get_name(0)
    local ftype = vim.filetype.match({ filename = buf })
    if runners[ftype] ~= nil then
      require('FTerm').run({ runners[ftype] })
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