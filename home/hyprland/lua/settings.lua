-- Monitor, environment, look-and-feel, animations, and window rules.
-- Colors (borders, shadow color, groupbar) are injected by stylix through the
-- Home Manager module's `settings` — don't set them here.

-----------------
---- MONITOR ----
-----------------

-- bitdepth = 10 = 10-bit color depth (1024 shades per RGB channel)
-- cm = "hdr" = HDR color management with wide gamut and PQ transfer function
-- sdrbrightness = 1.45 = SDR content brightness in HDR mode (1.0-2.0 range)
-- sdrsaturation = 1.2 = SDR content saturation boost in HDR mode
-- 2080ti power draw: 120hz = ~21w, 240hz = ~65w power draw
hl.monitor({
  output   = "",
  mode     = "5120x1440@120",
  position = "auto",
  scale    = 1,
})

------------------------------
---- ENVIRONMENT (cursor) ----
------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("XCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in     = 1,
    gaps_out    = 3,
    border_size = 3,
    layout      = "master",
  },

  decoration = {
    rounding = 10,
    blur = {
      enabled = true,
      size    = 3,
      passes  = 1,
    },
    shadow = {
      enabled      = true,
      range        = 4,
      render_power = 3,
    },
  },

  animations = { enabled = true },

  input = {
    kb_layout    = "us",
    follow_mouse = 1,
    touchpad = {
      natural_scroll = false,
    },
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification
    -- accel_profile = "flat", -- flat acceleration curve.
    force_no_accel = true, -- force disable acceleration
  },

  -- Master layout configuration (see: https://wiki.hypr.land/Configuring/Layouts/Master-Layout/)
  -- - Master window always centered (orientation = "center")
  -- - New windows become slaves to preserve master centrality
  -- - pain point: closing left slave with a right slave causes it to take the position of the left.
  master = {
    new_status = "slave", -- New windows become slaves
    new_on_top = false, -- New slaves added to bottom
    mfact = 0.55, -- Master takes 55% of screen
    orientation = "center", -- place the master in the center
    slave_count_for_center_master = 0, -- Center master all the time
  },
})

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 3.5, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3.5, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,   bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 3.5, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 1.5, bezier = "default", style = "fade" })

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
  name  = "global-opacity",
  match = { class = ".*" },
  opacity = "0.98 0.95",
})

hl.window_rule({
  name  = "opaque-media",
  match = { class = "(chromium-browser|mpv)" },
  opacity = "1.0 1.0",
})
