# hyprlock
Crashing after monitor power down -- NVIDIA EGL teardown bug.

SIGSEGV in `CTexture::~CTexture()` via `CAsyncResourceManager` destructor during exit cleanup.
EGL context is torn down before the async resource manager texture cache is cleared.

**Upstream status (2026-03-29):**
- PR #884 (merged, v0.9.3) fixed `CRenderer`/`CShader` ordering but does NOT cover `CAsyncResourceManager` -- still crashing on 0.9.3.
- Related open issues: #793 `[NVIDIA] hyprlock crashing when waking up from suspend`, #695 `[NVIDIA] no UI on wake from suspend`.
- Crash is post-unlock (screen already released), so no security impact -- just the crash itself.
- Track #793 for resolution.

