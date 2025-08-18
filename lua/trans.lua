local persistent = (function()
  local m = {}
  local filepath = vim.fn.stdpath('config') .. '/trans_bool.lua'

  function m.save(value)
    local lines = { "return " .. tostring(value) }
    vim.fn.writefile(lines, filepath)
  end

  function m.load(default)
    local ok, value = pcall(dofile, filepath)
    if ok and value ~= nil then
      return value
    else
      return default
    end
  end

  return m
end)()


local M = {}

M.is_bg_trans = persistent.load(1)

function M.toggle_vim_trans()
    M.is_bg_trans = not M.is_bg_trans

    if M.is_bg_trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    else
        vim.cmd("colorscheme " .. vim.g.colors_name)
    end

    persistent.save(M.is_bg_trans)
end


local function set_cmd_trans(enabled)
  if type(enabled) ~= "boolean" then
    vim.notify("Expected boolean argument to set_cmd_trans", vim.log.levels.ERROR)
    return
  end

  local new_opacity = enabled and 50 or 100

  local settings_json_path = "/mnt/c/Users/giall/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

  local file = io.open(settings_json_path, "r")
  if not file then
    vim.notify("Failed to open settings.json", vim.log.levels.ERROR)
    return
  end

  local content = file:read("*a")
  file:close()

  local ok, data = pcall(vim.fn.json_decode, content)
  if not ok or type(data) ~= "table" then
    vim.notify("Failed to parse settings.json", vim.log.levels.ERROR)
    return
  end

  local edited = false
  for _, profile in ipairs(data.profiles and data.profiles.list or {}) do
    if profile.name == "Command Prompt" then
      profile.opacity = new_opacity
      edited = true
    end
  end

  if not edited then
    vim.notify("Command Prompt profile not found", vim.log.levels.WARN)
    return
  end

  local new_json = vim.fn.json_encode(data)

  local out = io.open(settings_json_path, "w")
  if not out then
    vim.notify("Failed to write settings.json", vim.log.levels.ERROR)
    return
  end

  out:write(new_json)
  out:close()
end

function M.toggle_all_trans()
    set_cmd_trans(not M.is_bg_trans)
    M.toggle_vim_trans()
end

return M

