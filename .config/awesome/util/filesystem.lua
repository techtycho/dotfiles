local M = {}

M.user = os.getenv("USER")
M.dir  = "/home/" .. M.user .. "/.config/awesome/"

M.asset = function(path)
  return _G.subdirs.assets .. path
end

return M
