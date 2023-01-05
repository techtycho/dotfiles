local M = {}

M.bash = function(cmd)
  return "bash -c \"" .. cmd .. "\""
end

return M
