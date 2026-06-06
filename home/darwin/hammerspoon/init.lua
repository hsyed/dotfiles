local app_hyperkey = { "cmd", "alt", "ctrl", "shift" }
local terminal_app = "ghostty"

hs.hotkey.bind(app_hyperkey, "return", function()
	hs.application.launchOrFocus(terminal_app)
end)

hs.hotkey.bind(app_hyperkey, "b", function()
	hs.application.launchOrFocus("safari")
end)
