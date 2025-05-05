#!/usr/bin/env zsh 

# check to see if dockutil was installed manually
if [[ -x "/usr/local/bin/dockutil" ]]; then
  dockutil="usr/local/bin/dockutil"
fi

# check to see if dockutil was installed via Homebrew
if [[ -x "/opt/homebrew/bin/dockutil" ]]; then
  dockutil="/opt/homebrew/bin/dockutil"
fi

# clear existing dock
dockutil --remove all --no-restart

# full path to Applications to add to the Dock
apps=(
  "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app/"
  "/System/Applications/System Settings.app"
  "/System/Applications/Utilities/Terminal.app"
  "/Applications/Self Service.app"
  "/Applications/Self Service+.app"
)

# loop through apps to add them to the dock
for app in "${apps[@]}"; do
  dockutil --add "$app" --position end --no-restart
done

# add ~/Downloads to the dock
dockutil --add ~/Downloads --view list --display folder --sort dateadded --no-restart

# disable show recent
defaults write com.apple.dock show-recents -bool FALSE

# kill dock to apply new settings
killall -KILL Dock
