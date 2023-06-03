local config = require("util.config")

local M = {}

-- ## APPLICATIONS ## --
-- System
M.terminal = "alacritty"
M.files    = "thunar"
M.launcher = config.dmenu {
  prompt    = "Run:",
  accent_bg = "#5cb6c2",
  accent_fg = "#000",
  normal_bg = "#282c34",
  font      = "JetBrainsMono Nerd Font-9",
  height    = 25,
}

-- Editor
M.editor      = "emacs"
M.editor_dev  = "code" -- VSCode
M.editor_term = "nvim"

-- Web
M.browser  = "firefox"
M.search   = "google.com"
M.git_serv = "github.com"

-- ## COMMANDS ## --
M.editor_term_cmd = M.terminal .. " -e " .. M.editor_term or os.getenv("EDITOR") or "nano"

return M
