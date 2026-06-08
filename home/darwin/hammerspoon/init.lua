local app_hyperkey = { "cmd", "alt", "ctrl", "shift" }

local app_bindings = {
	{ key = "return", app = "ghostty" },
	{ key = "b", app = "Google Chrome" },
	{ key = "l", app = "Logseq" },
	{ key = "m", app = "Spotify" },
	{ key = "s", app = "Slack" },
    { key = "z", app = "zed" },
}

for _, binding in ipairs(app_bindings) do
	hs.hotkey.bind(app_hyperkey, binding.key, function()
		hs.application.launchOrFocus(binding.app)
	end)
end
