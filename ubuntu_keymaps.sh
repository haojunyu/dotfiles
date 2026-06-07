#!/bin/bash

# ============================================
# Ubuntu Super Key Configuration
# ============================================
# Swap Super (133) and Left Alt (64) to match Mac key habits (Ctrl-Super-Alt → Ctrl-Alt-Super)
# and disable all Super-related system shortcuts so Neovim's <D-*> mappings work without interference.

# --- Swap Super and Left Alt in XKB keycodes ---
# <LWIN> = 64;  # Super → Left Alt
# <LALT> = 133; # Left Alt → Super
# Note: Requires editing /usr/share/X11/xkb/keycodes/evdev manually (sudo needed)
# This script handles the gsettings side; the XKB keycode swap must be done separately.

# --- Disable Super key overview (activity display) ---
gsettings set org.gnome.mutter overlay-key ''

# --- Clear all Super-related shell keybindings ---
# Clear dash-to-dock app launcher shortcuts (Super+1 through Super+9 and variants)
for i in {1..9}; do
    gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-"$i" "@as []"
    gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-"$i" "@as []"
    gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-"$i" "@as []"
    gsettings set org.gnome.shell.keybindings open-new-window-application-"$i" "@as []"
    gsettings set org.gnome.shell.keybindings switch-to-application-"$i" "@as []"
done

echo "Ubuntu Super key shortcuts disabled."
echo "To verify remaining Super bindings, run:"
echo "  gsettings list-recursively org.gnome.mutter | grep overlay"
echo "  gsettings list-recursively org.gnome.shell.keybindings | grep -i super"
echo "  gsettings list-recursively org.gnome.shell.extensions.dash-to-dock | grep -i super"





