hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd "xdg-open ~/.config/hypr/custom/keybinds.lua", { description = "Edit user keybinds" })
hl.config {
  input = {
    kb_layout = "pl",
    kb_options = "caps:escape",
  },
}

for i = 1, 4 do
  local arrowkey = { "H", "L", "K", "J" }
  local focusdir = { "l", "r", "u", "d" }
  hl.unbind("SUPER + " .. arrowkey[i])
  hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus { direction = focusdir[i] }, { description = "Window: Focus " .. arrowkey[i] })
end

hl.unbind "SUPER + SHIFT + L"
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd "loginctl lock-session", { description = "Session: Lock" })
