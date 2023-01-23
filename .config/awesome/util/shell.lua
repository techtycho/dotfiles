local M = {}

M.sh = function(cmd)
  return "sh -c \"" .. cmd .. "\""
end

M.bash = function(cmd)
  return "bash -c \"" .. cmd .. "\""
end

return M
