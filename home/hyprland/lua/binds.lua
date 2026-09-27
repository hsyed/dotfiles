-- Keybindings and mouse binds.
-- Every bind carries a desc; SUPER+F1 shows a searchable cheatsheet built
-- from `hyprctl binds -j`.

local mod = "SUPER"
local hyper = "SUPER + CTRL + ALT + SHIFT"
local terminal = "ghostty"
local browser = "chromium --new-window --ozone-platform=wayland"

local function webapp(url)
	return hl.dsp.exec_cmd(browser .. ' --app="' .. url .. '"')
end

hl.bind(mod .. " + Q", hl.dsp.window.close(), { desc = "Close window" })
hl.bind(mod .. " + SHIFT + Escape", hl.dsp.exec_cmd("uwsm stop"), { desc = "End Hyprland session" })
hl.bind(hyper .. " + F", hl.dsp.window.float({ action = "toggle" }), { desc = "Toggle floating" })

-- Mac-style editing: meta+<key> delivers ctrl+<key> to the focused window.
-- keyd cannot do this on the moonlander (its firmware hyper chord includes
-- meta), so hyprland forwards the shortcut itself.
--
-- Terminals are the exception: there ctrl+c/x/v are control codes (SIGINT,
-- SIGQUIT-adjacent, quoted-insert), and the clipboard lives on the shifted
-- chord. A function dispatcher runs per keypress, so the substitution is
-- decided from the focused window instead of being configured per app. Cut
-- degrades to copy — a terminal has no cut.
--
-- Paste is the exception to the exception: it stays on plain ctrl+v so the byte
-- reaches the TUI. Claude Code needs it to pull an image off the clipboard
-- with wl-paste; ghostty text paste stays on ctrl+shift+v.
local terminal_classes = {
	["com.mitchellh.ghostty"] = true,
	["com.mitchellh.ghostty.btop"] = true,
}

local terminal_clipboard = { c = "c", x = "c" }

-- ctrl+z is SIGTSTP in a terminal, not undo — swallow it instead.
local terminal_blocked = { z = true }

for key, desc in pairs({
	c = "Copy",
	v = "Paste",
	x = "Cut",
	a = "Select all",
	z = "Undo",
	r = "Reload",
	f = "Find",
	n = "New",
	t = "New tab",
}) do
	hl.bind(mod .. " + " .. key, function()
		local window = hl.get_active_window()
		local in_terminal = window and terminal_classes[window.class]
		if in_terminal and terminal_blocked[key] then
			return
		elseif in_terminal and terminal_clipboard[key] then
			hl.dispatch(hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = terminal_clipboard[key] }))
		else
			hl.dispatch(hl.dsp.send_shortcut({ mods = "CTRL", key = key }))
		end
	end, { desc = desc })
end

-- Launch-or-close toggle shown as a centered floating modal. For tray apps,
-- closing the window minimizes to the tray and re-running the command raises
-- the running instance. class is an exact match. The float is a window rule
-- rather than a dispatch so it applies before the first frame; floating after
-- mapping would tile the window first and re-lay out the workspace.
local function toggle_app(class, cmd)
	hl.window_rule({
		name = class .. "-toggle-modal",
		match = { class = class },
		float = true,
		center = true,
	})
	return function()
		local window = hl.get_windows({ class = class })[1]
		if window then
			hl.dispatch(hl.dsp.window.close({ window = window }))
		else
			hl.dispatch(hl.dsp.exec_cmd(cmd))
		end
	end
end

-- Raise over MPRIS rather than re-running spotify: a second process races the
-- running one, its window flickers focus and sometimes closes itself.
hl.bind(
	hyper .. " + M",
	toggle_app(
		"spotify",
		"busctl --user call org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2 Raise || spotify"
	),
	{ desc = "Toggle Spotify" }
)
hl.bind(hyper .. " + B", hl.dsp.exec_cmd(browser), { desc = "Browser" })
hl.bind(hyper .. " + L", hl.dsp.exec_cmd("logseq"), { desc = "Logseq" })
hl.bind(hyper .. " + O", hl.dsp.exec_cmd("obsidian"), { desc = "Obsidian" })
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd("loginctl lock-session"), { desc = "Lock screen" })

-- terminal
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal), { desc = "Terminal" })
hl.bind(
	hyper .. " + D",
	-- own class so the toggle and modal rule don't catch the main terminal
	toggle_app(
		"com.mitchellh.ghostty.btop",
		-- window size is in cells: ~10x21px each, so ~2560x1080 (half by three
		-- quarters of the 5120x1440 ultrawide), set before the first frame
		terminal
			.. " --class=com.mitchellh.ghostty.btop --window-width=258 --window-height=50"
			.. " --confirm-close-surface=false -e btop"
	),
	{ desc = "System monitor (btop)" }
)
hl.bind(
	hyper .. " + E",
	hl.dsp.exec_cmd(terminal .. " --confirm-close-surface=false -e yazi", { float = true }),
	{ desc = "File manager (yazi)" }
)

-- rofi
hl.bind(
	mod .. " + Space",
	hl.dsp.exec_cmd('rofi -show combi -combi-modes "window,drun,ssh" -modes combi'),
	{ desc = "App launcher" }
)
hl.bind(
	mod .. " + CTRL + C",
	hl.dsp.exec_cmd("rofi -modi clipboard:cliphist-rofi-img -show clipboard -show-icons"),
	{ desc = "Clipboard history" }
)
hl.bind(
	mod .. " + CTRL + Space",
	hl.dsp.exec_cmd("rofimoji --action type clipboard --typer ydotool --clipboarder wl-copy"),
	{ desc = "Emoji picker" }
) -- ydotool for XWayland support

-- keybind cheatsheet: mods+key + description of every bind that has one
local cheatsheet =
	[[hyprctl binds -j | jq -r '.[] | select(.description != "") | ([(if .modmask >= 64 then "SUPER" else empty end), (if (.modmask/8|floor)%2 == 1 then "ALT" else empty end), (if (.modmask/4|floor)%2 == 1 then "CTRL" else empty end), (if .modmask%2 == 1 then "SHIFT" else empty end), .key] | join("+")) + "\t" + .description' | sort | column -ts "$(printf '\t')" | rofi -dmenu -i -p keys]]
hl.bind(mod .. " + F1", hl.dsp.exec_cmd(cheatsheet), { desc = "Keybind cheatsheet" })

-- web apps
hl.bind(hyper .. " + A", webapp("https://claude.ai/new"), { desc = "Claude" })
hl.bind(hyper .. " + X", webapp("https://x.com"), { desc = "X" })
hl.bind(hyper .. " + Y", webapp("https://youtube.com"), { desc = "YouTube" })

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
hl.bind(mod .. " + SHIFT + Q", hl.dsp.layout("orientationleft"), { desc = "Master on left" })
hl.bind(mod .. " + SHIFT + W", hl.dsp.layout("orientationcenter"), { desc = "Master in center" })
hl.bind(mod .. " + SHIFT + E", hl.dsp.layout("orientationright"), { desc = "Master on right" })
hl.bind(mod .. " + SHIFT + S", hl.dsp.layout("swapwithmaster"), { desc = "Swap with master" })

-- Move focus with mod + vim keys / arrow keys
-- Move windows with mod + SHIFT + vim keys / arrow keys
local directions = {
	h = "left",
	l = "right",
	k = "up",
	j = "down",
	left = "left",
	right = "right",
	up = "up",
	down = "down",
}
for key, direction in pairs(directions) do
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = direction }), { desc = "Focus " .. direction })
	hl.bind(
		mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ direction = direction }),
		{ desc = "Move window " .. direction }
	)
end

-- Switch workspaces with mod + [0-9]
-- Move active window to a workspace with mod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }), { desc = "Workspace " .. i })
	hl.bind(
		mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ desc = "Move window to workspace " .. i }
	)
end

-- Toggle between the two most recent workspaces (needs binds.allow_workspace_cycles)
hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }), { desc = "Previous workspace" })

-- Scratchpad: drop-in special workspace
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("scratch"), { desc = "Toggle scratchpad" })
hl.bind(
	mod .. " + SHIFT + S",
	hl.dsp.window.move({ workspace = "special:scratch" }),
	{ desc = "Move window to scratchpad" }
)

-- Screenshot binds
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot --clipboard-only -m region"), { desc = "Screenshot region" })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --clipboard-only -m window"), { desc = "Screenshot window" })

-- Wallpaper control
hl.bind(mod .. " + slash", hl.dsp.exec_cmd("$HOME/.local/bin/awwwutil next"), { desc = "Next wallpaper" })

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, desc = "Drag window" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "Resize window" })

-- Dictation: hold SUPER+D, speak, release. voxtype grabs this from evdev
-- itself (see ../voxtype.nix), because hyprland does not deliver the D release
-- once SUPER is already up, which is the order the moonlander sends.
--
-- This bind does nothing on purpose. evdev reads below the compositor and does
-- not consume the key, so without it the held D also reaches the focused window
-- and types dddddd while you dictate. A consuming bind swallows it here while
-- voxtype still sees the raw key underneath. No `repeating`, so holding it down
-- fires once.
hl.bind(mod .. " + D", function() end, { desc = "Dictate (hold)" })
