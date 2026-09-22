-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- VMware host<->guest clipboard: vmtoolsd's dndcp plugin is X11-only and GTK
-- must start on XWayland (GDK_BACKEND=x11), otherwise it loads against Wayland
-- GTK and silently fails. clipsync then bridges the X11 selection into the
-- Wayland clipboard so native apps can paste host copies, and vice versa.
o.launch_on_start("env GDK_BACKEND=x11 vmtoolsd -n vmusr")
o.launch_on_start("env DISPLAY=:0 WAYLAND_DISPLAY=wayland-1 clipsync watch")
