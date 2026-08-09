-- Keybindings and mouse binds.

local mod      = "SUPER"
local terminal = "ghostty"
local browser  = "chromium --new-window --ozone-platform=wayland"

local function webapp(url)
  return hl.dsp.exec_cmd(browser .. ' --app="' .. url .. '"')
end

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Escape", hl.dsp.exit()) -- kill hyprland
hl.bind(mod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mod .. " + M", hl.dsp.exec_cmd("spotify")) -- Spotify
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser)) -- Browser
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd("hyprlock")) -- Lock screen without grace period for credentials

-- terminal
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal)) -- Terminal
hl.bind(mod .. " + D", hl.dsp.exec_cmd(terminal .. " --confirm-close-surface=false -e btop")) -- System monitor
hl.bind(mod .. " + E", hl.dsp.exec_cmd(terminal .. " --confirm-close-surface=false -e yazi", { float = true })) -- File manager

-- rofi
hl.bind(mod .. " + Space", hl.dsp.exec_cmd('rofi -show combi -combi-modes "window,drun,ssh" -modes combi')) -- App launcher
hl.bind(mod .. " + CTRL + C", hl.dsp.exec_cmd("rofi -modi clipboard:cliphist-rofi-img -show clipboard -show-icons")) -- Clipboard history
hl.bind(mod .. " + CTRL + Space", hl.dsp.exec_cmd("rofimoji --action type clipboard --typer ydotool --clipboarder wl-copy")) -- Emoji picker with ydotool for XWayland support

-- web apps
hl.bind(mod .. " + SHIFT + A", webapp("https://claude.ai/new"))
hl.bind(mod .. " + SHIFT + X", webapp("https://x.com"))
hl.bind(mod .. " + SHIFT + Y", webapp("https://youtube.com"))

-- Master layout orientation — Q/W/E map spatially to left/center/right, S swaps master.
--
-- In master layout, the screen is divided into a master area and a slave stack.
-- Orientation controls which side the master occupies:
--
--   orientationleft   (Q): master on left,   slaves fill right  → e.g. 1:1, 2:1, 1:2
--   orientationcenter (W): master in center,  slaves on both sides → e.g. 1:2:1, 1:2:2
--   orientationright  (E): master on right,   slaves fill left   → e.g. 1:1, 1:2, 2:1
--   swapwithmaster    (S): focused window becomes master, old master demoted to slave
--                         — use this to canonically pick which window is master
hl.bind(mod .. " + SHIFT + Q", hl.dsp.layout("orientationleft"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.layout("orientationcenter"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.layout("orientationright"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.layout("swapwithmaster"))

-- Move focus with mod + vim keys / arrow keys
-- Move windows with mod + SHIFT + vim keys / arrow keys
local directions = {
  h = "left", l = "right", k = "up", j = "down",
  left = "left", right = "right", up = "up", down = "down",
}
for key, direction in pairs(directions) do
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

-- Switch workspaces with mod + [0-9]
-- Move active window to a workspace with mod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Screenshot binds
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot --clipboard-only -m region"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --clipboard-only -m window"))

-- Wallpaper control
hl.bind(mod .. " + slash", hl.dsp.exec_cmd("$HOME/.local/bin/awwwutil next"))

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
