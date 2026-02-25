#!/usr/bin/env bash
# first-boot.sh
# Minimal provisioning script for Tart VMs.
# Executed once after clone via SSH from the host.

set -euo pipefail

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
# Remove default desktop widgets
/usr/libexec/PlistBuddy -c "Delete :widgets:instances" "$HOME/Library/Containers/com.apple.notificationcenterui/Data/Library/Preferences/com.apple.notificationcenterui.plist"
/usr/libexec/PlistBuddy -c "Add :widgets:instances array" "$HOME/Library/Containers/com.apple.notificationcenterui/Data/Library/Preferences/com.apple.notificationcenterui.plist"

killall Dock
killall NotificationCenter

echo "System preferences set."

# ---------------------------------------------------------------------------
# Dock
# ---------------------------------------------------------------------------
echo "Configuring Dock..."
brew install dockutil
dockutil --remove all --no-restart
dockutil --add /Applications/Safari.app --no-restart
dockutil --add "/System/Applications/System Settings.app" --no-restart
dockutil --add /System/Applications/Utilities/Terminal.app
dockutil --add "/Volumes/My Shared Files/Shared" --section others --no-restart
dockutil --add $HOME/Downloads --section others
echo "Dock configured."

# ---------------------------------------------------------------------------
# Dotfiles
# ---------------------------------------------------------------------------
echo "Symlinking dotfiles..."
ln -sf "/Volumes/My Shared Files/Shared/.zshrc" $HOME/.zshrc
ln -sf "/Volumes/My Shared Files/Shared/.aliases" $HOME/.aliases
ln -sf "/Volumes/My Shared Files/Shared/.functions" $HOME/.functions
echo "Dotfiles applied."

# ---------------------------------------------------------------------------
echo "First boot provisioning complete. Ready for enrollment."
