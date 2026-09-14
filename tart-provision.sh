#!/usr/bin/env bash
# first-boot.sh
# Minimal provisioning script for Tart VMs.
# Executed once after clone via SSH from the host.

set -euo pipefail

# ---------------------------------------------------------------------------
# Guest OS report
# Useful when you have 26 and 27 VMs side by side.
# ---------------------------------------------------------------------------
echo "Provisioning $(sw_vers -productName) $(sw_vers -productVersion) ($(sw_vers -buildVersion))"

# ---------------------------------------------------------------------------
# Clock sync
# Note: systemsetup throws Error:-99 in virtualized macOS environments but
# operations succeed regardless. Errors suppressed with 2>/dev/null.
# ---------------------------------------------------------------------------
echo "Syncing clock..."
sudo systemsetup -setnetworktimeserver time.apple.com 2>/dev/null
sudo systemsetup -setusingnetworktime on 2>/dev/null
sudo sntp -sS time.apple.com
sudo systemsetup -settimezone "America/Chicago" 2>/dev/null
echo "Clock synced: $(date)"

# ---------------------------------------------------------------------------
# Hostname
# ---------------------------------------------------------------------------
echo "Setting hostname..."
SERIAL=$(system_profiler SPHardwareDataType | awk '/Serial Number/ {print $NF}')
HOSTNAME="tart-$SERIAL"
sudo scutil --set HostName "$HOSTNAME"
sudo scutil --set LocalHostName "$HOSTNAME"
sudo scutil --set ComputerName "$HOSTNAME"
echo "Hostname set to: $HOSTNAME"

# ---------------------------------------------------------------------------
# System preferences
# ---------------------------------------------------------------------------
echo "Setting system preferences..."

# Disable click wallpaper to show desktop
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
# Disable desktop widgets
defaults write com.apple.WindowManager StandardHideWidgets -bool true

# Remove default desktop widgets.
# Guarded: the plist may be absent on a fresh image, and the key path is not
# contractual across macOS releases — a layout change here should not abort
# the whole provision run (set -e).
NC_PLIST="$HOME/Library/Containers/com.apple.notificationcenterui/Data/Library/Preferences/com.apple.notificationcenterui.plist"
if [[ -f "$NC_PLIST" ]]; then
  /usr/libexec/PlistBuddy -c "Delete :widgets:instances" "$NC_PLIST" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :widgets:instances array" "$NC_PLIST" 2>/dev/null || true
else
  echo "  note: notificationcenterui plist not present, skipping widget cleanup"
fi

# Tolerate missing processes (e.g. under --no-graphics).
killall Dock 2>/dev/null || true
killall NotificationCenter 2>/dev/null || true

echo "System preferences set."

# ---------------------------------------------------------------------------
# Dock
# ---------------------------------------------------------------------------
echo "Configuring Dock..."
brew install dockutil
dockutil --remove all --no-restart

# App bundle paths move between macOS releases (Safari in particular has
# shuffled between /Applications and /System/Applications), so resolve each
# one before adding it rather than assuming.
add_first_present() {
  local app
  for app in "$@"; do
    if [[ -d "$app" ]]; then
      dockutil --add "$app" --no-restart
      return 0
    fi
  done
  echo "  note: none of these were found, skipping: $*"
}

add_first_present "/Applications/Safari.app" "/System/Applications/Safari.app"
add_first_present "/System/Applications/System Settings.app"
add_first_present "/System/Applications/Utilities/Terminal.app"

if [[ -d "/Volumes/My Shared Files/Shared" ]]; then
  dockutil --add "/Volumes/My Shared Files/Shared" --section others --no-restart
else
  echo "  note: shared folder not mounted, skipping Dock entry"
fi
dockutil --add "$HOME/Downloads" --section others
echo "Dock configured."

# ---------------------------------------------------------------------------
# Dotfiles
# ---------------------------------------------------------------------------
echo "Symlinking dotfiles..."
SHARED="/Volumes/My Shared Files/Shared"
if [[ -d "$SHARED" ]]; then
  for dotfile in .zshrc .aliases .functions; do
    ln -sf "$SHARED/$dotfile" "$HOME/$dotfile"
  done
  echo "Dotfiles applied."
else
  echo "  warning: '$SHARED' not mounted — dotfiles NOT linked."
  echo "  Did the VM start without --dir=Shared:\$HOME/tart-shared?"
fi

# ---------------------------------------------------------------------------
echo "First boot provisioning complete. Ready for enrollment."
