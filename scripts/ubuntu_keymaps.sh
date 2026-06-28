#!/bin/bash

# ============================================
# Ubuntu Key Configuration
# ============================================
# 1. keyd: physical Win ↔ Alt swap + Super layer → Ctrl shortcuts
# 2. gsettings: disable Super key overview + clear Super-related shell keybindings

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KEYD_CONF="$SCRIPT_DIR/keyd.conf"
KEYD_TARGET="/etc/keyd/default.conf"

# ============================================
# Part 1: keyd — physical key remapping
# ============================================

# --- Install keyd if not present ---
if ! command -v keyd &>/dev/null; then
    echo "[keyd] Installing..."
    sudo apt update
    sudo apt install -y keyd
    echo "[keyd] installed successfully."
fi

# --- Deploy keyd configuration ---
echo "[keyd] Deploying configuration to $KEYD_TARGET ..."
sudo cp "$KEYD_CONF" "$KEYD_TARGET"

# --- Enable and start keyd service ---
echo "[keyd] Enabling and reloading service..."
sudo systemctl enable keyd
sudo systemctl restart keyd

# ============================================
# Part 2: gsettings — disable Super key system shortcuts
# ============================================

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

# ============================================
# Summary
# ============================================
echo ""
echo "Done. Key mapping summary:"
echo "  [keyd]   Physical Win  → Left Alt"
echo "  [keyd]   Physical Alt  → Super (Meta layer)"
echo "  [keyd]   Super+c/v/x/a/z → Ctrl+c/v/x/a/z"
echo "  [gconf]  Super key overview disabled"
echo "  [gconf]  Super+N dock shortcuts cleared"
echo ""
echo "To verify keyd is active:  sudo keyd -t"
echo "To verify Super bindings:  gsettings list-recursively org.gnome.mutter | grep overlay"
