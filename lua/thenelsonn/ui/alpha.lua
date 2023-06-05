local alpha_status, alpha = pcall(require, "alpha")
if not alpha_status then
  return
end

local dashboard = require("alpha.themes.dashboard")

-- Header highlight color
dashboard.section.header.opts.hl = "Constant"

-- Header Contents
dashboard.section.header.val = {
  [[                                                     ]],
  [[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
  [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
  [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
  [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
  [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
  [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
  [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
  [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
  [[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
  [[                                 ░                   ]],
}

-- Buttons
dashboard.section.buttons.val = {
  dashboard.button("e", "󰈔  : New file", ":ene <BAR> startinsert <CR>"),
  -- dashboard.button("f", "󰈞  : Find file", ":Telescope find_files <CR>"),
  -- dashboard.button("b", "󰝰  : Browse files", ":Telescope file_browser <CR>"),
  dashboard.button("c", "  : Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
  dashboard.button("q", "󰅙  : Quit NVIM", ":qa<CR>"),
}

dashboard.config.opts.noautocmd = true

-- Set up footer
local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.config)
