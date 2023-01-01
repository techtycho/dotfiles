local M = {}

M.dmenu = function(conf)
  local cmd = " "
  local cmd_name = "dmenu_run"
  local flags = {
    font   = { "-fn", true },
    prompt = { "-p", true },
    accent = { "-sb", true },
    height = { "-h", false },
  }

  for k, v in pairs(conf) do
    if flags[k] then
      cmd = cmd .. flags[k][1] .. " " .. (flags[k][2] and "'" or "") .. v .. (flags[k][2] and "'" or "") .. " "
    end
  end

  return cmd_name .. cmd
end

return M
