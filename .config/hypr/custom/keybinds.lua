hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd "xdg-open ~/.config/hypr/custom/keybinds.lua", { description = "Edit user keybinds" })
hl.config {
  input = {
    kb_layout = "pl",
    kb_options = "caps:escape",
  },
}
